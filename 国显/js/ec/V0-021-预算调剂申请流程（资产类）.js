<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
     var xmsbmc_dt1="#field11220_";//��Ŀ�豸����
    var zckyys_dt1="#field11099_";//ת������Ԥ��
    var bgje_dt1="#field11126_";//������
 
    jQuery(document).ready(function(){
    	checkCustomize = function(){
    		 var indexnum0 = jQuery("#indexnum0").val();
    		 var countnum=0;
    		 for(var index=0; index<indexnum0;index++){
    		 	 if(jQuery(xmsbmc_dt1+index).length>0){
    		 	 	 countnum=countnum+1;
    		 	 	 var xmsbmc_dt1_val=jQuery(xmsbmc_dt1+index).val();
    		 	 	 var zckyys_dt1_val=jQuery(zckyys_dt1+index).val();
    		 	 	 var bgje_dt1_val=jQuery(bgje_dt1+index).val();
    		 	 
    		 	 	  if(zckyys_dt1_val == ''){
    		 	 	      zckyys_dt1_val='0';	  
    		 	 	  }
    		 	 	  if(bgje_dt1_val == ''){
    		 	 	      bgje_dt1_val='0';	  
    		 	 	  }
    		 	 	  if(xmsbmc_dt1_val !='' && zckyys_dt1_val !='' && bgje_dt1_val !='') {
    		 	 	  var checkresult=checkyearmoney(xmsbmc_dt1_val,index+1,bgje_dt1_val,zckyys_dt1_val);
    		 	 	  if(checkresult == '1'){
    		 	 	  	  Dialog.alert("��"+countnum+"����ϸ���������ת������Ԥ�㣬����");
    		 	 	  	  return false;
    		 	 	  }
    		 	    	 }
    		        }
    		}
    		return true;
       }
   });
   function checkyearmoney(xmsbmc,startindex,checkval,ckeckallval){
   	   var indexnum0 = jQuery("#indexnum0").val();
     	  var values=checkval;
     	  for (var index2= startindex; index2 < indexnum0; index2++) {   
     	  	    if (jQuery(xmsbmc_dt1+ index2).length > 0) {
     	  	     var xmsbmc_dt1_val=jQuery(xmsbmc_dt1+index2).val();
    		 	 	 var bgje_dt1_val=jQuery(bgje_dt1+index2).val();
    		 	 	  if(bgje_dt1_val == ''){
    		 	 	      bgje_dt1_val='0';	  
    		 	 	  }
     			if(xmsbmc_dt1_val==xmsbmc ){
     					values=accAdd(values,bgje_dt1_val);
     					
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
