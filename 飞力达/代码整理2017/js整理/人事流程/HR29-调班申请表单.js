<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">

    var bufferDays = 4;
    var id_sqrq = "#field9031"; //��������



    jQuery(document).ready(function () {
    });


    checkCustomize = function () {
        var isSuccess = true;
        var i_sqrq = $(id_sqrq);

        $("td[name='td_tbrq'] input[type='hidden']").each(function () {

            var d1 = new Date($(this).val().replace(/-/g, "/")); //��ʼ����
            var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //��������
            if (d1.addDays(bufferDays) < d2) {
                window.top.Dialog.alert("���������������ڷ�Χ���������ύ" + bufferDays + "���ڵ����룡");
                isSuccess = false;
                return false;
            }


        });



        return isSuccess;
    }




</script>

