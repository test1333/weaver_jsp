<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cgddh="#field7177";
var yjhsl="#field8010_";//已交货数量
var xghdj="#field7199_";//修改后单价
var xghsl="#field7196_";//修改后数量
 jQuery(document).ready(function(){
 	 
 	 jQuery("button[name=addbutton0]").css('display','none');
 	 var nodesnum0 = jQuery("#nodesnum0").val();
 	  if(Number(nodesnum0)>0){
 	    	  jQuery(cgddh+"_browserbtn").attr('disabled',true);
 	    	}
 	 jQuery("#nodesnum0").bindPropertyChange(function () {
 	 	 var nodesnum00= jQuery("#nodesnum0").val();
 	 	  if(Number(nodesnum00)>0){
 	    	  jQuery(cgddh+"_browserbtn").attr('disabled',true);
 	    	  setTimeout('checkoutnum()',1000);
 	    	}else{
 	        jQuery(cgddh+"_browserbtn").attr('disabled',false);		
 	     }
 	 })	 
 	 checkCustomize = function () {
 	 	var indexnum0 = jQuery("#indexnum0").val();
 	 	 for(var index=0;index<indexnum0;index++){
 	  	 if (jQuery(yjhsl + index).length > 0) {
                var yjhsl_val=jQuery(yjhsl + index).val();
                var xghsl_val=jQuery(xghsl + index).val();
                if(Number(xghsl_val)<Number(yjhsl_val)){
                	  window.top.Dialog.alert("存在修改后数量小于已交货数量，请检查。");
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
 	   if (jQuery(yjhsl + index).length > 0) {
                var yjhsl_val=jQuery(yjhsl + index).val();
                if(Number(yjhsl_val)>Number(0)){
                     jQuery(xghdj+index).attr("readonly", "readonly");
        }
            }	 
       }
 } 
</script>
