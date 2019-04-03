<script type="text/javascript">
var jklx="#field7066";//借款类型
var syje="#field8023";
var jkzje="#field11011";
jQuery(document).ready(function(){
	
	
	checkCustomize = function () {
		var jklx_val = jQuery(jklx).val();
		var syje_val = jQuery(syje).val();
		var jkzje_val = jQuery(jkzje).val();
		if (syje_val == ""){
			syje_val = "0";
		}
		if( jklx_val != ""){
			if(Number(syje_val)>Number("0")){
				
		    window.top.Dialog.alert("该借款类型存在借款,无法再次借款。");
			return false;
			}
			if(Number(jkzje_val)>Number("0")){
				
		    window.top.Dialog.alert("该借款类型存在借款,无法再次借款。");
			return false;
			}
		}
		return true;
	}
	
});
</script>	
