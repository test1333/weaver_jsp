<script type="text/javascript">
    /*
    3.1)�������ں�ͬԼ�������ڽ�ֹ����
    3.2) ��������: Ĭ�����ú�н�������޸�(ͨ���������ñ��еĹ���=���ÿ��˱���)
    3.3) ��Ч��׼: Ĭ�����ú�н�������޸�(ͨ���������ñ��еĹ���=���ÿ��˱���)
    3.4)��������������=��������+�������+רҵ����+��Ч��׼
    3.5) �������������������ǽ��=����������������-������������
    3.6) �����������ǽ��=����������������-�����ڻ�������
    3.7) ����������ǽ��=���������������-�����ڹ������
    3.8) ��������רҵ����-������רҵ����
    3.9) ����������Ч�������-�����ڼ�Ч�������
    */


    var id_syqzsr = "field6842"; //������������
    var id_syqjbgz = "field7014"; //�����ڻ�������
    var id_syqzyjt = "field6845"; //������רҵ����
    var id_syqgljt = "field6844"; //�����ڹ������
    var id_syqjxbz = "field6846"; //�����ڼ�Ч��׼

    var id_syqmzsr = "field6847"; //��������������
    var id_syqmjbgz = "field6850"; //����������������
    var id_syqmzyjt = "field6852"; //��������רҵ����
    var id_syqmgljt = "field6851"; //���������������
    var id_syqmjxbz = "field6853"; //����������Ч��׼

    var id_syqszzsr = "field6854"; //����������������
    var id_syqszjbgz = "field6855"; //���������ǻ�������
    var id_syqszzyjt = "field6857"; //����������רҵ����
    var id_syqszgljt = "field6856"; //���������ǹ������
    var id_syqszjxbz = "field6858"; //���������Ǽ�Ч��׼


    checkCustomize = function () {
        var isSuccess = true;


        return isSuccess;
    }
    //������������������
    var calcSYQMZSR = function () {
        //������
        var i_syqzsr = $("#" + id_syqzsr); //������������
        var i_syqjbgz = $("#" + id_syqjbgz); //�����ڻ�������
        var i_syqzyjt = $("#" + id_syqzyjt); //������רҵ����
        var i_syqgljt = $("#" + id_syqgljt); //�����ڹ������
        var i_syqjxbz = $("#" + id_syqjxbz); //�����ڼ�Ч��׼

        var s_syqzsr = $("#" + id_syqzsr + "span"); //������������
        var s_syqjbgz = $("#" + id_syqjbgz + "span"); //�����ڻ�������
        var s_syqzyjt = $("#" + id_syqzyjt + "span"); //������רҵ����
        var s_syqgljt = $("#" + id_syqgljt + "span"); //�����ڹ������
        var s_syqjxbz = $("#" + id_syqjxbz + "span"); //�����ڼ�Ч��׼

        var v_syqjbgz = isNaN(i_syqjbgz.val()) || i_syqjbgz.val() == "" ? 0 : parseFloat(i_syqjbgz.val());
        var v_syqgljt = isNaN(i_syqgljt.val()) || i_syqgljt.val() == "" ? 0 : parseFloat(i_syqgljt.val());
        var v_syqzyjt = isNaN(i_syqzyjt.val()) || i_syqzyjt.val() == "" ? 0 : parseFloat(i_syqzyjt.val());
        var v_syqjxbz = isNaN(i_syqjxbz.val()) || i_syqjxbz.val() == "" ? 0 : parseFloat(i_syqjxbz.val());

        s_syqzsr.text(v_syqjbgz + v_syqgljt + v_syqzyjt + v_syqjxbz);
        i_syqzsr.val(v_syqjbgz + v_syqgljt + v_syqzyjt + v_syqjxbz);

        var v_syqzsr = isNaN(i_syqzsr.val()) || i_syqzsr.val() == "" ? 0 : parseFloat(i_syqzsr.val());

        //��������
        var i_syqmzsr = $("#" + id_syqmzsr); //��������������
        var i_syqmjbgz = $("#" + id_syqmjbgz); //����������������
        var i_syqmzyjt = $("#" + id_syqmzyjt); //��������רҵ����
        var i_syqmgljt = $("#" + id_syqmgljt); //���������������
        var i_syqmjxbz = $("#" + id_syqmjxbz); //����������Ч��׼

        var s_syqmzsr = $("#" + id_syqmzsr + "span"); //��������������
        var s_syqmjbgz = $("#" + id_syqmjbgz + "span"); //����������������
        var s_syqmzyjt = $("#" + id_syqmzyjt + "span"); //��������רҵ����
        var s_syqmgljt = $("#" + id_syqmgljt + "span"); //���������������
        var s_syqmjxbz = $("#" + id_syqmjxbz + "span"); //����������Ч��׼


        var v_syqmjbgz = isNaN(i_syqmjbgz.val()) || i_syqmjbgz.val() == "" ? 0 : parseFloat(i_syqmjbgz.val());
        var v_syqmgljt = isNaN(i_syqmgljt.val()) || i_syqmgljt.val() == "" ? 0 : parseFloat(i_syqmgljt.val());
        var v_syqmzyjt = isNaN(i_syqmzyjt.val()) || i_syqmzyjt.val() == "" ? 0 : parseFloat(i_syqmzyjt.val());
        var v_syqmjxbz = isNaN(i_syqmjxbz.val()) || i_syqmjxbz.val() == "" ? 0 : parseFloat(i_syqmjxbz.val());

        //s_syqmzsr.text(v_syqmjbgz + v_syqmgljt + v_syqmzyjt + v_syqmjxbz);
        i_syqmzsr.val(v_syqmjbgz + v_syqmgljt + v_syqmzyjt + v_syqmjxbz);
        var v_syqmzsr = isNaN(i_syqmzsr.val()) || i_syqmzsr.val() == "" ? 0 : parseFloat(i_syqmzsr.val());


        //����
        var i_syqszzsr = $("#" + id_syqszzsr); //����������������
        var i_syqszjbgz = $("#" + id_syqszjbgz); //���������ǻ�������
        var i_syqszzyjt = $("#" + id_syqszzyjt); //����������רҵ����
        var i_syqszgljt = $("#" + id_syqszgljt); //���������ǹ������
        var i_syqszjxbz = $("#" + id_syqszjxbz); //���������Ǽ�Ч��׼

        var s_syqszzsr = $("#" + id_syqszzsr + "span"); //����������������
        var s_syqszjbgz = $("#" + id_syqszjbgz + "span"); //���������ǻ�������
        var s_syqszzyjt = $("#" + id_syqszzyjt + "span"); //����������רҵ����
        var s_syqszgljt = $("#" + id_syqszgljt + "span"); //���������ǹ������
        var s_syqszjxbz = $("#" + id_syqszjxbz + "span"); //���������Ǽ�Ч��׼

        i_syqszzsr.val(v_syqmzsr - v_syqzsr);
        s_syqszzsr.text(v_syqmzsr - v_syqzsr);

        i_syqszjbgz.val(v_syqmjbgz - v_syqjbgz);
        s_syqszjbgz.text(v_syqmjbgz - v_syqjbgz);

        i_syqszgljt.val(v_syqmgljt - v_syqgljt);
        s_syqszgljt.text(v_syqmgljt - v_syqgljt);

        i_syqszzyjt.val(v_syqmzyjt - v_syqzyjt);
        s_syqszzyjt.text(v_syqmzyjt - v_syqzyjt);

        i_syqszjxbz.val(v_syqmjxbz - v_syqjxbz);
        s_syqszjxbz.text(v_syqmjxbz - v_syqjxbz);


    }

    jQuery(document).ready(function () {
        $("#" + id_syqzsr).change(calcSYQMZSR); //����������������
        $("#" + id_syqjbgz).change(calcSYQMZSR); //���������������
        $("#" + id_syqzyjt).change(calcSYQMZSR); //��������רҵ����
        $("#" + id_syqgljt).change(calcSYQMZSR); //����������Ч��׼
        $("#" + id_syqjxbz).change(calcSYQMZSR); //����������Ч��׼




        $("#" + id_syqmzsr).change(calcSYQMZSR); //����������������
        $("#" + id_syqmjbgz).change(calcSYQMZSR); //���������������
        $("#" + id_syqmzyjt).change(calcSYQMZSR); //��������רҵ����
        $("#" + id_syqmgljt).change(calcSYQMZSR); //����������Ч��׼
        $("#" + id_syqmjxbz).change(calcSYQMZSR); //����������Ч��׼



    });


</script>

