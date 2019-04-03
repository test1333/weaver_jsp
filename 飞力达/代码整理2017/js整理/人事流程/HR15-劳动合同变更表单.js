<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    根据续签年限为几年,计算出起始续签日期
    和截止续签日期。对于续签年限为无固定期限,则给定截止续签日期为99991231 转无固定期

    20160912
    1.如果选择合同到期不续签,则需要将建议中的1,2,4项隐藏。或者将其设定为不可输入。

    2.如果辞退,则需要将建议中的1,3,4项隐藏。或者将其设定为不可输入。

    3.如果选择合同续签,则需要将建议中的2,3,4项隐藏。或者将其设定为不可输入。

    4.如果选择退休或退休返聘,则需要将建议中的1,2,3项隐藏。或者将其设定为不可输入。


    20160914
    劳动合同变更单中对于4:退休返聘考核 有加入了起始续签日期,截止续签日期。
    其中这两个字段的计算方式如下所示:
    起始续签日期:劳动合同结束日期+1
    终止日期为当月1-14，修正为上月最后一天
    终止日期大于14，修正为当月月底

    20160930
    劳动合同变更表单新增JS控制如下:如果编码编码选择:4,则最下面的建议项都设定为不可输入。
         
    */


    checkCustomize = function () {
        var isSuccess = true;
        return isSuccess;
    }

    var id_bgbm = "#field8539"; //变更编码
    var id_bgms = "#field8540"; //变更描述

    //建议
    var id_tyxqnx = "#field6675"; //同意续签年限
    var id_qsxqrq = "#field7181"; //起始续签日期
    var id_jzxqrq = "#field7182"; //截止续签日期 

    var id_jjbcj1 = "#field7183"; //经济补偿金1
    var id_jjbcj2 = "#field7184"; //经济补偿金2
    var id_txfpkh = "#field9001"; //退休返聘考核 
    var id_txfpksrq = "#field10082"; //退休返聘开始日期
    var id_txfpjsrq = "#field10083"; //退休返聘结束日期

    var id_ldhtjsrq = "#field6763"; //劳动合同结束日期
    var setNX = function () {
        var i_tyxqnx = $(id_tyxqnx + " option:selected"); //同意续签年限
        var i_qsxqrq = $(id_qsxqrq); //起始续签日期
        var i_jzxqrq = $(id_jzxqrq); //截止续签日期
        var s_qsxqrq = $(id_qsxqrq + "span"); //起始续签日期
        var s_jzxqrq = $(id_jzxqrq + "span"); //截止续签日期

        var i_txfpksrq = $(id_txfpksrq); //退休返聘开始日期
        var i_txfpjsrq = $(id_txfpjsrq); //退休返聘结束日期
        var s_txfpksrq = $(id_txfpksrq + "span"); //退休返聘开始日期
        var s_txfpjsrq = $(id_txfpjsrq + "span"); //退休返聘结束日期


        var i_ldhtjsrq = $(id_ldhtjsrq); //劳动合同结束日期
        var v_ldhtjsrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/"));

        var v_qsxqrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/")).addDays(1).Format("yyyy-MM-dd");
        i_qsxqrq.val(v_qsxqrq);
        s_qsxqrq.text(v_qsxqrq);

        if (i_tyxqnx.text() == "无固定期") {
            i_jzxqrq.val("9999-12-31");
            s_jzxqrq.text("9999-12-31");
        } else if (i_tyxqnx.text().indexOf("年") > 0) {
            var v_nian = parseInt(i_tyxqnx.text().substr(0, i_tyxqnx.text().indexOf("年")));
            var v_jzxqrq = v_ldhtjsrq.addYears(v_nian).Format("yyyy-MM-dd");
            i_jzxqrq.val(v_jzxqrq);
            s_jzxqrq.text(v_jzxqrq);

        } else {
            i_qsxqrq.val("");
            i_jzxqrq.val("");
            s_qsxqrq.text("");
            s_jzxqrq.text("");

        }

    }

    var setFPNX = function () {
        var i_tyxqnx = $(id_txfpkh + " option:selected"); //退休返聘考核

        var i_txfpksrq = $(id_txfpksrq); //退休返聘开始日期
        var i_txfpjsrq = $(id_txfpjsrq); //退休返聘结束日期
        var s_txfpksrq = $(id_txfpksrq + "span"); //退休返聘开始日期
        var s_txfpjsrq = $(id_txfpjsrq + "span"); //退休返聘结束日期


        var i_ldhtjsrq = $(id_ldhtjsrq); //劳动合同结束日期
        var v_ldhtjsrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/"));

        var v_qsxqrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/")).addDays(1).Format("yyyy-MM-dd");
        var v_jsxqrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/")).addYears(1);

        if (i_tyxqnx.val() == "1") {
            var tmp_date;

            if (v_jsxqrq.getDate() > 14) {
                //修正为当月月底
                v_jsxqrq.addMonths(1);
            }
            tmp_date = new Date(v_jsxqrq.Format("yyyy/MM/01"));
            tmp_date.addDays(-1);
            v_jsxqrq = tmp_date;

            i_txfpksrq.val(v_qsxqrq);
            i_txfpjsrq.val(v_jsxqrq.Format("yyyy-MM-dd"));
            s_txfpksrq.text(v_qsxqrq);
            s_txfpjsrq.text(v_jsxqrq.Format("yyyy-MM-dd"));
        } else {
            i_txfpksrq.val("");
            i_txfpjsrq.val("");
            s_txfpksrq.text("");
            s_txfpjsrq.text("");

        }

    }

    var handleBGBM = function () {
        $(id_tyxqnx).attr("disabled", null);
        $(id_qsxqrq).attr("disabled", null);
        $(id_jzxqrq).attr("disabled", null);
        $(id_jjbcj1).attr("disabled", null);
        $(id_jjbcj2).attr("disabled", null);
        $(id_txfpkh).attr("disabled", null);
        $(id_txfpksrq).attr("disabled", null);
        $(id_txfpjsrq).attr("disabled", null);
        $(id_qsxqrq + "_tdwrap>div").show();
        $(id_jzxqrq + "_tdwrap>div").show();
        $(id_txfpksrq + "_tdwrap>div").show();
        $(id_txfpjsrq + "_tdwrap>div").show();


        var v_bgbm = $(id_bgbm).val();
        if (v_bgbm == "1") {
            //合同到期不续签

            $(id_tyxqnx).val("").attr("disabled", "disabled");
            $(id_qsxqrq).val("").attr("disabled", "disabled");
            $(id_jzxqrq).val("").attr("disabled", "disabled");
            $(id_jjbcj1).val("").attr("disabled", "disabled");
            $(id_txfpkh).val("").attr("disabled", "disabled");

            $(id_qsxqrq + "span").text("");
            $(id_jzxqrq + "span").text("");
            $(id_qsxqrq + "_tdwrap>div").hide();
            $(id_jzxqrq + "_tdwrap>div").hide();

            $(id_txfpksrq).val("").attr("disabled", "disabled");
            $(id_txfpjsrq).val("").attr("disabled", "disabled");
            $(id_txfpksrq + "span").text("");
            $(id_txfpjsrq + "span").text("");
            $(id_txfpksrq + "_tdwrap>div").hide();
            $(id_txfpjsrq + "_tdwrap>div").hide();



        } else if (v_bgbm == "2") {
            //辞退
            $(id_tyxqnx).val("").attr("disabled", "disabled");
            $(id_qsxqrq).val("").attr("disabled", "disabled");
            $(id_jzxqrq).val("").attr("disabled", "disabled");
            $(id_jjbcj2).val("").attr("disabled", "disabled");
            $(id_txfpkh).val("").attr("disabled", "disabled");

            $(id_qsxqrq + "span").text("");
            $(id_jzxqrq + "span").text("");
            $(id_qsxqrq + "_tdwrap>div").hide();
            $(id_jzxqrq + "_tdwrap>div").hide();

            $(id_txfpksrq).val("").attr("disabled", "disabled");
            $(id_txfpjsrq).val("").attr("disabled", "disabled");
            $(id_txfpksrq + "span").text("");
            $(id_txfpjsrq + "span").text("");
            $(id_txfpksrq + "_tdwrap>div").hide();
            $(id_txfpjsrq + "_tdwrap>div").hide();

        } else if (v_bgbm == "3") {
            //合同续签
            $(id_jjbcj1).val("").attr("disabled", "disabled");
            $(id_jjbcj2).val("").attr("disabled", "disabled");
            $(id_txfpkh).val("").attr("disabled", "disabled");

            $(id_txfpksrq).val("").attr("disabled", "disabled");
            $(id_txfpjsrq).val("").attr("disabled", "disabled");
            $(id_txfpksrq + "span").text("");
            $(id_txfpjsrq + "span").text("");
            $(id_txfpksrq + "_tdwrap>div").hide();
            $(id_txfpjsrq + "_tdwrap>div").hide();


        } else if (v_bgbm == "4") 
        {
        
        //建议项都设定为不可输入
        $(id_tyxqnx).val("").attr("disabled","disabled");  
        $(id_qsxqrq).val("").attr("disabled","disabled");
        $(id_jzxqrq).val("").attr("disabled","disabled");
        
        $(id_jjbcj1).val("").attr("disabled","disabled"); 
        $(id_jjbcj2).val("").attr("disabled","disabled"); 
        $(id_txfpkh).val("").attr("disabled","disabled"); 
        $(id_txfpksrq).val("").attr("disabled","disabled");
        $(id_txfpjsrq).val("").attr("disabled", "disabled");
        $(id_qsxqrq + "span").text("");
        $(id_jzxqrq + "span").text("");
        $(id_qsxqrq + "_tdwrap>div").hide();
        $(id_jzxqrq + "_tdwrap>div").hide();

        $(id_txfpksrq + "span").text("");
        $(id_txfpjsrq + "span").text("");
        $(id_txfpksrq + "_tdwrap>div").hide();
        $(id_txfpjsrq + "_tdwrap>div").hide();
        } 
        else if (  v_bgbm == "5") {
            //退休返聘
            $(id_tyxqnx).val("").attr("disabled", "disabled");
            $(id_qsxqrq).val("").attr("disabled", "disabled");
            $(id_jzxqrq).val("").attr("disabled", "disabled");
            $(id_jjbcj1).val("").attr("disabled", "disabled");
            $(id_jjbcj2).val("").attr("disabled", "disabled");

            $(id_qsxqrq + "span").text("");
            $(id_jzxqrq + "span").text("");
            $(id_qsxqrq + "_tdwrap>div").hide();
            $(id_jzxqrq + "_tdwrap>div").hide();


        }
    }

    jQuery(document).ready(function () {
        $(id_tyxqnx).change(setNX);
        $(id_txfpkh).change(setFPNX);
        //        $(".width400 input").each(function () { $(this).attr("style", "width:400px;"); });
        //        $(".width1000 input").each(function () { $(this).attr("style", "width:1000px;"); });

        //        $(".width400 textarea").each(function () { $(this).attr("style", "width:400px;"); });
        //        $(".width1000 textarea").each(function () { $(this).attr("style", "width:1000px;"); });
        jQuery(id_bgbm).bindPropertyChange(function () { handleBGBM(); });
    });

</script>


