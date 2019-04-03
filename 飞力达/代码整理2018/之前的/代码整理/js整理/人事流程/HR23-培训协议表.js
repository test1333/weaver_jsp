<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    根据活动编号带出活动名称,活动结束日期(协议开始日期)
    培训协议编号根据规则:员工工号+培训活动编号生成
    "协议结束日期=协议开始日期+协议年限
    (看泛微配置是否可以实现)"

    */


    checkCustomize = function () {
        var isSuccess = true;
        //培训协议编号根据规则:员工工号+培训活动编号生成
        var i_pxhdbh = $("#field6876"); //培训活动编号
        var s_pxhdbh = $("#field6876span"); //培训活动编号
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
        var i_xynx = $("#field6460"); //协议年限
        var i_xyksrq = $("#field6461"); //协议开始日期
        var i_xyjsrq = $("#field6462"); //协议结束日期

        var s_xyksrq = $("#field6461span"); //起始续签日期
        var s_xyjsrq = $("#field6462span"); //截止续签日期

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

