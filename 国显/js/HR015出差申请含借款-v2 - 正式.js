<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var ysssqj_dt="#field39106_";//预算所属期间
    var cbzx_dt="#field39107_";//成本中心
    var km_dt="#field39108_";//科目
    var sqje_dt="#field39112_";//申请金额
    var ydkyys_dt="#field39109_";//明细2-月度可用预算
    var ndkyys_dt="#field39110_";//明细2-年度可用预算
      jQuery(document).ready(function(){
      	  dodetail();
      	  jQuery("button[name=addbutton1]").live("click", function () {
      	  	  	setTimeout('dodetail()',1000);
		  });
		  checkCustomize = function(){
		  	   var indexnum0 =jQuery("#indexnum1").val();
		  	   	 var countnum=0;
		  	     for( var index=0;index<indexnum0;index++){
   	    			 if(  jQuery(ydkyys_dt+index).length>0){
   	    			 	 countnum=countnum+1;
   	    			 	var ysssqj_dt_val=jQuery(ysssqj_dt+index).val().substring(0,4);
   	    			 	var cbzx_dt_val=jQuery(cbzx_dt+index).val();
    		 	 	      var km_dt_val=jQuery(km_dt+index).val();
    		 	 	     var sqje_dt_val=jQuery(sqje_dt+index).val();
    		 	 	     var ydkyys_dt_val=jQuery(ydkyys_dt+index).val();
    		 	 	      var ndkyys_dt_val=jQuery(ndkyys_dt+index).val();
    		 	 	       if(sqje_dt_val == ''){
    		 	 	          sqje_dt_val='0';	  
    		 	 	       }
    		 	 	  	if(ydkyys_dt_val == ''){
    		 	 	         ydkyys_dt_val='0';	  
    		 	 	       }
    		 	 	       if(ndkyys_dt_val == ''){
    		 	 	         ndkyys_dt_val='0';	  
    		 	 	       }
    		 	 	      if(Number(sqje_dt_val)>Number(ydkyys_dt_val)){
    		 	 	            if(confirm("第"+countnum+"行明细申请金额大于月度可用预算")){
				          }else{
				               return false;
				          }
    		 	 	      }
    		 	 	      
   	    			}
   	    		   }
   	    		   countnum=0;
   	    		   for( var index=0;index<indexnum0;index++){
   	    			 if(  jQuery(ydkyys_dt+index).length>0){
   	    			 	 countnum=countnum+1;
   	    			 	 var ysssqj_dt_val=jQuery(ysssqj_dt+index).val().substring(0,4);
   	    			 	var cbzx_dt_val=jQuery(cbzx_dt+index).val();
    		 	 	      var km_dt_val=jQuery(km_dt+index).val();
    		 	 	     var sqje_dt_val=jQuery(sqje_dt+index).val();
    		 	 	     var ydkyys_dt_val=jQuery(ydkyys_dt+index).val();
    		 	 	      var ndkyys_dt_val=jQuery(ndkyys_dt+index).val();
    		 	 	       if(sqje_dt_val == ''){
    		 	 	          sqje_dt_val='0';	  
    		 	 	       }
    		 	 	  	if(ydkyys_dt_val == ''){
    		 	 	         ydkyys_dt_val='0';	  
    		 	 	       }
    		 	 	       if(ndkyys_dt_val == ''){
    		 	 	         ndkyys_dt_val='0';	  
    		 	 	       }
    		 	 	      if(ysssqj_dt_val !='' && cbzx_dt_val !='' && sqje_dt_val !='') {
    		 	 	  	var checkresult=checkyearmoney(cbzx_dt_val,km_dt_val,ysssqj_dt_val,index+1,sqje_dt_val,ndkyys_dt_val);
	    		 	 	  if(checkresult == '1'){
	    		 	 	  	  alert("第"+countnum+"行明细申请金额大于年度可用预算，请检查");
	    		 	 	  	  return false;
	    		 	 	  }
    		 	          }
   	    			}
   	    		   }
   	    		   return true;
		}
      })
      	  
   function dodetail(){
   	    var indexnum0 =jQuery("#indexnum1").val();
   	    for( var index=0;index<indexnum0;index++){
   	    	 if(  jQuery(ydkyys_dt+index).length>0){
   	    	 	 jQuery(ydkyys_dt+index).attr("readonly", "readonly");
   	      	jQuery(ndkyys_dt+index).attr("readonly", "readonly");
   	    	}
   	    }
   }
   function checkyearmoney(cbzx,fykm,year,startindex,checkval,ckeckallval){
   	   var indexnum0 = jQuery("#indexnum1").val();
     	  var values=checkval;
     	  for (var index2= startindex; index2 < indexnum0; index2++) {   
     	  	    if (jQuery(sqje_dt+ index2).length > 0) {
     	  	    	 	var ysssqj_dt_val=jQuery(ysssqj_dt+index2).val().substring(0,4);
   	    			 	var cbzx_dt_val=jQuery(cbzx_dt+index2).val();
    		 	 	      var km_dt_val=jQuery(km_dt+index2).val();
    		 	 	     var sqje_dt_val=jQuery(sqje_dt+index2).val();
    		 	 	  if(sqje_dt_val == ''){
    		 	 	      sqje_dt_val='0';	  
    		 	 	  }
     			if(cbzx_dt_val==cbzx && km_dt_val==fykm && ysssqj_dt_val==year){
     					values=accAdd(values,sqje_dt_val);
     					
     		      }
     	  	   }
     	  }
     	  if(Number(values)>Number(ckeckallval)){
 	 	 return "1";	
 	  }
 	  return "0";
   }
    function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
} 
</script>
