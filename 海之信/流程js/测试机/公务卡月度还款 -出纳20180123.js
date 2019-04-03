<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
//分单节点
    var bqhhje = "#field18756";     // 出纳支付金额
	var hkhz = "#field18754";     // 明细1还款汇总

	jQuery(document).ready(function(){
		checkCustomize = function () {
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

</script>



