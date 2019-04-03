<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cgsqdh="#field51632";
var xghcgsl_dt="#field51639_";//修改后采购数量
var yzccgddsl_dt="#field51640_";//已转成采购订单数量
var ycgsl_dt="#field51638_";//原采购数量
var xghygdj_dt="#field51643_";//修改后预估单价
var yygdj_dt="#field51642_";//预估单价
var ywlms_dt="#field51637_";//原物料描述
var xghwlms_dt="#field51672_";//修改后物料描述
var wlbh_dt="#field51636_";//物料编号
var xghcgje_dt="#field51664_";//修改后采购金额
 jQuery(document).ready(function(){
 	 
 	 //jQuery("button[name=addbutton0]").css('display','none');
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
                  
                  var ywlms_dt_val=jQuery(ywlms_dt + index).val();
                    var xghwlms_dt_val=jQuery(xghwlms_dt+ index).val();
                     if(xghwlms_dt_val == ''){
                  	  jQuery(xghwlms_dt + index).val(ywlms_dt_val);
                  }
				xghcgsl_dt_val=jQuery(xghcgsl_dt + index).val();
				xghygdj_dt_val=jQuery(xghygdj_dt + index).val();
                if(Number(xghcgsl_dt_val)<Number(yzccgddsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量小于已转成采购订单数量，请检查。");
                     return false;
                }
                 if(Number(ycgsl_dt_val)<Number(xghcgsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量大于原采购数量，请检查。");
                     return false;
                }
				 if(Number(yygdj_dt_val)<Number(xghygdj_dt_val)){
                	  window.top.Dialog.alert("存在修改后单价大于原采购单价，请检查。");
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
                var wlbh_dt_val=jQuery(wlbh_dt+index).val();
                if(wlbh_dt_val != ''){
                	jQuery(xghwlms_dt+index).attr("readonly", "readonly");
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

