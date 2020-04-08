<script type="text/javascript">
var wbje="#field15419";
var sjje="#field_lable7006";
var sjbxje_dt1 = "#field17922_";//明细1实际报销金额
var bxje_dt1 = "#field15440_";//明细1报销金额
jQuery(document).ready(function(){
	jQuery(wbje).attr("readonly", "readonly");
	jQuery(sjje).attr("readonly", "readonly");
	checkCustomize = function () {
		var indexnum0=jQuery("#indexnum0").val(); 
        for( var index=0;index<indexnum0;index++){
            if( jQuery(sjbxje_dt1+index).length>0){
                var sjbxje_dt1_val = jQuery(sjbxje_dt1+index).val();
				var bxje_dt1_val = jQuery(bxje_dt1+index).val();
				if(sjbxje_dt1_val==""){
						sjbxje_dt1_val = "0";
				}
				if(bxje_dt1_val==""){
						bxje_dt1_val = "0";
				}
                if(Number(sjbxje_dt1_val)>Number(bxje_dt1_val)){
                	Dialog.alert("明细1中存在实际报销金额大于费用金额的数据，请检查");
                	return false; 
                }
            }
        }
		return true;
	
	}
});
</script>	
