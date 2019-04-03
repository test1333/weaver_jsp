<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    培训活动编号:OA自动生成（人事范围)zzzzYYYYMMDDXXX(自动流水号)）
    人员不允许重复 td_cxrgh
    */
    var handleChange = function () {

        var i_bh = $("#field6091"); //培训活动编号
        var s_bh = $("#field6091span"); //培训活动编号
        var i_fw = $("#field7523"); //人事范围编码
        var s_fw = $("#field7523span"); //人事范围编码

        i_bh.val(i_fw.val() + (new Date().Format("yyMMddmm")));
        s_bh.text(i_bh.val());

    }


    var calcFee = function () {
        var fee = $("#i_fee input").val();
        var ct = $("td[name='i_feedtl']").length;
        if (isNaN(fee) || ct < 1) { return; }
        fee = Math.floor(fee * 100);
        var _result = Math.floor(fee / ct);
        var idx = 1;
        $("td[name='i_feedtl']").each(function () {
            $(this).find("input").attr("readonly", "readonly").val(idx == ct ? fee / 100 : _result / 100);
            fee = Math.floor(fee - _result);
            idx++;
        });
    }

    jQuery(document).ready(function () {
        jQuery("#field7523span").bindPropertyChange(function () { handleChange(); });
        $("#btn_test").click(function () { calcFee() });
        $("#i_fee input").change(function () { calcFee() });

    });

    checkCustomize = function () {
        var isSuccess = true;
        handleChange();
        var s = ",";
        $("td[name='td_cxrgh']").each(function () {
            var gh = $(this).find("input").val();
            if (s.indexOf("," + gh + ",") > -1) {
                window.top.Dialog.alert("不允许人员重复！");
                isSuccess = false;
                return false;
            }
            s = s + gh + ","
        });
        return isSuccess;
    }

</script>


