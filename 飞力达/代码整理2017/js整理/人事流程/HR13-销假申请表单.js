<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">

    /*
    6.1) 请假单号只能输入一次
    6.2) 根据请假单号带出请假类型,开始日期,开始时间,结束日期,结束时间,请假时长(是否可以在OA中设定)
    
    6.3) 销假开始日期: 大于等于原开始日期
    6.4) 销假开始时间: 大于等于原开始时间
    6.5) 销假结束日期: 小于等于结束日期
    6.6) 销假结束时间: 小于等于结束时间
    6.7) 销假类型为全部：自动带出开始时间/结束时间

    */
    var setDT = function () {
        var i_xjlx = $("#field6637"); //销假类型
        if (i_xjlx.val() == "1") {
            //设置全部
            var i_ksrq = $("#field6632"); //开始日期
            var i_kssj = $("#field6633"); //开始时间
            var i_jsrq = $("#field6634"); //结束日期
            var i_jssj = $("#field6635"); //结束时间

            var id_xjksrq = "#field6638"; //销假开始日期
            var id_xjkssj = "#field6639"; //销假开始时间
            var id_xjjsrq = "#field6640"; //销假结束日期
            var id_xjjssj = "#field6641"; //销假结束时间

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
        //请假
        var i_ksrq = $("#field6632"); //开始日期
        var i_kssj = $("#field6633"); //开始时间
        var i_jsrq = $("#field6634"); //结束日期
        var i_jssj = $("#field6635"); //结束时间

        //销假
        var i_xjksrq = $("#field6638"); //销假开始日期
        var i_xjkssj = $("#field6639"); //销假开始时间
        var i_xjjsrq = $("#field6640"); //销假结束日期
        var i_xjjssj = $("#field6641"); //销假结束时间

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
            window.top.Dialog.alert("销假开始日期: 大于等于原开始日期<br/>销假开始时间: 大于等于原开始时间<br/>销假结束日期: 小于等于结束日期<br/>销假结束时间: 小于等于结束时间");
            isSuccess = false;
            return false;

        }

        return isSuccess;
    }




</script>

