<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">

    /*
    6.1) ��ٵ���ֻ������һ��
    6.2) ������ٵ��Ŵ����������,��ʼ����,��ʼʱ��,��������,����ʱ��,���ʱ��(�Ƿ������OA���趨)
    
    6.3) ���ٿ�ʼ����: ���ڵ���ԭ��ʼ����
    6.4) ���ٿ�ʼʱ��: ���ڵ���ԭ��ʼʱ��
    6.5) ���ٽ�������: С�ڵ��ڽ�������
    6.6) ���ٽ���ʱ��: С�ڵ��ڽ���ʱ��
    6.7) ��������Ϊȫ�����Զ�������ʼʱ��/����ʱ��

    */
    var setDT = function () {
        var i_xjlx = $("#field6637"); //��������
        if (i_xjlx.val() == "1") {
            //����ȫ��
            var i_ksrq = $("#field6632"); //��ʼ����
            var i_kssj = $("#field6633"); //��ʼʱ��
            var i_jsrq = $("#field6634"); //��������
            var i_jssj = $("#field6635"); //����ʱ��

            var id_xjksrq = "#field6638"; //���ٿ�ʼ����
            var id_xjkssj = "#field6639"; //���ٿ�ʼʱ��
            var id_xjjsrq = "#field6640"; //���ٽ�������
            var id_xjjssj = "#field6641"; //���ٽ���ʱ��

            $(id_xjksrq).val(i_ksrq.val());
            $(id_xjkssj).val(i_kssj.val());
            $(id_xjjsrq).val(i_jsrq.val());
            $(id_xjjssj).val(i_jssj.val());

            $(id_xjksrq + "span").text(i_ksrq.val());
            $(id_xjkssj + "span").text(i_kssj.val());
            $(id_xjjsrq + "span").text(i_jsrq.val());
            $(id_xjjssj + "span").text(i_jssj.val());
        }
    }

    jQuery(document).ready(function () {
        $("#div0button .addbtn_p").click(function () { initDetail() });
        $("#field6637").change(setDT);
        window.setTimeout("initDetail()", 1000);

        jQuery("#field6635").bindPropertyChange(function () { setDT(); });

    });


    checkCustomize = function () {
        var isSuccess = true;
        //���
        var i_ksrq = $("#field6632"); //��ʼ����
        var i_kssj = $("#field6633"); //��ʼʱ��
        var i_jsrq = $("#field6634"); //��������
        var i_jssj = $("#field6635"); //����ʱ��

        //����
        var i_xjksrq = $("#field6638"); //���ٿ�ʼ����
        var i_xjkssj = $("#field6639"); //���ٿ�ʼʱ��
        var i_xjjsrq = $("#field6640"); //���ٽ�������
        var i_xjjssj = $("#field6641"); //���ٽ���ʱ��

        var d1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var d2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));

        var d3 = new Date((i_xjksrq.val() + " " + i_xjkssj.val()).replace(/-/g, "/"));
        var d4 = new Date((i_xjjsrq.val() + " " + i_xjjssj.val()).replace(/-/g, "/"));

        if ((i_ksrq.val() == "")
            || (i_jsrq.val() == "")
            || (i_xjksrq.val() == "")
            || (i_xjjsrq.val() == "")
            || (d1.getTime() == d3.getTime() && d1.getTime() < d4.getTime() && d4.getTime() < d2.getTime() && d3.getTime() < d4.getTime())
            || (d1.getTime() < d3.getTime() && d3.getTime() < d2.getTime() && d4.getTime() == d2.getTime() && d3.getTime() < d4.getTime())
            || (d1.getTime() == d3.getTime() && d2.getTime() == d4.getTime())
        // || (d1.getTime() <= d3.getTime() && d3.getTime() <= d2.getTime() && d1.getTime() <= d4.getTime() && d4.getTime() <= d2.getTime() && d3.getTime() <= d4.getTime()&&d1.getTime() <= d3.getTime() )
            ) { } else {
            window.top.Dialog.alert("���ٿ�ʼ����: ���ڵ���ԭ��ʼ����<br/>���ٿ�ʼʱ��: ���ڵ���ԭ��ʼʱ��<br/>���ٽ�������: С�ڵ��ڽ�������<br/>���ٽ���ʱ��: С�ڵ��ڽ���ʱ��");
            isSuccess = false;
            return false;

        }

        return isSuccess;
    }




</script>

