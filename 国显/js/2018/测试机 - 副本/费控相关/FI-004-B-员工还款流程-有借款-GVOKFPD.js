<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var hkr="#field49711";//还款人
var jkr_dt2="#field52444_";//明细2借款人
jQuery(document).ready(function(){
	checkCustomize = function () {
		
		var hkr_val=jQuery(hkr).val();
		if(hkr_val != ""){
			var indexnum1 = jQuery("#indexnum1").val();
			for(var index=0; index<indexnum1;index++){
				if(jQuery(jkr_dt2+index).length>0){
					var jkr_dt2_val = jQuery(jkr_dt2+index).val();
					if(jkr_dt2_val !="" && hkr_val != jkr_dt2_val){						
						window.top.Dialog.alert("冲借款明细的员工必须与还款人相同，请检查");
						return false;						
					}
				}
			}
		}
		
		
		return true;
	}
	
})

</script>
