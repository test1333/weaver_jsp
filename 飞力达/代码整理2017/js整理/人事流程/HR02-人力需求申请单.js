<script type="text/javascript">




    jQuery(document).ready(function () {
    });


    checkCustomize = function () {
        var isSuccess = true;
        var s = ",";

        $("td[name='td_sqzwbm'] input").each(function () {

            if (s.indexOf("," + $(this).val() + ",") != -1) {
                window.top.Dialog.alert("ְλ�������ظ����룡");
                isSuccess = false;
                return false;
            } else {
                s = s + $(this).val() + ",";
            }


        });



        return isSuccess;
    }




</script>

