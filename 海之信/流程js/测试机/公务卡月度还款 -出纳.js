<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
//分单节点
    var bqhhje = "#field18756";     // 出纳支付金额
	var hkhz = "#field18754";     // 明细1还款汇总
	var dqrq="#field18913";//当前日期
	var hkksrq="#field18893";//还款开始日期
    var hkjsrq="#field18912";//还款结束日期

	jQuery(document).ready(function(){
		checkCustomize = function () {
		var dqrq_val=jQuery(dqrq).val();
		var hkksrq_val=jQuery(hkksrq).val();
		var hkjsrq_val=jQuery(hkjsrq).val();
		if(tab(dqrq_val,hkksrq_val)=="0"){
			alert("友情提示:当前日期不在还款期间内，请检查");
			return false;
		}
		if(tab(hkjsrq_val,dqrq_val)=="0"){
			alert("友情提示:当前日期不在还款期间内，请检查");
			return false;
		}
                var bqhhje_val = jQuery(bqhhje).val();
		var hkhz_val = jQuery(hkhz).val();
		var bqhhje_dim = bqhhje_val.replace(/,/g, "");
		var hkhz_dim = hkhz_val.replace(/,/g, "");
		if(Number(bqhhje_dim) > Number(hkhz_dim)){
			alert("友情提示:出纳金额大于还款金额，请检查");
			return false;
		}
			return true;
		}
	});
function tab(date1,date2){
    var oDate1 = new Date(date1.replace(/-/g, "/"));
    var oDate2 = new Date(date2.replace(/-/g, "/"));
    if(oDate1.getTime() < oDate2.getTime()){
        return "0";
    } else {
        return "1";
    }
}

</script>



