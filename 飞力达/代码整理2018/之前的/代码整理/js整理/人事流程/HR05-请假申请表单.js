<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    1.1)��ʼ����: �ֹ���д��ֻ��ͬһ�������ڻ���һ��������
    ��������:�ֹ���д���������ڿ�ʼ����
    1.2)
    ѡ���¼١����١���١����١���١����١�����١�����١�ɥ�١����˼١����μ١�����
    ��ѡ���¼ٵ�ʱ��Ҫ������ٽ��࣬����ѡ����٣�������������٣�����С0.5�죩
    1.3)�������ݰ�ť����: ���Ӵ�������ҳ��

    1.	�ٱ�����: ����(0200)�����(0500)�������(1200)���ƻ�������(1300)�������(1400)��
    ɥ��(0600)�����˼�(0300)������(0700)��̽�׼�(0400)��Ҫ������Ҫ�ϴ�����ļ���
    1.����(0200)����Ҫ���������ϴ����������ڲ���(0210)��Ҫ�����ϴ�������
    2.̽�׼�(0400)����Ҫ�����ϴ�����.
    3. ɥ��(0600) ����Ҫ�����ϴ�����.


    */
    var bufferDays = 4; //�����ύ�����ʱ����ƣ���Ȼ�գ�
    var id_sqrq = "#field6504"; //��������

    var id_ksrq = "#field6565"; //��ʼ����
    var id_jsrq = "#field6582"; //��������
    var id_kssj = "#field6581"; //��ʼʱ��
    var id_jssj = "#field6669"; //����ʱ��

    var id_jybj = "#field10409"; //У����
    var id_jyxx = "#field10410"; //У����Ϣ

    var id_qjsc = "#field10020";  //���ʱ��
    var id_qjlx = "#field7661";  //�������
    var id_qjrgh = "#field6524";  //����˹���


    checkCustomize = function () {
        var isSuccess = true;



        var i_sqrq = $(id_sqrq); //��������

        var i_ksrq = $(id_ksrq); //��ʼ����
        var i_jsrq = $(id_jsrq); //��������
        var i_kssj = $(id_kssj); //��ʼʱ��
        var i_jssj = $(id_jssj); //����ʱ��


        /*
        20161220�����ȡ��ԭ�Կ������ڵĹܿأ���Ϊ4����Ȼ�չܿ�

        //���㿼������
        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25"));

        var date3 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/26"));
        var date4 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 2 : 1).Format("yyyy/MM/25"));

        var d1 = new Date(i_ksrq.val().replace(/-/g, "/"));
        var d2 = new Date(i_jsrq.val().replace(/-/g, "/"));

        //��ʼ����: �ֹ���д��ֻ��ͬһ�������ڻ���һ��������
        if ((i_ksrq.val() == "") || (date1 <= d1 && d1 <= date2) || (date3 <= d1 && d1 <= date4)) { } else {
        window.top.Dialog.alert("��ʼ����" + d1.Format("yyyy-MM-dd") + "���ڵ�ǰ���ڣ�" + date1.Format("yyyy-MM-dd") + " - " + date2.Format("yyyy-MM-dd") + "������һ���ڣ�" + date3.Format("yyyy-MM-dd") + " - " + date4.Format("yyyy-MM-dd") + "���ڣ�");
        isSuccess = false;
        return false;
        }

        */

        //4����Ȼ�չܿ�

        var d1 = new Date(i_ksrq.val().replace(/-/g, "/")); //��ʼ����
        var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //��������
        if (d1.addDays(bufferDays) < d2) {
            window.top.Dialog.alert("���������������ڷ�Χ���������ύ" + bufferDays + "���ڵ����룡");
            isSuccess = false;
            return false;

        }




        //��������:�ֹ���д���������ڿ�ʼ����
        var datetime1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var datetime2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));
        var ct = datetime1.dateDiff("s", datetime2)
        if ((i_ksrq.val() == "") || (i_jsrq.val() == "") || (datetime1 <= datetime2)) { } else {
            window.top.Dialog.alert("��������+����ʱ��������ڿ�ʼ����+��ʼʱ�䣡");
            isSuccess = false;
            return false;
        }

        if ("S" != $(id_jybj + "span").text()) {
            if ($(id_jyxx + "span").text() == "") {
                window.top.Dialog.alert("��У�����ʱ����");
            } else {
                window.top.Dialog.alert($(id_jyxx + "span").text());

            }
            isSuccess = false;
            return false;

        }

        //ѡ���¼١����١���١����١���١����١�����١�����١�ɥ�١����˼١����μ١�����
        //��ѡ���¼ٵ�ʱ��Ҫ������ٽ��࣬����ѡ����٣�������������٣�����С0.5�죩
        /*
        ���	�ֶ�����	�ֶα���
        1	���ݼ�	0100
        2	����	0200
        3	���ڲ���	0210
        4	���˼�	0300
        5	̽�׼�	0400
        6	���	0500
        7	ɥ��	0600
        8	����	0700
        9	�¼�	0800
        10	����	0900
        11	���ݼ�	1000
        12	����	1100
        13	�����	1200
        14	�ƻ�������	1300
        15	�����	1400
        16	���μ�	1500
        17	�����	1600
        18	���Լ�	1700
        19	���س���	2000
        20	���ڳ���	2001
        21	�������	2100
        */
        var i_qjlx = $("#field7661"); //�������
        var i_njjy = $("#field6871"); //��ٽ���
        var i_lyjjy = $("#field6735"); //���μٽ���
        var i_txjjy = $("#field7023"); //���ݼٽ���
        var i_qjsc = $("#field10020"); //���ʱ��


        var i_qjrgh = $("#field6524"); //����˹���
        var i_dlrgh = $("#field6739"); //�����˹���

        var v_njjy = i_njjy.val() == "" ? 0 : parseFloat(i_njjy.val());
        var v_lyjjy = i_lyjjy.val() == "" ? 0 : parseFloat(i_lyjjy.val());
        var v_txjjy = i_txjjy.val() == "" ? 0 : parseFloat(i_txjjy.val());

        v_njjy = v_njjy * 8; //����ΪСʱ
        v_lyjjy = v_lyjjy * 8; //����ΪСʱ
        v_txjjy = v_txjjy * 8; //����ΪСʱ

        var v_qjsc = i_qjsc.val() == "" ? 0 : parseFloat(i_qjsc.val());
        if (i_qjlx.val() == "0800") {
            //�¼�
            if (v_njjy > 0 && v_qjsc >= 4) {
                window.top.Dialog.alert("��ٽ��࣬��ѡ����٣�");
                isSuccess = false;
                return false;
            }
        } else if (i_qjlx.val() == "0100") {
            //���ݼ�
            if (v_qjsc < 4 || v_qjsc % 4 > 0) {
                window.top.Dialog.alert("���ʱ����С0.5�죨4Сʱ����Ϊ4�ı�����");
                isSuccess = false;
                return false;
            }
            if (v_qjsc > v_njjy) {
                window.top.Dialog.alert("��ٽ��಻�㣡");
                isSuccess = false;
                return false;
            }
        } else if (i_qjlx.val() == "1500") {
            //���μ�
            if (v_qjsc > v_lyjjy) {
                window.top.Dialog.alert("���μٽ��಻�㣡");
                isSuccess = false;
                return false;
            }
            if (v_qjsc != v_lyjjy) {
                window.top.Dialog.alert("���μٱ���һ����ʹ�ã�");
                isSuccess = false;
                return false;
            }
        }
        else if (i_qjlx.val() == "1000") {
            //���ݼ�
            if (v_qjsc > v_txjjy) {
                window.top.Dialog.alert("���ݼٽ��಻�㣡");
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
            //1.	�ٱ�����: ����(0200)�����(0500)�������(1200)���ƻ�������(1300)�������(1400)��ɥ��(0600)�����˼�(0300)������(0700)��̽�׼�(0400)��Ҫ������Ҫ�ϴ�����ļ���

            if ($("#fsUploadProgress6741 div.progressWrapper:visible").length == 0) {
                //window.top.Dialog.alert("���ϴ�����ļ���");
                //isSuccess = false;
                //return false;

            }
        }


        if (i_qjrgh.val() == i_dlrgh.val()) {
            window.top.Dialog.alert("�������˴���");
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
        jQuery(id_ksrq).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //��ʼ����
        jQuery(id_jsrq).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //��������
        jQuery(id_kssj).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //��ʼʱ��
        jQuery(id_jssj).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //����ʱ��

        jQuery(id_qjlx).bindPropertyChange(function () { resetQJSS(); }); //�������
        jQuery(id_qjrgh).bindPropertyChange(function () { resetQJSS(); }); //����˹���
        resetCheck();
        resetQJSS();
    });



</script>



