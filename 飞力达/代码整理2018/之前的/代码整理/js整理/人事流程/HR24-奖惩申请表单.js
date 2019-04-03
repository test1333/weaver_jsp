<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    ���ͽ��: ���ݽ�������ж�(��Ҫ�û������ϵ)
    �ν����ǹ����Ǵ�Y1��Y2��Y3
    200��500��1500
    ���桢�ǹ����Ǵ��Z1��

    ��Ч����: ����������������

    20160916
    ����������������ܿص�:
    ����������������Ϻ��Զ����������ͱ���,�������ʹ�������
    ������ԭ������:
    1.��������������һ����Y,���Զ����������ͱ���Ϊ:2000,��������:�ͽ�
    2. .��������������һ����Z,���Զ����������ͱ���Ϊ:1000,��������:����
    */


    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $("#field6533"); //��������
        var i_sxrq = $("#field6674"); //��Ч����

        var d1 = new Date(i_sqrq.val().replace(/-/g, "/"));
        var d2 = new Date(i_sxrq.val().replace(/-/g, "/"));
        if (d1 <= d2) { } else {
            window.top.Dialog.alert("��Ч���ڲ���������������");
            isSuccess = false;
            return false;

        }

        return isSuccess;
    }

    var setJE = function () {
        var id_jclb = "#field8345"; //����������
        var id_jcje = "#field6780"; //���ͽ��

        var id_jclxbm = "#field8346"; //�������ͱ���
        var id_jclx = "#field8347"; //��������

        var v_jclb = $(id_jclb).val();
        var v_jcje = 0;
        if (v_jclb == "Y1") {
            v_jcje = 200;
        } else if (v_jclb == "Y2") {
            v_jcje = 500;
        } else if (v_jclb == "Y3") {
            v_jcje = 1500;
        } else if (v_jclb == "Z1") {
            v_jcje = 200;
        } else if (v_jclb == "Z2") {
            v_jcje = 500;
        } else if (v_jclb == "Z3") {
            v_jcje = 1500;
        }
        if (v_jcje > 0) {
            $(id_jcje).val(v_jcje);
            //$(id_jcje + "span").text(v_jcje);
        } else {
            $(id_jcje).val("");
            //$(id_jcje + "span").text("");
        }

        if (v_jclb.indexOf("Y") > -1) {
            $(id_jclxbm).val("2000");
            $(id_jclx).val("�ͽ�");
            $(id_jclxbm + "span").text("2000");
            $(id_jclx + "span").text("�ͽ�");

        } else {
            $(id_jclxbm).val("1000");
            $(id_jclx).val("����");
            $(id_jclxbm + "span").text("1000");
            $(id_jclx + "span").text("����");

        }
    }

    jQuery(document).ready(function () {
        jQuery("#field8345").bindPropertyChange(function () { setJE(); });

    });

</script>

