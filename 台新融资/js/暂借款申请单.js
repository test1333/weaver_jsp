<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var je = "#field6366";//金额
var syje = "#field6645";//剩余金额
var xzxm = "#field6644";//选择项目
jQuery(document).ready(function () {
	checkCustomize = function(){
		var xzxm_val = jQuery(xzxm).val();
		var je_val = jQuery(je).val();
		var syje_val = jQuery(syje).val();
		if(je_val == ""){
			je_val = "0";
		}
		if(syje_val == ""){
			syje_val = "0";
		}
		if(xzxm_val != "" && xzxm_val != " "){
			if(Number(je_val) > Number(syje_val)){
				alert("金额大于项目剩余金额，请检查");
				return false;
				
			}
		}
		return true;
	}	
})
</script>
