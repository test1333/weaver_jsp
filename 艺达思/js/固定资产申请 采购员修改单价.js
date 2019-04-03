<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 var je="#field6701";//金额
 var jebh="#field6702";//金额变化
 var blbh="#field6703";//比例变化
 var sfth="#field6704";//是否退回
 var xgqje_dt1="#field6705_";//修改前金额-明细1
 var jec1_dt1="#field6707_";//金额差1-明细1
 var jec2_dt1="#field6708_";//金额差2-明细1
 var blc1_dt1="#field6728_";//比例差1-明细1
 var blc2_dt1="#field6729_";//比例差2-明细1
 var sfbh_dt1="#field6711_";//是否标红-明细1
  jQuery(document).ready(function () {
  	   jQuery(sfth).val("");
  	   checkCustomize = function(){ 	   
  	   	   jQuery(sfth).val(""); 
  	   	var je_val=jQuery(je).val();
  	   	var jebh_val=jQuery(jebh).val();
  	   	var blbh_val=jQuery(blbh).val();
  	       var indexnum0=  jQuery("#indexnum0").val();
  	       for(var index = 0;index<indexnum0;index++){
  	    	   if(jQuery(xgqje_dt1+index).length>0){
  	    	   	   jQuery(sfbh_dt1+index).val("");
  	    	   	   var xgqje_dt1_val=checknumdate(jQuery(xgqje_dt1+index).val());
  	    	   	   var jec1_dt1_val=checknumdate(jQuery(jec1_dt1+index).val());
  	    	   	   var jec2_dt1_val=checknumdate(jQuery(jec2_dt1+index).val());
  	    	   	   var blc1_dt1_val=checknumdate(jQuery(blc1_dt1+index).val());
  	    	   	   var blc2_dt1_val=checknumdate(jQuery(blc2_dt1+index).val());
  	    	   	   if(Number(xgqje_dt1_val)<Number(je_val)){
  	    	   	   	   if(Number(jec1_dt1_val)>=0){
  	    	   	   	   	  if(Number(jec1_dt1_val)>=Number(jebh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }
  	    	   	          }else{
  	    	   	             if(Number(jec2_dt1_val)>=Number(jebh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }	  
  	    	   	          }
  	    	   	   	   
  	    	          }else{
  	    	          	   if(Number(blc1_dt1_val)>=0){
  	    	   	   	   	  if(Number(blc1_dt1_val)>=Number(blbh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }
  	    	   	          }else{
  	    	   	             if(Number(blc2_dt1_val)>=Number(blbh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }	  
  	    	   	          }
  	    	         }
  	    	   }
  	    	}   
  	    	return true;
  	    }
 })
 function checknumdate(dataval){
  if(dataval == ''){
   	 dataval = "0"; 
  } 	 
  return dataval;
}


</script>

