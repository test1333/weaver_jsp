<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
     var jhsl_dt1="#field5892_";//明细1-计划数量
     var jhdj_dt1="#field5893_";//明细1-计划单价
     var sjsl_dt1="#field7519_";//明细1-实际数量
     var sjdj_dt1="#field7520_";//明细1-实际单价
 	 var sfcb ="#field7525";//是否超标
     var sfcb2 ="#disfield7525";//是否超标

     jQuery(document).ready(function(){
     	 checkCustomize = function () {
     	    var indexnum0 = jQuery("#indexnum0").val();
     	    var countnum=0;
     	    jQuery(sfcb).val("0");
        	jQuery(sfcb2).val("0");

 	 	    for(var index=0;index<indexnum0;index++){
 	 	 		 if (jQuery(jhsl_dt1 + index).length > 0) {
 	 	 		 	  countnum=countnum+1;
 	 	 		 	  var jhsl_dt1_val=jQuery(jhsl_dt1+ index).val();
 	 	 		 	  var jhdj_dt1_val=jQuery(jhdj_dt1+ index).val();
 	 	 		 	  var sjsl_dt1_val=jQuery(sjsl_dt1+ index).val();
 	 	 		 	  var sjdj_dt1_val=jQuery(sjdj_dt1+ index).val();
 	 	 		 	  if(jhsl_dt1_val==''){
 	 	 	 	 	 	jhsl_dt1_val="0";
 	 	 	          }
 	 	 	          if(jhdj_dt1_val==''){
 	 	 	 	 	 	jhdj_dt1_val="0";
 	 	 	          }
 	 	 	          if(sjsl_dt1_val==''){
 	 	 	 	 	 	sjsl_dt1_val="0";
 	 	 	          }
 	 	 	          if(sjdj_dt1_val==''){
 	 	 	 	 	 	sjdj_dt1_val="0";
 	 	 	          }
 	 	 	          if(Number(sjsl_dt1_val)>Number(jhsl_dt1_val)){
 	 	 	          	    jQuery(sfcb).val("1");
        						jQuery(sfcb2).val("1");
 	 	 	          	  if(confirm("第"+countnum+"行明细实际数量大于计划数量，请检查")){
 	 	 	          	  	
				          }else{
				               return false;
				          }
 	 	 	           
 	 	 	      	  }
 	 	 	      	  if(Number(sjdj_dt1_val)>Number(jhdj_dt1_val)){
 	 	 	      	  	  jQuery(sfcb).val("1");
        						jQuery(sfcb2).val("1");
 	 	 	      	  	   if(confirm("第"+countnum+"行明细实际单价大于计划单价，请检查")){
 	 	 	          	  	  
				          }else{
				               return false;
				          }
 	 	 	      	  }
 	 	 		}
 	 	  	}
 	 	  	return true;	 
     	 }
     });	 
</script>
