<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
     var ysssqj_dt1="#field11766_";//Ԥ�������ڼ�
    var cbzx_dt1="#field11768_";//�ɱ�����
    var km_dt1="#field11769_";//��Ŀ
    var sqje_dt1="#field11771_";//������
    var ndkyje_dt1="#field11951_";//��ȿ��ý��
    jQuery(document).ready(function(){
    	checkCustomize = function(){
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
    		 	 	  	  Dialog.alert("��"+countnum+"����ϸ��ǰ�����������ȿ���Ԥ�㣬����");
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
