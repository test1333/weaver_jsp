<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript"> 
  var syysje="#field12995";//剩余预算金额
  var bgce="#field12975";//变更差额
  var ysje_dt1="#field12999_";//预算金额-明细1
  var htyyyyje_dt1="#field12998_";//合同已用预算金额-明细1
  jQuery(document).ready(function(){
  	  jQuery(syysje).attr("readonly","readonly");
  	  checkCustomize = function (){
  	  	var countnum=0;
  	    var indexnum0=jQuery("#indexnum0").val();
  	      for(var index=0;index <indexnum0;index++){
        	 if( jQuery(ysje_dt1+index).length>0){
        	 	 countnum = countnum+1;
        	 	 var ysje_dt1_val=jQuery(ysje_dt1+index).val().replace(/,/g,'');
        	 	 var htyyyyje_dt1_val=jQuery(htyyyyje_dt1+index).val();
        	 	 if(ysje_dt1_val==''){
        	 	    ysje_dt1_val='0';	 
        	 	 }
        	 	 if(htyyyyje_dt1_val==''){
        	 	    htyyyyje_dt1_val='0';	 
        	 	 }
        	 	 if(Number(ysje_dt1_val)<Number(htyyyyje_dt1_val)){
        	 	   	Dialog.alert("第"+countnum+"行明细，预算金额小于关联合同已用金额，请检查");
        	        return false;	 
        	     }
        	 }
          }	 
        var syysje_val=jQuery(syysje).val();
        var bgce_val=jQuery(bgce).val();
        if(syysje_val==''){
        	syysje_val='0';	 
        }
        if(bgce_val==''){
        	bgce_val='0';	 
        }
        if(Number(syysje_val)<Number(bgce_val)){
        	Dialog.alert("调整后的预算变更差额大于剩余预算金额，请检查");
           return false;	 
        }
        return true;
      }
  	  	 
 
  })
</script>
