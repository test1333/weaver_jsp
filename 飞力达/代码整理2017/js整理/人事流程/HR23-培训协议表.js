<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    ���ݻ��Ŵ��������,���������(Э�鿪ʼ����)
    ��ѵЭ���Ÿ��ݹ���:Ա������+��ѵ��������
    "Э���������=Э�鿪ʼ����+Э������
    (����΢�����Ƿ����ʵ��)"

    */


    checkCustomize = function () {
        var isSuccess = true;
        //��ѵЭ���Ÿ��ݹ���:Ա������+��ѵ��������
        var i_pxhdbh = $("#field6876"); //��ѵ����
        var s_pxhdbh = $("#field6876span"); //��ѵ����
        $("td[name='td_cxrgh']").each(function () {
            var tr = $(this).closest("tr");
            var i_cxrgh = $(this).find("input"); ;
            var s_cxrgh = $(this).find("span"); ;
            var i_pxxybh = tr.find("td[name='td_pxxybh'] input");
            var s_pxxybh = tr.find("td[name='td_pxxybh'] span");

            i_pxxybh.val(i_cxrgh.val() + i_pxhdbh.val());
            s_pxxybh.text(i_cxrgh.val() + i_pxhdbh.val());
        });


        return isSuccess;
    }

    var setNX = function () {
        var i_xynx = $("#field6460"); //Э������
        var i_xyksrq = $("#field6461"); //Э�鿪ʼ����
        var i_xyjsrq = $("#field6462"); //Э���������

        var s_xyksrq = $("#field6461span"); //��ʼ��ǩ����
        var s_xyjsrq = $("#field6462span"); //��ֹ��ǩ����

        var v_nx = i_xynx.val() == "" ? 0 : parseInt(i_xynx.val());

        if (i_xyksrq.val() != "") {
            var d = new Date(i_xyksrq.val().replace(/-/g, "/"));
            var d2 = d.addYears(v_nx);
            i_xyjsrq.val(d2.Format("yyyy-MM-dd"));
            s_xyjsrq.text(d2.Format("yyyy-MM-dd"));
        }

    }

    jQuery(document).ready(function () {
        $("#field6460").change(setNX);
        jQuery("#field6461").bindPropertyChange(function () { setNX(); });

    });

</script>

