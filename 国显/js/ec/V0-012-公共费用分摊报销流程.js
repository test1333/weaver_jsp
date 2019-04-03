<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var ysssqj_dt1="#field10178_";//预算所属期间
    var cbzx_dt1="#field10180_";//成本中心
    var km_dt1="#field10181_";//科目
    var sqje_dt1="#field10186_";//申请金额
    var ndkyje_dt1="#field11881_";//年度可用金额
    
    var fplx_dt1="#field12493_";//发票类型
    var fphm_dt1="#field12494_";//发票号码
    var sfcf_dt1="#field12496_";//是否重复
	
	var djbh="#field10161";//单据编号
    jQuery(document).ready(function(){
    	checkCustomize = function(){
			var djbh_val = jQuery(djbh).val(); 
    		 var indexnum0 = jQuery("#indexnum0").val();
    		 var countnum=0;
    		 for(var index=0; index<indexnum0;index++){
    		 	 if(jQuery(ysssqj_dt1+index).length>0){
    		 	 	 countnum=countnum+1;
    		 	 	 var ysssqj_dt1_val=jQuery(ysssqj_dt1+index).val().substring(0,4);
    		 	 	 var cbzx_dt1_val=jQuery(cbzx_dt1+index).val();
    		 	 	 var km_dt1_val=jQuery(km_dt1+index).val();
    		 	 	 var sqje_dt1_val=jQuery(sqje_dt1+index).val();
    		 	 	  var ndkyje_dt1_val=jQuery(ndkyje_dt1+index).val();
    		 	 	  if(sqje_dt1_val == ''){
    		 	 	      sqje_dt1_val='0';	  
    		 	 	  }
    		 	 	  if(ndkyje_dt1_val == ''){
    		 	 	      ndkyje_dt1_val='0';	  
    		 	 	  }
    		 	 	  if(ysssqj_dt1_val !='' && cbzx_dt1_val !='' && sqje_dt1_val !='') {
    		 	 	  var checkresult=checkyearmoney(cbzx_dt1_val,km_dt1_val,ysssqj_dt1_val,index+1,sqje_dt1_val,ndkyje_dt1_val);
    		 	 	  if(checkresult == '1'){
    		 	 	  	  Dialog.alert("第"+countnum+"行明细当前申请金额大于年度可用预算，请检查");
    		 	 	  	  return false;
    		 	 	  }
    		 	    	 }
    		 	    	  var fplx_dt1_val=jQuery(fplx_dt1+index).val();
    		 	    	  var fphm_dt1_val=jQuery(fphm_dt1+index).val();
    		 	    	   var sfcf_dt1_val=jQuery(sfcf_dt1+index).val();
    		 	    	   if(fplx_dt1_val == "1" && fphm_dt1_val !=""){
    		 	    	   	   if(sfcf_dt1_val !=""&& sfcf_dt1_val != djbh_val){
    		 	    	   	    Dialog.alert("第"+countnum+"行明细的发票号码（"+fphm_dt1_val+"）已在流程编号为（"+sfcf_dt1_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    		return true;
       }
   });
   function checkyearmoney(cbzx,fykm,year,startindex,checkval,ckeckallval){
   	   var indexnum0 = jQuery("#indexnum0").val();
     	  var values=checkval;
     	  for (var index2= startindex; index2 < indexnum0; index2++) {   
     	  	    if (jQuery(sqje_dt1+ index2).length > 0) {
     	  	    	 var ysssqj_dt1_val=jQuery(ysssqj_dt1+index2).val().substring(0,4);
    		 	 	 var cbzx_dt1_val=jQuery(cbzx_dt1+index2).val();
    		 	 	 var km_dt1_val=jQuery(km_dt1+index2).val();
    		 	 	 var sqje_dt1_val=jQuery(sqje_dt1+index2).val();
    		 	 	  if(sqje_dt1_val == ''){
    		 	 	      sqje_dt1_val='0';	  
    		 	 	  }
     			if(cbzx_dt1_val==cbzx && km_dt1_val==fykm && ysssqj_dt1_val==year){
     					values=accAdd(values,sqje_dt1_val);
     					
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


