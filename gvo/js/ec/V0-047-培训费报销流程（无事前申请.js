<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
     var ysssqj_dt1="#field11717_";//Ԥ�������ڼ�
    var cbzx_dt1="#field11719_";//�ɱ�����
    var km_dt1="#field11720_";//��Ŀ
    var sqje_dt1="#field11722_";//������
    var ndkyje_dt1="#field11952_";//��ȿ��ý��
    
    var fplx_dt4="#field12517_";//��Ʊ����4
    var fphm_dt4="#field12518_";//��Ʊ����4
    var sfcf_dt4="#field12520_";//�Ƿ��ظ�4
    	   
    var fplx_dt5="#field12513_";//��Ʊ����5
    var fphm_dt5="#field12514_";//��Ʊ����5
    var sfcf_dt5="#field12516_";//�Ƿ��ظ�5
    	   
    var fplx_dt6="#field12521_";//��Ʊ����6
    var fphm_dt6="#field12522_";//��Ʊ����6
    var sfcf_dt6="#field12524_";//�Ƿ��ظ�6
    	   
    var fplx_dt7="#field12525_";//��Ʊ����7
    var fphm_dt7="#field12526_";//��Ʊ����7
    var sfcf_dt7="#field12528_";//�Ƿ��ظ�7
	
	var djbh="#field11629";//���ݱ��
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
    		 	 	  	  Dialog.alert("��"+countnum+"����ϸ��ǰ�����������ȿ���Ԥ�㣬����");
    		 	 	  	  return false;
    		 	 	  }
    		 	    	 }
    		        }
    		}
    			var indexnum3 = jQuery("#indexnum3").val();
    		 var countnum4=0;
    		 for(var index=0; index<indexnum3;index++){
    		 	 if(jQuery(fplx_dt4+index).length>0){
    		 	 	 countnum4=countnum4+1;
    		 	 	  var fplx_dt4_val=jQuery(fplx_dt4+index).val();
    		 	    	  var fphm_dt4_val=jQuery(fphm_dt4+index).val();
    		 	    	   var sfcf_dt4_val=jQuery(sfcf_dt4+index).val();
    		 	    	   if(fplx_dt4_val == "1" && fphm_dt4_val !=""){
    		 	    	   	   if(sfcf_dt4_val !=""&& sfcf_dt4_val != djbh_val){
    		 	    	   	    Dialog.alert("��ͨ�� ��"+countnum4+"����ϸ�ķ�Ʊ���루"+fphm_dt4_val+"���������̱��Ϊ��"+sfcf_dt4_val+"����������ʹ�ã�����");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    			var indexnum4 = jQuery("#indexnum4").val();
    		 var countnum5=0;
    		 for(var index=0; index<indexnum4;index++){
    		 	 if(jQuery(fplx_dt5+index).length>0){
    		 	 	 countnum5=countnum5+1;
    		 	 	  var fplx_dt5_val=jQuery(fplx_dt5+index).val();
    		 	    	  var fphm_dt5_val=jQuery(fphm_dt5+index).val();
    		 	    	   var sfcf_dt5_val=jQuery(sfcf_dt5+index).val();
    		 	    	   if(fplx_dt5_val == "1" && fphm_dt5_val !=""){
    		 	    	   	   if(sfcf_dt5_val !=""&& sfcf_dt5_val != djbh_val){
    		 	    	   	    Dialog.alert("ס�޷ѵ�"+countnum5+"����ϸ�ķ�Ʊ���루"+fphm_dt5_val+"���������̱��Ϊ��"+sfcf_dt5_val+"����������ʹ�ã�����");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    		
    			var indexnum5 = jQuery("#indexnum5").val();
    		 var countnum6=0;
    		 for(var index=0; index<indexnum5;index++){
    		 	 if(jQuery(fplx_dt6+index).length>0){
    		 	 	 countnum6=countnum6+1;
    		 	 	  var fplx_dt6_val=jQuery(fplx_dt6+index).val();
    		 	    	  var fphm_dt6_val=jQuery(fphm_dt6+index).val();
    		 	    	   var sfcf_dt6_val=jQuery(sfcf_dt6+index).val();
    		 	    	   if(fplx_dt6_val == "1" && fphm_dt6_val !=""){
    		 	    	   	   if(sfcf_dt6_val !=""&& sfcf_dt6_val != djbh_val){
    		 	    	   	    Dialog.alert("�Ͳ��ѵ�"+countnum6+"����ϸ�ķ�Ʊ���루"+fphm_dt6_val+"���������̱��Ϊ��"+sfcf_dt6_val+"����������ʹ�ã�����");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    			var indexnum6 = jQuery("#indexnum6").val();
    		 var countnum7=0;
    		 for(var index=0; index<indexnum6;index++){
    		 	 if(jQuery(fplx_dt7+index).length>0){
    		 	 	 countnum7=countnum7+1;
    		 	 	  var fplx_dt7_val=jQuery(fplx_dt7+index).val();
    		 	    	  var fphm_dt7_val=jQuery(fphm_dt7+index).val();
    		 	    	   var sfcf_dt7_val=jQuery(sfcf_dt7+index).val();
    		 	    	   if(fplx_dt7_val == "1" && fphm_dt7_val !=""){
    		 	    	   	   if(sfcf_dt7_val !=""&& sfcf_dt7_val != djbh_val){
    		 	    	   	    Dialog.alert("�������õ�"+countnum7+"����ϸ�ķ�Ʊ���루"+fphm_dt7_val+"���������̱��Ϊ��"+sfcf_dt7_val+"����������ʹ�ã�����");
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


