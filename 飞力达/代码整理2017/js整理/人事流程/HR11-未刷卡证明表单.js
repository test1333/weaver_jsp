<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    4.1) δˢ������: ��ֻ��ѡ���������ڵ��켰֮ǰ&&���ܿ翼�����ڣ���ÿ�£����ţ�������������ǰһ�����ڣ�
    20161031
    ��������Ϊ��26�ŵ����µ�25��
    */

    var bufferDays = 4;
    var id_sqrq = "#field6254"; //��������


    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $(id_sqrq); //��������
        var i_wskrq = $("#field6260"); //δˢ������
        var i_sbsj = $("#field6261"); //�ϰ�ʱ��
        var i_xbsj = $("#field6262"); //�°�ʱ��

        var d1 = new Date(i_wskrq.val().replace(/-/g, "/")); //δˢ������
        var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //��������
        if (d1.addDays(bufferDays) < d2) {
            window.top.Dialog.alert("���������������ڷ�Χ���������ύ" + bufferDays + "���ڵ����룡");
            isSuccess = false;
            return false;

        }
         d1 = new Date(i_wskrq.val().replace(/-/g, "/")); //δˢ������
         d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //��������

        if (d1> d2) {
            window.top.Dialog.alert("δˢ������ֻ��ѡ���������ڵ��켰֮ǰ��");
            isSuccess = false;
            return false;

        }


        /*
        //���㿼������
        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25"));


        if (new Date().getDate() >= 26 && new Date().getDate() <= 28) {
            //�����������ڣ�����28��ǰ���ύ��һ���ڵĵ���
            date1.addMonths(-1);
        }

        var d1 = new Date(i_wskrq.val().replace(/-/g, "/"));



        //��ʼ����: �ֹ���д��ֻ��ͬһ�������ڻ���һ��������
        if ((i_wskrq.val() == "") || (date1 <= d1 && d1 <= new Date())) { } else {
            window.top.Dialog.alert("δˢ������ֻ��ѡ���������ڵ��켰֮ǰ&&���ܿ翼�����ڣ�");
            isSuccess = false;
            return false;
        }
        */
        if ((i_sbsj.val() == "") && (i_xbsj.val() == "")) {
            window.top.Dialog.alert("���°�ʱ�������дһ�");
            isSuccess = false;
            return false;
        }

        return isSuccess;
    }

</script>



