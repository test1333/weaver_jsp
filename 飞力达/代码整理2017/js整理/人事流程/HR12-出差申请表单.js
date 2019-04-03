<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    5.1) ��������: �������ڿ�ʼ����
    5.2) ����ʱ��: ��������ʱ��-��ʼ����ʱ��
    �������뵥ʱ�����߼�����:
    ��������ʱ��-��ʼ����ʱ��
    ������������ΪС��β��С��0.5,���0.5
    ������������С��β������0.5,���λΪ1.

    */

    

    var bufferDays = 4;
    var id_sqrq = "#field10188"; //��������

    var id_ksrq = "#field6452"; //��ʼ����
    var id_jsrq = "#field6454"; //��������
    var id_kssj = "#field6453"; //��ʼʱ��
    var id_jssj = "#field6455"; //����ʱ��

    var id_jybj = "#field10475"; //У����
    var id_jyxx = "#field10476"; //У����Ϣ

    var id_ccsc = "#field10081"; //����ʱ��


    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $(id_sqrq); //��������
        var i_ksrq = $(id_ksrq); //��ʼ����
        var i_jsrq = $(id_jsrq); //��������
        var i_kssj = $(id_kssj); //��ʼʱ��
        var i_jssj = $(id_jssj); //����ʱ��
        var i_ccsc = $("#field6456"); //����ʱ��
        var i_cfrq = $("#field10187"); //��������

        var d1 = new Date(i_ksrq.val().replace(/-/g, "/")); //��ʼ����
        var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //��������
        if (d1.addDays(bufferDays) < d2) {
            window.top.Dialog.alert("���������������ڷ�Χ���������ύ" + bufferDays + "���ڵ����룡");
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


        //���㿼������
        var date1 = new Date(new Date().addMonths(new Date().getDate() < 26 ? -1 : 0).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() < 26 ? 0 : 1).Format("yyyy/MM/25"));

        var d1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var d2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));

        var d3 = new Date((i_cfrq.val()).replace(/-/g, "/"));

        //��������: �������ڿ�ʼ����
        if ((i_ksrq.val() == "") || (i_jsrq.val() == "") || (i_jssj.val() == "") || (i_kssj.val() == "") || (d1.getTime() < d2.getTime())) {

        } else {
            window.top.Dialog.alert("�������ڲ������ڿ�ʼ���ڣ�");
            isSuccess = false;
            return false;
        }


        if ((i_cfrq.val() == "") || (d3.getTime() <= d2.getTime())) {

        } else {
            window.top.Dialog.alert("�����ղ������ڽ������ڣ�");
            isSuccess = false;
            return false;
        }

        return isSuccess;
    }

    var calcTime = function () {
        var i_ksrq = $(id_ksrq); //��ʼ����
        var i_jsrq = $(id_jsrq); //��������
        var i_kssj = $(id_kssj); //��ʼʱ��
        var i_jssj = $(id_jssj); //����ʱ��
        var i_ccsc = $("#field6456"); //����ʱ��
        var s_ccsc = $("#field6456span"); //����ʱ��
        var d1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var d2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));

        if ((i_ksrq.val() == "") || (i_jsrq.val() == "") || (i_jssj.val() == "") || (i_kssj.val() == "") || (d1.getTime() < d2.getTime())) {
        } else {
            window.top.Dialog.alert("�������ڲ������ڿ�ʼ���ڣ�");
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



