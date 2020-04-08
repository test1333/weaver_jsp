<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>

<script type="text/javascript">
var wbje="#field16477";
var sjje="#field_lable7044";
var sfgc = "#field16476";

var fktj="field16492";
var bczfje="#field16475";

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


		var sfgc_val = jQuery(sfgc).val();
                if(sfgc_val  == "0"){	
                        var indexnum1= jQuery("#indexnum1").val();
	                for(var index=0;index <indexnum1;index++)
                        {                   
                               //window.top.Dialog.alert(jQuery("#field16508_"+index+ " option:selected").text());
                               if(jQuery("#field16508_"+index+ " option:selected").text() == "")
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




