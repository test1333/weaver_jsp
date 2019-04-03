<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    需求1：
    页面日期时间字段的前后关系判断.
    开始日期: 只限同一考勤周期或下一考勤周期。一个考勤周期是26～25号
    结束日期: 不能早于开始日期也不可以超过一天

    需求2：
    结算方式根据员工行政等级OA自动显示：1、调休2、加班费（5级及以上:只能带出调休，5级以下的默认加班费）

    需求3：
    1. 扣餐时数:默认为1; 加班时数大于等于5小时，扣餐时数必填且不能为0。保安保安根据“职务（保安或保安班长）”判断，可自愿扣不扣(可以输入0)
    2. 计餐次:扣餐时数0.5小时计1次；扣1.5小时计2次；扣1小时，判断时间开始时间8：00到12：:00之间是1，之外是2。
    3. 申请加班时数自动计算：根据结束日期(结束时间)-起始日期(起始时间)- 扣餐时数

    NEW:
    1、职务为保安员和保安班长，扣餐时数和计餐次默认为0，且可手选；
    2、行政等级1-4级，默认结算方式为加班费，可手选调休；5级及以上，结算方式为调休，且不可手选；
    
    3、加班类型为普通加班（1），扣餐时数手选为0.5，计餐次1；扣餐时数手选为0，计餐次0；   --  其他不能选
    4、加班类型为公休加班（2）和节日加班（3），加班开始时间8：00-11：59，申请加班总时长小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选；
    5、加班类型为公休加班（2）和节日加班（3），加班开始时间8：00-11：59，申请加班总时长大于等于5H小于11.5H,扣餐时为1，计餐次为1，扣餐时数和计餐次均不可手选；
    6、加班类型为公休加班（2）和节日加班（3），加班开始时间8：00-11：59，申请加班总时长大于等于11.5,扣餐时为1.5，计餐次为2，扣餐时数和计餐次均不可手选；
    7、加班类型为公休加班（2）和节日加班（3），加班开始时间12:00-21:59，申请加班总时小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选；
    8、加班类型为公休加班（2）和节日加班（3），加班开始时间12:00-21:59，申请加班总时大于等于5H小于11.5H,扣餐时为0.5，计餐次为1，扣餐时数和计餐次均不可手选；
    9、加班类型为公休加班（2）和节日加班（3），加班开始时间12:00-21:59，申请加班总时大于等于11.5H,扣餐时为1，计餐次为2，扣餐时数和计餐次均不可手选；
    10、加班类型为公休加班（2）和节日加班（3），加班开始时间22:00-07:59，扣餐时数和计餐次默认为0，且可手选；


    20160912
    1.控制加班申请单明细表中只能输入同一类型的加班。加班类型编码有:1非假日加班;2,3为假日加班
    1是一类;2,3是另一类

    2.单身输入完毕后将加班类型更新到表头如下字段中 .(1.更新为非假日加班;2,3更新为假日加班)

    20160916
    1.员工工号是必填项，建议设置成根据姓名自动显示；
    2.行政等级5级以上，结算方式可以进行选择，需要限制限制，默然为调休
    3.行政等级5级以下节日加班可以选择调休，需要默认加班费；
    4.班别不会自动显示，需要自动显示；
    5.申请加班时数不会自动显示，提交以后才会显示，需要自动显示



    */
    var bufferDays = 4;
    var id_sqrq = "#field6538"; //申请日期

    var arr_xzdj = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "C", "B", "A"];

    var checkDate = function () {
        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25"));
        var isSuccess = true;
        var flag_jblx = ""; //加班类型标识
        $("td[name='td_ksrq']").each(function () {

            /*
            页面日期时间字段的前后关系判断.
            开始日期: 只限同一考勤周期或下一考勤周期。一个考勤周期是26～25号
            结束日期: 不能早于开始日期也不可以超过一天
            */
            var td_bDate = $(this);
            var tr = td_bDate.closest("tr");

            if (handleDTChange(tr) == false) {
                isSuccess = false;
                return false;
            }

            var i_sqjbss = tr.find("td[name='td_sqjbss'] input[type='hidden']");
            var ct = parseInt(i_sqjbss.val());

            /*
            扣餐时数:默认为1; 
            加班时数大于等于5小时，扣餐时数必填且不能为0。
            保安保安根据“职务（保安或保安班长）”判断，可自愿扣不扣(可以输入0)
            */
            var i_kcss = tr.find("td[name='td_kcss'] select option:selected");
            var span_zhiwu = tr.find("td[name='td_zhiwu'] span");
            var v_kcss = i_kcss.text();
            var v_zhiwu = span_zhiwu.text();
            v_kcss = isNaN(v_kcss) ? 0 : parseFloat(v_kcss);
            //            if (ct >= 5 && v_kcss =="0" && v_zhiwu.indexOf("保安") < 0) {
            //                window.top.Dialog.alert("加班时数大于等于5小时，扣餐时数必填且不能为0(除保安或保安班长）");

            //                isSuccess = false;
            //                return false;
            //            }

            /*
            自动计算记餐次
            */
            if (setJcc(tr) == false) {
                isSuccess = false;
                return false;
            }


            //结算方式根据员工行政等级OA自动显示：
            //1、调休2、加班费（5级及以上:只能带出调休，5级以下的默认加班费）
            var i_xzdj = tr.find("td[name='td_xzdj'] input");
            var v_xzdj = isNaN(i_xzdj.val()) ? 0 : parseInt(i_xzdj.val());

            var i_jsfs = tr.find("td[name='td_jsfs'] select");
            var v_jsfs = i_jsfs.find("option:selected").text();

            if (v_xzdj >= 5 && v_jsfs == "加班费") {
                window.top.Dialog.alert("5级及以上只能选择调休");
                isSuccess = false;
                return false;
            }


            //加班类型
            var i_jblx = tr.find("td[name='td_jblx'] input");
            if (i_jblx.val() == "") {
                window.top.Dialog.alert("请选择加班类型！");
                isSuccess = false;
                return false;
            }
            var v_jblx = i_jblx.val() == "1" ? "1" : "2";

            if (flag_jblx == v_jblx) { } else {
                if (flag_jblx == "") {
                    flag_jblx = v_jblx;
                } else {
                    window.top.Dialog.alert("加班类型不一致！");
                    isSuccess = false;
                    return false;

                }
            }

        });

        $("#field9574").val(flag_jblx);
        if (isSuccess) {
            return true;
        }
        return (false);
    }


    //设置记餐次
    /*
    计餐次:扣餐时数0.5小时计1次；扣1.5小时计2次；扣1小时，判断时间开始时间8：00到12：:00之间是1，之外是2。

    3、加班类型为普通加班（1），扣餐时数手选为0.5，计餐次1；扣餐时数手选为0，计餐次0；

    4、加班类型为公休加班（2）和节日加班（3），加班开始时间8：00-11：59，
    申请加班总时长小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选；
    5、加班类型为公休加班（2）和节日加班（3），加班开始时间8：00-11：59，
    申请加班总时长大于等于5H小于11.5H,扣餐时为1，计餐次为1，扣餐时数和计餐次均不可手选；
    6、加班类型为公休加班（2）和节日加班（3），加班开始时间8：00-11：59，
    申请加班总时长大于等于11.5,扣餐时为1.5，计餐次为2，扣餐时数和计餐次均不可手选；
    7、加班类型为公休加班（2）和节日加班（3），加班开始时间12:00-21:59，
    申请加班总时小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选；
    8、加班类型为公休加班（2）和节日加班（3），加班开始时间12:00-21:59，
    申请加班总时大于等于5H小于11.5H,扣餐时为0.5，计餐次为1，扣餐时数和计餐次均不可手选；
    9、加班类型为公休加班（2）和节日加班（3），加班开始时间12:00-21:59，
    申请加班总时大于等于11.5H,扣餐时为1，计餐次为2，扣餐时数和计餐次均不可手选；
    10、加班类型为公休加班（2）和节日加班（3），加班开始时间22:00-07:59，扣餐时数和计餐次默认为0，且可手选；

    */
    var setJcc = function (tr) {
        var i_kcss = $(tr).find("td[name='td_kcss'] select");
        var i_jcc = $(tr).find("td[name='td_jcc'] input");
        var v_kcss = i_kcss.find("option:selected").text();


        var i_jblx = tr.find("td[name='td_jblx'] input[type='hidden']"); //加班类型
        var v_jblx = i_jblx.val(); //加班类型
        var v = 1;

        var span_zhiwu = tr.find("td[name='td_zhiwei'] span");
        var v_zhiwu = span_zhiwu.text();
        if (v_zhiwu.indexOf("保安") >= 0) {
            return true;
        }

        //alert(v_jblx);
        if (v_jblx == "1") {//普通加班（1），扣餐时数手选为0.5，计餐次1,对应的；扣餐时数手选为0，计餐次0


            if (v_kcss == "0.5") {
                v = 1;
            } else if (v_kcss == "0") {
                v = 0;
            } else {
                v = 1;
                v_kcss = "0.5";
                i_kcss.find("option").each(function () {
                    if (v_kcss == $(this).text()) {
                        $(this).attr("selected", "selected");
                    } else {
                        $(this).attr("selected", null);
                    }
                });

                //window.top.Dialog.alert("普通加班,扣餐时数只允许选择 0.5 或 0 ！");
                //return false;
            }
            i_jcc.val(v);
        } else {
            //公休加班（2）和节日加班（3）
            var i_kssj = tr.find("td[name='td_kssj'] input[type='hidden']"); //开始时间
            var v_kssj = i_kssj.val();
            var i_sqjbss = tr.find("td[name='td_sqjbss'] input[type='hidden']"); //申请加班时数
            var v_sqjbss = parseFloat(i_sqjbss.val());
            //if (isNaN(v_sqjbss)) { v_sqjbss = 0; }
            if ("08:00" <= v_kssj && v_kssj <= "11:59") {
                /*
                4、加班开始时间8：00-11：59，
                申请加班总时长小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选；
                申请加班总时长大于等于5H小于11.5H,扣餐时为1，计餐次为1，扣餐时数和计餐次均不可手选；
                申请加班总时长大于等于11.5,扣餐时为1.5，计餐次为2，扣餐时数和计餐次均不可手选；
                */
                if (v_sqjbss < 5) {
                    if (v_kcss != "0") {
                        //window.top.Dialog.alert("申请加班总时长小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选！");
                        //return false;
                        v = 0;
                        v_kcss = "0";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 0;
                    }
                } else if (5 <= v_sqjbss && v_sqjbss < 11.5) {
                    if (v_kcss != "1") {
                        //window.top.Dialog.alert("申请加班总时长大于等于5H小于11.5H,扣餐时为1，计餐次为1，扣餐时数和计餐次均不可手选！");
                        //return false;
                        v = 1;
                        v_kcss = "1";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 1;
                    }
                } else {
                    if (v_kcss != "1.5") {
                        //window.top.Dialog.alert("申请加班总时长大于等于11.5,扣餐时为1.5，计餐次为2，扣餐时数和计餐次均不可手选！");
                        //return false;
                        v = 2;
                        v_kcss = "1.5";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 2;
                    }
                }
                i_jcc.val(v);

            } else if ("12:00" <= v_kssj && v_kssj <= "21:59") {
                /*
                7、加班开始时间12:00-21:59，
                申请加班总时小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选；
                申请加班总时大于等于5H小于11.5H,扣餐时为0.5，计餐次为1，扣餐时数和计餐次均不可手选；
                申请加班总时大于等于11.5H,扣餐时为1，计餐次为2，扣餐时数和计餐次均不可手选；
                */
                if (v_sqjbss < 5) {
                    if (v_kcss != "0") {
                        //window.top.Dialog.alert("申请加班总时小于5H,扣餐时为0，计餐次为0，扣餐时数和计餐次均不可手选！");
                        //return false;
                        v = 0;
                        v_kcss = "0";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 0;
                    }
                } else if (5 <= v_sqjbss && v_sqjbss < 11.5) {
                    if (v_kcss != "0.5") {
                        //window.top.Dialog.alert("申请加班总时大于等于5H小于11.5H,扣餐时为0.5，计餐次为1，扣餐时数和计餐次均不可手选！");
                        //return false;
                        v = 1;
                        v_kcss = "0.5";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 1;
                    }
                } else {
                    if (v_kcss != "1") {
                        //window.top.Dialog.alert("申请加班总时大于等于11.5H,扣餐时为1，计餐次为2，扣餐时数和计餐次均不可手选！");
                        //return false;
                        v = 2;
                        v_kcss = "1";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 2;
                    }
                }
                i_jcc.val(v);
            } else {
                /*10、加班开始时间22:00-07:59，扣餐时数和计餐次默认为0，且可手选；*/

            }


        }
        //i_jcc.val(v);

        //        var v = 1;
        //        if (v_kcss == "0.5") {
        //            v = 1;
        //        } else if (v_kcss == "1.5") {
        //            v = 2;
        //        } else if (v_kcss == "1") {
        //            var i_bTime = $(tr).find("td[name='td_beginTime'] input");
        //            var v_bTime = i_bTime.val();
        //            if ("08:00" <= v_bTime && v_bTime <= "12:00") {
        //                v = 1;
        //            } else {
        //                v = 2;
        //            }
        //        } else {
        //            v = 0;
        //        }
        //        i_jcc.val(v);

        return true;
    }

    var handleXZDJChange = function (_tr) {
        var tr = $(_tr);
        var i_xzdj = tr.find("td[name='td_xzdj'] input"); //行政等级
        var i_jsfs = tr.find("td[name='td_jsfs'] input[id^='field8599_'][type='hidden']"); //结算方式
        var s_jsfs = $("#" + i_jsfs.attr("id") + "span"); //结算方式

        var i_jsfsms = tr.find("td[name='td_jsfsms'] input"); //结算方式描述
        var s_jsfsms = tr.find("td[name='td_jsfsms'] span"); //结算方式描述

        var v_xzdj = -1;
        for (i = 0; i < arr_xzdj.length; i++) {
            if (arr_xzdj[i] == i_xzdj.val()) {
                v_xzdj = i;
            }
        }

        //1、调休2、加班费（5级及以上:只能带出调休，5级以下的默认加班费）
        if (v_xzdj >= 4) {
            i_jsfs.val("3");
            i_jsfsms.val("调休");
            s_jsfs.empty().append($('<span class="e8_showNameClass">'
                                + '3<span class="e8_delClass" id="1" onclick="del(event,this,1,false,{});" style="opacity: 0;'
                                    + 'visibility: hidden;">&nbsp;x&nbsp;</span></span>'));
            s_jsfsms.text("调休");

        } else {
            i_jsfs.val("1");
            i_jsfsms.val("加班费");
            s_jsfs.empty().append($('<span class="e8_showNameClass">'
                                + '1<span class="e8_delClass" id="1" onclick="del(event,this,1,false,{});" style="opacity: 0;'
                                    + 'visibility: hidden;">&nbsp;x&nbsp;</span></span>'));
            s_jsfsms.text("加班费");

        }
    }


    var handleJSFSCheck = function (_tr) {
        var tr = $(_tr);
        var i_xzdj = tr.find("td[name='td_xzdj'] input"); //行政等级
        var i_jsfs = tr.find("td[name='td_jsfs'] input[id^='field8599_'][type='hidden']"); //结算方式
        var s_jsfs = $("#" + i_jsfs.attr("id") + "span"); //结算方式

        var i_jsfsms = tr.find("td[name='td_jsfsms'] input"); //结算方式描述
        var s_jsfsms = tr.find("td[name='td_jsfsms'] span"); //结算方式描述

        var v_xzdj = -1;
        for (i = 0; i < arr_xzdj.length; i++) {
            if (arr_xzdj[i] == i_xzdj.val()) {
                v_xzdj = i;
            }
        }

        //1、调休2、加班费（5级及以上:只能带出调休，5级以下的默认加班费）
        if (v_xzdj >= 4) {
            if ("3" != i_jsfs.val()) {
                i_jsfs.val("3");
                i_jsfsms.val("调休");
                s_jsfs.empty().append($('<span class="e8_showNameClass">'
                                + '3<span class="e8_delClass" id="1" onclick="del(event,this,1,false,{});" style="opacity: 0;'
                                    + 'visibility: hidden;">&nbsp;x&nbsp;</span></span>'));
                s_jsfsms.text("调休");
                window.top.Dialog.alert("5级及以上只能选择调休");

                return false;
            }
        }
    }


    var handleZWChange = function (_tr) {
        var tr = $(_tr);
        var i_zhiwu = tr.find("td[name='td_zhiwu'] span"); //职务
        var i_kcss = $(tr).find("td[name='td_kcss'] select");
        var i_jcc = $(tr).find("td[name='td_jcc'] input");
        if (i_zhiwu.text().indexOf("保安") >= 0) {
            i_kcss.val("1");
            i_jcc.val(0);
        }
    }


    var handleDTChange = function (_tr) {
        var tr = $(_tr);
        var i_ksrq = tr.find("td[name='td_ksrq'] input[type='hidden']"); //开始日期
        var i_kssj = tr.find("td[name='td_kssj'] input[type='hidden']"); //开始时间
        var i_jsrq = tr.find("td[name='td_jsrq'] input[type='hidden']"); //结束日期
        var i_jssj = tr.find("td[name='td_jssj'] input[type='hidden']"); //结束时间

        var i_sqjbss = tr.find("td[name='td_sqjbss'] input[type='hidden']"); //申请加班时数


        if (i_ksrq.val() == "" || i_kssj.val() == "" || i_jsrq.val() == "" || i_jssj.val() == "") {
            //信息未填完，跳过
            return;
        }

        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26 00:00"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25 23:59"));

        var date3 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26 00:00"));
        var date4 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25 23:59"));
        date3.addMonths(1);
        date4.addMonths(1);

        var datetime1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var datetime2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));
        var ct = datetime1.dateDiff("n", datetime2) / (60);

        ct = Math.round(ct * 100);
        ct = (ct * 0.01);
        //        if (!isNaN(ct)) {
        //            i_sqjbss.val(ct);
        //            $("#" + i_sqjbss.attr("id") + "span").text(ct);
        //        }
        /*
        if ((date1 <= datetime1 && datetime1 <= date2) || (date3 <= datetime1 && datetime1 <= date4)) { } else {
            window.top.Dialog.alert("日期" + datetime1.Format("yyyy-MM-dd") + "不在当前周期（" + date1.Format("yyyy-MM-dd") + " - " + date2.Format("yyyy-MM-dd") + "）或下一周期（" + date3.Format("yyyy-MM-dd") + " - " + date4.Format("yyyy-MM-dd") + "）内！");
            return false;
        }
        if ((date1 <= datetime2 && datetime2 <= date2) || (date3 <= datetime2 && datetime2 <= date4)) { } else {
            window.top.Dialog.alert("日期" + datetime2.Format("yyyy-MM-dd") + "不在当前周期（" + date1.Format("yyyy-MM-dd") + " - " + date2.Format("yyyy-MM-dd") + "）或下一周期（" + date3.Format("yyyy-MM-dd") + " - " + date4.Format("yyyy-MM-dd") + "）内！");
            return false;
        }
        */

        if ((0 <= ct && ct <= 48)) { } else {
            window.top.Dialog.alert("结束日期+结束时间必须晚于开始日期+开始时间，且在48小时内！");
            return false;
        }

    }

    var initDetail = function () {
        var td_kcss = $("#oTable0 td[name='td_kcss'] select:last");
        var tr = td_kcss.closest("tr");

        td_kcss.change(function () {
            setJcc($(this).closest("tr"));
        });
        var i_jblx = tr.find("td[name='td_jblx'] input[type='hidden']"); //加班类型
        jQuery("#" + i_jblx.attr("id")).bindPropertyChange(function () { setJcc(tr); });



        var i_xzdj = tr.find("td[name='td_xzdj'] input"); //行政等级
        jQuery("#" + i_xzdj.attr("id")).bindPropertyChange(function () { handleXZDJChange(tr); });

        var i_jsfs = tr.find("td[name='td_jsfs'] input[type='hidden']"); //结算方式
        jQuery("#" + i_jsfs.attr("id")).bindPropertyChange(function () { handleJSFSCheck(tr); });

        var i_ksrq = tr.find("td[name='td_ksrq'] input[type='hidden']"); //开始日期
        jQuery("#" + i_ksrq.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });
        var i_kssj = tr.find("td[name='td_kssj'] input[type='hidden']"); //开始时间
        jQuery("#" + i_kssj.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });
        var i_jsrq = tr.find("td[name='td_jsrq'] input[type='hidden']"); //结束日期
        jQuery("#" + i_jsrq.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });
        var i_jssj = tr.find("td[name='td_jssj'] input[type='hidden']"); //结束时间
        jQuery("#" + i_jssj.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });


        var i_zhiwu = tr.find("td[name='td_zhiwu'] input[type='hidden']"); //职务
        jQuery("#" + i_zhiwu.attr("id")).bindPropertyChange(function () { handleZWChange(tr); });

    }



    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $(id_sqrq);

        $("td[name='td_ksrq'] input[type='hidden']").each(function () {

            var d1 = new Date($(this).val().replace(/-/g, "/")); //开始日期
            var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //申请日期
            if (d1.addDays(bufferDays) < d2) {
                window.top.Dialog.alert("超出允许申请日期范围，仅允许提交" + bufferDays + "天内的申请！");
                isSuccess = false;
                return false;
            }


        });

        if (isSuccess) {
            isSuccess = checkDate();
        }

        return isSuccess;
    }

    jQuery(document).ready(function () {
        $("#div0button .addbtn_p").click(function () { initDetail() });
        window.setTimeout("initDetail()", 1000);
    });



</script>



