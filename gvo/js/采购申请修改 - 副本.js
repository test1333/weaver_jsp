<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cgsqdh="#field35034";
var xghcgsl_dt="#field35042_";//修改后采购数量
var yzccgddsl_dt="#field35043_";//已转成采购订单数量
var ycgsl_dt="#field35041_";//原采购数量
var xghygdj_dt="#field35046_";//修改后预估单价
var yygdj_dt="#field35045_";//预估单价
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
                  var ycgsl_dt_val=jQuery(ycgsl_dt + index).val();
                  if(xghcgsl_dt_val == ''){
                  	  jQuery(xghcgsl_dt + index).val(ycgsl_dt_val);
                  }
                   var xghygdj_dt_val=jQuery(xghygdj_dt + index).val();
                    var yygdj_dt_val=jQuery(yygdj_dt + index).val();
                     if(xghygdj_dt_val == ''){
                  	  jQuery(xghygdj_dt + index).val(yygdj_dt_val);
                  }
                if(Number(xghcgsl_dt_val)<Number(yzccgddsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量小于已转成采购订单数量，请检查。");
                     return false;
                }
                 if(Number(ycgsl_dt_val)<Number(xghcgsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量大于已原采购数量，请检查。");
                     return false;
                }
            }	 
         }
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
</script>
