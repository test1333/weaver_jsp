<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var ccksrq="#field6324";//
var ccjsrq="#field6325";//
var fyfsrq="#field6335_";//
jQuery(document).ready(function(){
	checkCustomize = function () {
		var ccksrq_val = jQuery(ccksrq).val();
		var ccjsrq_val = jQuery(ccjsrq).val();
		var indexnum0=jQuery("#indexnum0").val();
		for(var index=0;index<indexnum0;index++){
			if(jQuery(fyfsrq+index).length>0){
				var fyfsrq_val=jQuery(fyfsrq+index).val();
				if(fyfsrq_val == ""){
					continue;
				}else{
					if(fyfsrq_val < ccksrq_val || fyfsrq_val>ccjsrq_val){
						alert("费用发生日期不允许在出差日期范围外");
						return false;
					}
					
				}
			}
			
		}
		return true;
	}
});
</script>
