<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    5.1) 结束日期: 不能早于开始日期
    5.2) 出差时长: 结束日期时间-开始日期时间
    出差申请单时长的逻辑如下:
    结束日期时间-开始日期时间
    如果计算出来的为小数尾数小于0.5,则给0.5
    如果计算出来的小数尾数大于0.5,则进位为1.

    */

    

    var bufferDays = 4;
    var id_sqrq = "#field10188"; //申请日期

    var id_ksrq = "#field6452"; //开始日期
    var id_jsrq = "#field6454"; //结束日期
    var id_kssj = "#field6453"; //开始时间
    var id_jssj = "#field6455"; //结束时间

    var id_jybj = "#field10475"; //校验标记
    var id_jyxx = "#field10476"; //校验信息

    var id_ccsc = "#field10081"; //出差时长


    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $(id_sqrq); //申请日期
        var i_ksrq = $(id_ksrq); //开始日期
        var i_jsrq = $(id_jsrq); //结束日期
        var i_kssj = $(id_kssj); //开始时间
        var i_jssj = $(id_jssj); //结束时间
        var i_ccsc = $("#field6456"); //出差时长
        var i_cfrq = $("#field10187"); //出发日期

        var d1 = new Date(i_ksrq.val().replace(/-/g, "/")); //开始日期
        var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //申请日期
        if (d1.addDays(bufferDays) < d2) {
            window.top.Dialog.alert("超出允许申请日期范围，仅允许提交" + bufferDays + "天内的申请！");
            isSuccess = false;
            return false;

        }


        if ("S" != $(id_jybj + "span").text()) {
            if ($(id_jyxx + "span").text() == "") {
                window.top.Dialog.alert("请校验出差时长！");
            } else {
                window.top.Dialog.alert($(id_jyxx + "span").text());

            }
            isSuccess = false;
            return false;

        }


        //计算考勤周期
        var date1 = new Date(new Date().addMonths(new Date().getDate() < 26 ? -1 : 0).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() < 26 ? 0 : 1).Format("yyyy/MM/25"));

        var d1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var d2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));

        var d3 = new Date((i_cfrq.val()).replace(/-/g, "/"));

        //结束日期: 不能早于开始日期
        if ((i_ksrq.val() == "") || (i_jsrq.val() == "") || (i_jssj.val() == "") || (i_kssj.val() == "") || (d1.getTime() < d2.getTime())) {

        } else {
            window.top.Dialog.alert("结束日期不能早于开始日期！");
            isSuccess = false;
            return false;
        }


        if ((i_cfrq.val() == "") || (d3.getTime() <= d2.getTime())) {

        } else {
            window.top.Dialog.alert("出发日不能晚于结束日期！");
            isSuccess = false;
            return false;
        }

        return isSuccess;
    }

    var calcTime = function () {
        var i_ksrq = $(id_ksrq); //开始日期
        var i_jsrq = $(id_jsrq); //结束日期
        var i_kssj = $(id_kssj); //开始时间
        var i_jssj = $(id_jssj); //结束时间
        var i_ccsc = $("#field6456"); //出差时长
        var s_ccsc = $("#field6456span"); //出差时长
        var d1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var d2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));

        if ((i_ksrq.val() == "") || (i_jsrq.val() == "") || (i_jssj.val() == "") || (i_kssj.val() == "") || (d1.getTime() < d2.getTime())) {
        } else {
            window.top.Dialog.alert("结束日期不能早于开始日期！");
            return false;
        }
//        var ct = d1.dateDiff("n", d2) / (60 * 12);

//        ct = Math.ceil(ct);
//        ct = (ct * 0.5);
//        if (!isNaN(ct)) {
//            i_ccsc.val(ct);
//        }
//        //s_ccsc.text(ct);
    }
    var resetCheck = function () {
        $(id_jybj).val("");
        $(id_jybj + "span").text("");
        $(id_jyxx).val("");
        $(id_jyxx + "span").text("");


        if ($(id_ksrq).val() == ""
        || $(id_jsrq).val() == ""
        || $(id_kssj).val() == ""
        || $(id_jssj).val() == ""
        ) {
            $(id_ccsc).closest("td>div").hide();
        } else {
            $(id_ccsc).closest("td>div").show();

        }


    }

    jQuery(document).ready(function () {
        jQuery(id_ksrq).bindPropertyChange(function () { calcTime(); resetCheck(); });
        jQuery(id_jsrq).bindPropertyChange(function () { calcTime(); resetCheck(); });
        jQuery(id_kssj).bindPropertyChange(function () { calcTime(); resetCheck(); });
        jQuery(id_jssj).bindPropertyChange(function () { calcTime(); resetCheck(); });
        resetCheck();
    });
</script>



