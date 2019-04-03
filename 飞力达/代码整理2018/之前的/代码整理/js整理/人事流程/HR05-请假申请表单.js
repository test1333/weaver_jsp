<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    1.1)开始日期: 手工填写，只限同一考勤周期或下一考勤周期
    结束日期:手工填写，不能早于开始日期
    1.2)
    选择，事假、病假、年假、公假、婚假、产假、产检假、护理假、丧假、工伤假、旅游假、调休
    （选择事假的时候，要提醒年假结余，优先选择年假，会提醒先用年假，并最小0.5天）
    1.3)代理内容按钮链接: 链接代理设置页面

    1.	假别类型: 病假(0200)、婚假(0500)、产检假(1200)、计划生育假(1300)、护理假(1400)、
    丧假(0600)、工伤假(0300)、产假(0700)、探亲假(0400)需要检查必须要上传相关文件。
    1.病假(0200)不需要设置限制上传附件。长期病假(0210)需要限制上传附件。
    2.探亲假(0400)不需要限制上传附件.
    3. 丧假(0600) 不需要限制上传附件.


    */
    var bufferDays = 4; //允许提交申请的时间控制（自然日）
    var id_sqrq = "#field6504"; //申请日期

    var id_ksrq = "#field6565"; //开始日期
    var id_jsrq = "#field6582"; //结束日期
    var id_kssj = "#field6581"; //开始时间
    var id_jssj = "#field6669"; //结束时间

    var id_jybj = "#field10409"; //校验标记
    var id_jyxx = "#field10410"; //校验信息

    var id_qjsc = "#field10020";  //请假时长
    var id_qjlx = "#field7661";  //请假类型
    var id_qjrgh = "#field6524";  //请假人工号


    checkCustomize = function () {
        var isSuccess = true;



        var i_sqrq = $(id_sqrq); //申请日期

        var i_ksrq = $(id_ksrq); //开始日期
        var i_jsrq = $(id_jsrq); //结束日期
        var i_kssj = $(id_kssj); //开始时间
        var i_jssj = $(id_jssj); //结束时间


        /*
        20161220变更，取消原对考勤周期的管控，改为4个自然日管控

        //计算考勤周期
        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25"));

        var date3 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/26"));
        var date4 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 2 : 1).Format("yyyy/MM/25"));

        var d1 = new Date(i_ksrq.val().replace(/-/g, "/"));
        var d2 = new Date(i_jsrq.val().replace(/-/g, "/"));

        //开始日期: 手工填写，只限同一考勤周期或下一考勤周期
        if ((i_ksrq.val() == "") || (date1 <= d1 && d1 <= date2) || (date3 <= d1 && d1 <= date4)) { } else {
        window.top.Dialog.alert("开始日期" + d1.Format("yyyy-MM-dd") + "不在当前周期（" + date1.Format("yyyy-MM-dd") + " - " + date2.Format("yyyy-MM-dd") + "）或下一周期（" + date3.Format("yyyy-MM-dd") + " - " + date4.Format("yyyy-MM-dd") + "）内！");
        isSuccess = false;
        return false;
        }

        */

        //4个自然日管控

        var d1 = new Date(i_ksrq.val().replace(/-/g, "/")); //开始日期
        var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //申请日期
        if (d1.addDays(bufferDays) < d2) {
            window.top.Dialog.alert("超出允许申请日期范围，仅允许提交" + bufferDays + "天内的申请！");
            isSuccess = false;
            return false;

        }




        //结束日期:手工填写，不能早于开始日期
        var datetime1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var datetime2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));
        var ct = datetime1.dateDiff("s", datetime2)
        if ((i_ksrq.val() == "") || (i_jsrq.val() == "") || (datetime1 <= datetime2)) { } else {
            window.top.Dialog.alert("结束日期+结束时间必须晚于开始日期+开始时间！");
            isSuccess = false;
            return false;
        }

        if ("S" != $(id_jybj + "span").text()) {
            if ($(id_jyxx + "span").text() == "") {
                window.top.Dialog.alert("请校验请假时长！");
            } else {
                window.top.Dialog.alert($(id_jyxx + "span").text());

            }
            isSuccess = false;
            return false;

        }

        //选择，事假、病假、年假、公假、婚假、产假、产检假、护理假、丧假、工伤假、旅游假、调休
        //（选择事假的时候，要提醒年假结余，优先选择年假，会提醒先用年假，并最小0.5天）
        /*
        序号	字段描述	字段编码
        1	年休假	0100
        2	病假	0200
        3	长期病假	0210
        4	工伤假	0300
        5	探亲假	0400
        6	婚假	0500
        7	丧假	0600
        8	产假	0700
        9	事假	0800
        10	旷工	0900
        11	调休假	1000
        12	公假	1100
        13	产检假	1200
        14	计划生育假	1300
        15	护理假	1400
        16	旅游假	1500
        17	哺乳假	1600
        18	测试假	1700
        19	本地出差	2000
        20	境内出差	2001
        21	境外出差	2100
        */
        var i_qjlx = $("#field7661"); //请假类型
        var i_njjy = $("#field6871"); //年假结余
        var i_lyjjy = $("#field6735"); //旅游假结余
        var i_txjjy = $("#field7023"); //调休假结余
        var i_qjsc = $("#field10020"); //请假时长


        var i_qjrgh = $("#field6524"); //请假人工号
        var i_dlrgh = $("#field6739"); //代理人工号

        var v_njjy = i_njjy.val() == "" ? 0 : parseFloat(i_njjy.val());
        var v_lyjjy = i_lyjjy.val() == "" ? 0 : parseFloat(i_lyjjy.val());
        var v_txjjy = i_txjjy.val() == "" ? 0 : parseFloat(i_txjjy.val());

        v_njjy = v_njjy * 8; //折算为小时
        v_lyjjy = v_lyjjy * 8; //折算为小时
        v_txjjy = v_txjjy * 8; //折算为小时

        var v_qjsc = i_qjsc.val() == "" ? 0 : parseFloat(i_qjsc.val());
        if (i_qjlx.val() == "0800") {
            //事假
            if (v_njjy > 0 && v_qjsc >= 4) {
                window.top.Dialog.alert("年假结余，请选择年假！");
                isSuccess = false;
                return false;
            }
        } else if (i_qjlx.val() == "0100") {
            //年休假
            if (v_qjsc < 4 || v_qjsc % 4 > 0) {
                window.top.Dialog.alert("请假时长最小0.5天（4小时）且为4的倍数！");
                isSuccess = false;
                return false;
            }
            if (v_qjsc > v_njjy) {
                window.top.Dialog.alert("年假结余不足！");
                isSuccess = false;
                return false;
            }
        } else if (i_qjlx.val() == "1500") {
            //旅游假
            if (v_qjsc > v_lyjjy) {
                window.top.Dialog.alert("旅游假结余不足！");
                isSuccess = false;
                return false;
            }
            if (v_qjsc != v_lyjjy) {
                window.top.Dialog.alert("旅游假必须一次性使用！");
                isSuccess = false;
                return false;
            }
        }
        else if (i_qjlx.val() == "1000") {
            //调休假
            if (v_qjsc > v_txjjy) {
                window.top.Dialog.alert("调休假结余不足！");
                isSuccess = false;
                return false;
            }
        } else if (i_qjlx.val() == "0210"
        || i_qjlx.val() == "0500"
        || i_qjlx.val() == "1200"
        || i_qjlx.val() == "1300"
        || i_qjlx.val() == "1400"
        || i_qjlx.val() == "0300"
        || i_qjlx.val() == "0700"
        ) {
            //1.	假别类型: 病假(0200)、婚假(0500)、产检假(1200)、计划生育假(1300)、护理假(1400)、丧假(0600)、工伤假(0300)、产假(0700)、探亲假(0400)需要检查必须要上传相关文件。

            if ($("#fsUploadProgress6741 div.progressWrapper:visible").length == 0) {
                //window.top.Dialog.alert("请上传相关文件！");
                //isSuccess = false;
                //return false;

            }
        }


        if (i_qjrgh.val() == i_dlrgh.val()) {
            window.top.Dialog.alert("不允许本人代理！");
            isSuccess = false;
            return false;

        }
        return isSuccess;
    }

    var resetCheck = function () {
        $(id_jybj).val("");
        $(id_jybj + "span").text("");
        $(id_jyxx).val("");
        $(id_jyxx + "span").text("");
    }

    var resetQJSS = function () {
        if ($(id_ksrq).val() == ""
        || $(id_jsrq).val() == ""
        || $(id_kssj).val() == ""
        || $(id_jssj).val() == ""
        || $(id_qjlx).val() == ""
        || $(id_qjrgh).val() == ""
        ) {
            $(id_qjsc).closest("td>div").hide();
        } else {
            $(id_qjsc).closest("td>div").show();

        }

    }



    jQuery(document).ready(function () {
        jQuery(id_ksrq).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //开始日期
        jQuery(id_jsrq).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //结束日期
        jQuery(id_kssj).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //开始时间
        jQuery(id_jssj).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //结束时间

        jQuery(id_qjlx).bindPropertyChange(function () { resetQJSS(); }); //请假类型
        jQuery(id_qjrgh).bindPropertyChange(function () { resetQJSS(); }); //请假人工号
        resetCheck();
        resetQJSS();
    });



</script>



