<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>

<script type="text/javascript">
var wbje="#field16808";
var sjje="#field_lable7044";
var sfgc = "#field16807";

var fktj="field16823";
var bczfje="#field16806";
var sjbxje_dt1 = "#field16848_";//明细1实际报销金额
var bxje_dt1 = "#field16803_";//明细1报销金额
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
						Dialog.alert("明细1中存在实际报销金额大于发票金额的数据，请检查");
						return false; 
					}
				}
			}
                var fktj_Val = cus_getFieldValue(fktj);
                
                if(fktj_Val === "4"){	
                        var bczfje_Val = jQuery(bczfje).val(); 

                        if(floatFormat(bczfje_Val) > 0.00)
                         {
		                   window.top.Dialog.alert("付款条件为“冲预付款”的，本次支付金额 必须等于0，请核查或与财务联系，谢谢！");
			           return false;
			}
		}


		var sfgc_val = jQuery(sfgc).val();
                if(sfgc_val  == "0"){	
                        var indexnum1= jQuery("#indexnum1").val();
	                for(var index=0;index <indexnum1;index++)
                        {                   
                               //window.top.Dialog.alert(jQuery("#field16839_"+index+ " option:selected").text());
                               if(jQuery("#field16839_"+index+ " option:selected").text() == "")
                               {
                                   var RowId = index + 1;
		                   window.top.Dialog.alert("成本中心明细第" + RowId + "行请选择品牌！");
			           return false;
                               }
			}
		}
		
                return true;
	}	

});
</script>	




