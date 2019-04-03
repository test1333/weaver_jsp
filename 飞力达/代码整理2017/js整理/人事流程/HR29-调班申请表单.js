<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">

    var bufferDays = 4;
    var id_sqrq = "#field9031"; //申请日期



    jQuery(document).ready(function () {
    });


    checkCustomize = function () {
        var isSuccess = true;
        var i_sqrq = $(id_sqrq);

        $("td[name='td_tbrq'] input[type='hidden']").each(function () {

            var d1 = new Date($(this).val().replace(/-/g, "/")); //开始日期
            var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //申请日期
            if (d1.addDays(bufferDays) < d2) {
                window.top.Dialog.alert("超出允许申请日期范围，仅允许提交" + bufferDays + "天内的申请！");
                isSuccess = false;
                return false;
            }


        });



        return isSuccess;
    }




</script>

