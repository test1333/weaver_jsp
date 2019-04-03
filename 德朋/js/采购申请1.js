<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var ysqj_dt1="#field6522_";
jQuery(document).ready(function(){
	checkCustomize = function(){ 
		var indexnum0 = jQuery("#indexnum0").val();
		var checkval1='';
		 for (var index0= 0; index0 < indexnum0; index0++) {   
		 	   if (jQuery(ysqj_dt1 + index0).length > 0) {
		 	   	   var ysqj_dt1_val = jQuery(ysqj_dt1 + index0).val();
		 	   	   if(ysqj_dt1_val ==''){
		 	   		continue;
		 	   		}
		 	   	 if(checkval1 ==''){
		 	  	    checkval1 = ysqj_dt1_val;
		 	  	  }else{
		 	  	   if(ysqj_dt1_val != checkval1){
		 	  	     alert("预算期间不一致，请查看");
		 	  	     return false;
		 	  	   }	  	  
		 	    	}
		 	   	   
		 	   	   
		 	   }
		 }
	 return true;
	}	
});	

</script>
