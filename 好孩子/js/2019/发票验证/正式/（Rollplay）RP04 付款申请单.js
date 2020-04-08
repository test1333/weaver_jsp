<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">

var wbje="#field15556";
var sjje="#field_lable7044";
var fktj="field15571";
var bczfje="#field15554";
var sjbxje_dt1 = "#field17841_";//明细1实际报销金额
var bxje_dt1 = "#field15551_";//明细1报销金额
jQuery(document).ready(function(){
	jQuery(wbje).attr("readonly", "readonly");
	jQuery(sjje).attr("readonly", "readonly");


        checkCustomize = function () {
		var fktj_Val = cus_getFieldValue(fktj);
                
                if(fktj_Val === "4"){	
                        var bczfje_Val = jQuery(bczfje).val(); 

                        if(floatFormat(bczfje_Val) > 0.00)
                         {
		                   window.top.Dialog.alert("付款条件为“冲预付款”的，本次支付金额 必须等于0，请核查或与财务联系，谢谢！");
			           return false;
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














