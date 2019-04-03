<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var ckje="#field51474";//欠款金额
var jklx="#field49508";//借款类型
var jkr="#field49714";//借款人
var jkje="#field49510";//借款金额
var jklx_dt1="#field49518_";//借款类型
var disjklx_dt1="#field49518_";//借款类型
var yg_dt2="#field49519_";//明细2员工
var zfje_dt2="#field49526_";//明细2支付金额
jQuery(document).ready(function(){
	jQuery(jkje).bindPropertyChange(function (){ 
		var jkje_val=jQuery(jkje).val();
		if(jkje_val==""){
			jkje_val = "0";
		}
		var indexnum1 = jQuery("#indexnum1").val();
		for(var index=0; index<indexnum1;index++){
			if(jQuery(zfje_dt2+index).length>0){	
				jQuery(zfje_dt2+index).val(jkje_val);
			}
		}
	
	});
	checkCustomize = function () {
		var  jklx_val=jQuery(jklx).val();
		var indexnum0 = jQuery("#indexnum0").val();
		for(var index=0; index<indexnum0;index++){
			if(jQuery(jklx_dt1+index).length>0){
				jQuery(jklx_dt1+index).val(jklx_val);
				jQuery(disjklx_dt1+index).val(jklx_val);
			}
		}
		var jkr_val=jQuery(jkr).val();
		if(jkr_val != ""){
			var indexnum1 = jQuery("#indexnum1").val();
			for(var index=0; index<indexnum1;index++){
				if(jQuery(yg_dt2+index).length>0){
					var yg_dt2_val = jQuery(yg_dt2+index).val();
					if(yg_dt2_val !="" && jkr_val != yg_dt2_val){						
						window.top.Dialog.alert("支付明细的员工必须与借款人相同，请检查");
						return false;						
					}
				}
			}
		}
		var ckje_val=jQuery(ckje).val();
		if(ckje_val == ""){
			ckje_val = "0";
		}
		
		if(Number(ckje_val)>Number("0")){
			window.top.Dialog.alert("借款人存在欠款金额无法提交，请检查");
			return false;
			
		}
		
		return true;
	}
	
})

</script>
