<script type="text/javascript">
var wbje="#field17509";
var sjje="#field_lable7044";
var sfgc = "#field17508";
var sjbxje_dt1 = "#field17653_";//明细1实际报销金额
var bxje_dt1 = "#field17504_";//明细1报销金额
jQuery(document).ready(function(){
	jQuery(wbje).attr("readonly", "readonly");
	jQuery(sjje).attr("readonly", "readonly");

        checkCustomize = function () {
		var sfgc_val = jQuery(sfgc).val();
                if(sfgc_val  == "0"){	
                        var indexnum1= jQuery("#indexnum0").val();
	                for(var index=0;index <indexnum1;index++)
                        {                   
                               //window.top.Dialog.alert(jQuery("#field17527_"+index+ " option:selected").text());
                               if(jQuery("#field17527_"+index+ " option:selected").text() == "")
                               {
                                   var RowId = index + 1;
		                   window.top.Dialog.alert("费用明细第" + RowId + "行请选择品牌！");
			           return false;
                               }
			}
		}
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


