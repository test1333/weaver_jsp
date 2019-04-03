<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cgsqdh="#field51707";//采购订单修改流程
var xghcgsl_dt="#field55770_";//修改后数量 明细1
var yzccgddsl_dt="#field55234_";//已交货数量 明细1
var ycgsl_dt="#field55209_";//原数量 明细1
var xghygdj_dt="#field55771_";//修改后单价 明细1
var yygdj_dt="#field55212_";//原单价 明细1
var xghcgje_dt="#field55675_";//修改后金额原币 明细1

var yjq_dt1="#field55215_";//原交期 明细1
var xghjq_dt1="#field55772_";//修改后交期 明细1
var sm_dt1 ="#field55217_";//税码 明细1
var xghsm_dt1 ="#field55218_";//修改后税码 明细1
var yscbs_dt1="#field55235_";//原删除标识 明细1
var xghscbs_dt1="#field55236_";//修改后删除标识 明细1	
 jQuery(document).ready(function(){
 	 
 	 jQuery("button[name=addbutton0]").css('display','none');
 	 var nodesnum0 = jQuery("#nodesnum0").val();
 	  if(Number(nodesnum0)>0){
 	    	  jQuery(cgsqdh+"_browserbtn").attr('disabled',true);
 	    	}
 	 jQuery("#nodesnum0").bindPropertyChange(function () {
 	 	 var nodesnum00= jQuery("#nodesnum0").val();
 	 	  if(Number(nodesnum00)>0){
 	    	  jQuery(cgsqdh+"_browserbtn").attr('disabled',true);
 	    	 setTimeout('checkoutnum()',1000);
 	    	}else{
 	        jQuery(cgsqdh+"_browserbtn").attr('disabled',false);		
 	     }
 	 })	 
 	 	 checkCustomize = function () {
 	 	var indexnum0 = jQuery("#indexnum0").val();
 	 	 for(var index=0;index<indexnum0;index++){
 	  	 if (jQuery(xghcgsl_dt + index).length > 0) {
                var xghcgsl_dt_val=jQuery(xghcgsl_dt + index).val();
                var yzccgddsl_dt_val=jQuery(yzccgddsl_dt + index).val();
				if(yzccgddsl_dt_val == ""){
					yzccgddsl_dt_val="0";
				}
                  var ycgsl_dt_val=jQuery(ycgsl_dt + index).val();
				  if(ycgsl_dt_val == ""){
					  ycgsl_dt_val="0";
				    }
                  if(xghcgsl_dt_val == ''){
                  	  jQuery(xghcgsl_dt + index).val(ycgsl_dt_val);
                  }
                   var xghygdj_dt_val=jQuery(xghygdj_dt + index).val();
                    var yygdj_dt_val=jQuery(yygdj_dt + index).val();
					if(yygdj_dt_val == ""){
					  yygdj_dt_val="0";
				    }
                    if(xghygdj_dt_val == ''){
                  	  jQuery(xghygdj_dt + index).val(yygdj_dt_val);
                    }
                var  yjq_dt1_val=jQuery(yjq_dt1+index).val();
				var  xghjq_dt1_val=jQuery(xghjq_dt1+index).val();
				if(xghjq_dt1_val == ""){
					jQuery(xghjq_dt1+index).val(yjq_dt1_val);
					jQuery(xghjq_dt1+index+"span").text(yjq_dt1_val);
					
				}
				var  sm_dt1_val=jQuery(sm_dt1+index).val();
				var  xghsm_dt1_val=jQuery(xghsm_dt1+index).val();
				if(xghsm_dt1_val == ""){
					jQuery(xghsm_dt1+index).val(sm_dt1_val);
					jQuery(xghsm_dt1+index+"span").text(sm_dt1_val);
					
				}
               
				xghcgsl_dt_val=jQuery(xghcgsl_dt + index).val();
				xghygdj_dt_val=jQuery(xghygdj_dt + index).val();
                if(Number(xghcgsl_dt_val)<Number(yzccgddsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量小于已交货数量，请检查。");
                     return false;
                }
                 if(Number(ycgsl_dt_val)<Number(xghcgsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量大于原数量，请检查。");
                     return false;
                }
				 if(Number(yygdj_dt_val)<Number(xghygdj_dt_val)){
                	  window.top.Dialog.alert("存在修改后单价大于原单价，请检查。");
                     return false;
                }
				var xghcgje_dt_val = jQuery(xghcgje_dt+index).val();
				if(xghcgje_dt_val == ""){
					xghcgje_dt_val = "0";
				}
				
				if(Number(xghcgje_dt_val) == Number("0")){
					xghcgje_dt_val = accMul(xghcgsl_dt_val,xghygdj_dt_val);
					jQuery(xghcgje_dt+index).val(xghcgje_dt_val);
					jQuery(xghcgje_dt+index+"span").text(xghcgje_dt_val);
				}
					
            }	 
         }
		 calSum(0);
         return true;
       }	 
	   
 setTimeout('checkoutnum()',1000);
 });
  function checkoutnum(){
 	var indexnum0 = jQuery("#indexnum0").val();
 	 for(var index=0;index<indexnum0;index++){
 	   if (jQuery(yzccgddsl_dt+index).length > 0) {
                var yzccgddsl_dt_val=jQuery(yzccgddsl_dt + index).val();
                if(Number(yzccgddsl_dt_val)>Number(0)){
                     jQuery(xghygdj_dt+index).attr("readonly", "readonly");
                }
                
            }	 
       }
 } 
function accMul(arg1,arg2)
{
  var m=0,s1=arg1.toString(),s2=arg2.toString();
  try{m+=s1.split(".")[1].length}catch(e){}
  try{m+=s2.split(".")[1].length}catch(e){}
  return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
}

</script>




