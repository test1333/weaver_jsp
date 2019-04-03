<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    生效日期 是 OA手工输入（不能早于申请日期） 
    截止日期 是 "OA手工输入（如果没有截止日期，
    则默认为9999/12/31）" 
    */


    checkCustomize = function () {
        var isSuccess = true;
        $("td[name='td_sxrq']").each(function () {
            var tr = $(this).closest("tr");
            var i_sxrq = $(this).find("input");
            var i_jzrq = tr.find("td[name='td_jzrq'] input");

            var s_sxrq = tr.find("td[name='td_sxrq'] span");
            var s_jzrq = tr.find("td[name='td_jzrq'] span");

            if (i_sxrq.val() == "") {
                i_sxrq.val($("#field6445").val());
                s_sxrq.text($("#field6445").val());
            }
            if (i_jzrq.val() == "") {
                i_jzrq.val("9999-12-31");
                s_jzrq.text("9999-12-31");
            }


            var d1 = new Date(i_sxrq.val().replace(/-/g, "/"));
            var d2 = new Date(i_jzrq.val().replace(/-/g, "/"));
            var d = new Date($("#field6445").val().replace(/-/g, "/"));
            if (d1 < d) {
                window.top.Dialog.alert("生效日期" + d1.Format("yyyy-MM-dd") + "不能早于申请日期！");
                isSuccess = false;
                return false;
            }
            if (d2 < d1) {
                window.top.Dialog.alert("截止日期" + d2.Format("yyyy-MM-dd") + "不能早于生效日期！");
                isSuccess = false;
                return false;
            }



        });
        return isSuccess;
    }

</script>

