<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
    var ysssqj_dt="#field39106_";//Ԥ�������ڼ�
    var cbzx_dt="#field39107_";//�ɱ�����
    var km_dt="#field39108_";//��Ŀ
    var sqje_dt="#field39112_";//������
    var checksqje="field39112_";//check������
    var ysqje_dt="#field39113_";//ԭ������
    var bgce_dt="#field39114_";//������
    var ydkyys_dt="#field39109_";//��ϸ2-�¶ȿ���Ԥ��
    var ndkyys_dt="#field39110_";//��ϸ2-��ȿ���Ԥ��
    var sftzys="#field38888";//�Ƿ����Ԥ��
      jQuery(document).ready(function(){
      	  dodetail();
      	  jQuery("button[name=addbutton1]").live("click", function () {
      	  	  	setTimeout('dodetail()',1000);
		  });
		  jQuery(sftzys).bind("change",function(){
		  	   dodetail();
			   dodetail2();
		 })
		  checkCustomize = function(){
		  	   var indexnum0 =jQuery("#indexnum1").val();
		  	   	 var countnum=0;
		  	     for( var index=0;index<indexnum0;index++){
   	    			 if(  jQuery(ydkyys_dt+index).length>0){
   	    			 	 countnum=countnum+1;
   	    			 	var ysssqj_dt_val=jQuery(ysssqj_dt+index).val().substring(0,4);
   	    			 	var cbzx_dt_val=jQuery(cbzx_dt+index).val();
    		 	 	      var km_dt_val=jQuery(km_dt+index).val();
    		 	 	     var bgce_dt_val=jQuery(bgce_dt+index).val();
    		 	 	     var ydkyys_dt_val=jQuery(ydkyys_dt+index).val();
    		 	 	      var ndkyys_dt_val=jQuery(ndkyys_dt+index).val();
    		 	 	       if(bgce_dt_val == ''){
    		 	 	          bgce_dt_val='0';	  
    		 	 	       }
    		 	 	  	if(ydkyys_dt_val == ''){
    		 	 	         ydkyys_dt_val='0';	  
    		 	 	       }
    		 	 	       if(ndkyys_dt_val == ''){
    		 	 	         ndkyys_dt_val='0';	  
    		 	 	       }
    		 	 	      if(Number(bgce_dt_val)>Number(ydkyys_dt_val)){
    		 	 	            if(confirm("��"+countnum+"����ϸ����������¶ȿ���Ԥ��")){
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
    		 	 	     var bgce_dt_val=jQuery(bgce_dt+index).val();
    		 	 	     var ydkyys_dt_val=jQuery(ydkyys_dt+index).val();
    		 	 	      var ndkyys_dt_val=jQuery(ndkyys_dt+index).val();
    		 	 	       if(bgce_dt_val == ''){
    		 	 	          bgce_dt_val='0';	  
    		 	 	       }
    		 	 	  	if(ydkyys_dt_val == ''){
    		 	 	         ydkyys_dt_val='0';	  
    		 	 	       }
    		 	 	       if(ndkyys_dt_val == ''){
    		 	 	         ndkyys_dt_val='0';	  
    		 	 	       }
    		 	 	      if(ysssqj_dt_val !='' && cbzx_dt_val !='' && bgce_dt_val !='') {
    		 	 	  	var checkresult=checkyearmoney(cbzx_dt_val,km_dt_val,ysssqj_dt_val,index+1,bgce_dt_val,ndkyys_dt_val);
	    		 	 	  if(checkresult == '1'){
	    		 	 	  	  alert("��"+countnum+"����ϸ�����������ȿ���Ԥ�㣬����");
	    		 	 	  	  return false;
	    		 	 	  }
    		 	          }
   	    			}
   	    		   }
   	    		   return true;
		}
      })
      	  
   function dodetail(){
   	   var sftzys_val=jQuery(sftzys).val();
   	    var indexnum0 =jQuery("#indexnum1").val();
   	    for( var index=0;index<indexnum0;index++){
   	    	 if(  jQuery(ydkyys_dt+index).length>0){
   	    	 	 jQuery(ydkyys_dt+index).attr("readonly", "readonly");
   	      	jQuery(ndkyys_dt+index).attr("readonly", "readonly");
   	      	jQuery(bgce_dt+index).attr("readonly", "readonly");
   	      	if(sftzys_val != "0"){
   	      	
   	      	jQuery(sqje_dt+index).attr("readonly", "readonly");
   	    
   	         }
   	    	}
   	    }
   }
   function dodetail2(){
   	   var sftzys_val=jQuery(sftzys).val();
   	    var indexnum0 =jQuery("#indexnum1").val();
   	    for( var index=0;index<indexnum0;index++){
   	    	 if(  jQuery(ydkyys_dt+index).length>0){
   	    	 	 jQuery(ydkyys_dt+index).attr("readonly", "readonly");
   	      	jQuery(ndkyys_dt+index).attr("readonly", "readonly");
   	      	jQuery(bgce_dt+index).attr("readonly", "readonly");
   	      	if(sftzys_val != "0"){
   	      	var ysqje_dt_val = jQuery(ysqje_dt+index).val();
   	      	jQuery(sqje_dt+index).attr("readonly", "readonly");
   	      	jQuery(sqje_dt+index).val(ysqje_dt_val);
   	      	removecheck(checksqje+index,"0")
   	             }else{
   	             jQuery(sqje_dt+index).removeAttr("readonly");
   	           	jQuery(sqje_dt+index).val("");
   	           	addcheck(checksqje+index,"0");
   	            }
   	    	}
   	    }
   }
   function checkyearmoney(cbzx,fykm,year,startindex,checkval,ckeckallval){
   	   var indexnum0 = jQuery("#indexnum1").val();
     	  var values=checkval;
     	  for (var index2= startindex; index2 < indexnum0; index2++) {   
     	  	    if (jQuery(bgce_dt+ index2).length > 0) {
     	  	    	 	var ysssqj_dt_val=jQuery(ysssqj_dt+index2).val().substring(0,4);
   	    			 	var cbzx_dt_val=jQuery(cbzx_dt+index2).val();
    		 	 	      var km_dt_val=jQuery(km_dt+index2).val();
    		 	 	     var bgce_dt_val=jQuery(bgce_dt+index2).val();
    		 	 	  if(bgce_dt_val == ''){
    		 	 	      bgce_dt_val='0';	  
    		 	 	  }
     			if(cbzx_dt_val==cbzx && km_dt_val==fykm && ysssqj_dt_val==year){
     					values=accAdd(values,bgce_dt_val);
     					
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
  function addcheck(btid,flag){
  	  	var btid_val = jQuery("#"+btid).val();
  	  	var btid_check=btid;
  	      if(btid_val==''){
		    if(flag=='0'){ 
     	 	  jQuery("#"+btid+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }else{
     	 	 	 jQuery("#"+btid+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	 	 	  } 	  
     	 	 	 
     	}
     	var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+btid_check)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=btid_check;
                }
  }

  function removecheck(btid,flag){
  	  	var btid_check=btid;
  	  if(flag=='0'){ 
     	  jQuery("#"+btid+"span").html("");
     	}else{
     	 jQuery("#"+btid+"spanimg").html("");
             }
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+btid_check,"");
                document.all('needcheck').value=parastr; 
  }
</script>

