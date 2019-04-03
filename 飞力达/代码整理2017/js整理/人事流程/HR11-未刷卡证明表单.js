<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    4.1) 未刷卡日期: （只能选择申请日期当天及之前&&不能跨考勤周期）（每月２８号２４：００锁定前一个周期）
    20161031
    考勤周期为：26号到下月的25号
    */

    var bufferDays = 4;
    var id_sqrq = "#field6254"; //申请日期


    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $(id_sqrq); //申请日期
        var i_wskrq = $("#field6260"); //未刷卡日期
        var i_sbsj = $("#field6261"); //上班时间
        var i_xbsj = $("#field6262"); //下班时间

        var d1 = new Date(i_wskrq.val().replace(/-/g, "/")); //未刷卡日期
        var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //申请日期
        if (d1.addDays(bufferDays) < d2) {
            window.top.Dialog.alert("超出允许申请日期范围，仅允许提交" + bufferDays + "天内的申请！");
            isSuccess = false;
            return false;

        }
         d1 = new Date(i_wskrq.val().replace(/-/g, "/")); //未刷卡日期
         d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //申请日期

        if (d1> d2) {
            window.top.Dialog.alert("未刷卡日期只能选择申请日期当天及之前！");
            isSuccess = false;
            return false;

        }


        /*
        //计算考勤周期
        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25"));


        if (new Date().getDate() >= 26 && new Date().getDate() <= 28) {
            //修正考勤周期，允许28号前补提交上一周期的单子
            date1.addMonths(-1);
        }

        var d1 = new Date(i_wskrq.val().replace(/-/g, "/"));



        //开始日期: 手工填写，只限同一考勤周期或下一考勤周期
        if ((i_wskrq.val() == "") || (date1 <= d1 && d1 <= new Date())) { } else {
            window.top.Dialog.alert("未刷卡日期只能选择申请日期当天及之前&&不能跨考勤周期！");
            isSuccess = false;
            return false;
        }
        */
        if ((i_sbsj.val() == "") && (i_xbsj.val() == "")) {
            window.top.Dialog.alert("上下班时间必须填写一项！");
            isSuccess = false;
            return false;
        }

        return isSuccess;
    }

</script>



