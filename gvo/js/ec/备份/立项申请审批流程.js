<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
   var xmlx="#field9642";//��Ŀ����
   var xmlx_old="";//��Ŀ����_old
   var dt1yc1="#dt1yc1";
   var dt1yc2="#dt1yc2";
   var dt1yc3="#dt1yc3";
   var dt1yc4="#dt1yc4";
   var ysjeyc="#ysjeyc";
   var lxje="#field9378";//����������
   var kyje="#field9834";//�������Ԥ��
   var lxje_dt1="#field9316_";//��ϸ��������
   var kyje_dt1="#field9311_";//��ϸ�����Ԥ��
   var xmsbmc_dt1="#field12184_";//��ϸ����Ŀ�豸����
   var xmjhkssj="#field9119";//��Ŀ�ƻ���ʼʱ��
   var xmjhjssj="#field9120";//��Ŀ�ƻ�����ʱ��
       jQuery(document).ready(function(){
       	   var xmlx_val=jQuery(xmlx).val();
       	  showordiaplaydt1(xmlx_val);
               jQuery(xmlx).bindPropertyChange(function () {
               	    var xmlx_val=jQuery(xmlx).val();
               	    showordiaplaydt1(xmlx_val);
                });
                checkCustomize = function () {
                	var xmjhkssj_val=jQuery(xmjhkssj).val();
                	var xmjhjssj_val=jQuery(xmjhjssj).val();
                	if(xmjhkssj_val !="" && xmjhjssj_val !=""){
                		if(xmjhjssj_val < xmjhkssj_val){
                			Dialog.alert("��Ŀ�ƻ�����ʱ�������ڵ�����Ŀ�ƻ���ʼʱ��");
                			return false;
                	       }
                   }
                	var xmlx_val=jQuery(xmlx).val();
                	if(xmlx_val == '0'||xmlx_val == '2'||xmlx_val == '3'){
                		var lxje_val=jQuery(lxje).val();
                		var kyje_val=jQuery(kyje).val();
                		if(lxje_val ==''){
                			lxje_val = '0';	
                	       }
                	   	if(kyje_val ==''){
                			kyje_val = '0';	
                	       }
                		if(Number(lxje_val)>Number(kyje_val)){
                		   Dialog.alert("������ܳ�����ĿԤ�����Ԥ��");
                		   return false;	
                	       }
                    }else if(xmlx_val == '1'){
                       var indexnum0=jQuery("#indexnum0").val(); 
                        for( var index=0;index<indexnum0;index++){
                        	   if( jQuery(lxje_dt1+index).length>0){
                        	   	   var lxje_dt1_val=jQuery(lxje_dt1+index).val();
                        	   	   var kyje_dt1_val=jQuery(kyje_dt1+index).val();
                        	   	  if(lxje_dt1_val ==''){
                				lxje_dt1_val = '0';	
                	 	         }
                	   	    	if(kyje_dt1_val ==''){
                				kyje_dt1_val = '0';	
                	       	}
                        	   	   if(Number(lxje_dt1_val)>Number(kyje_dt1_val)){
                		   		Dialog.alert("��ϸ�д������������ĿԤ�����Ԥ�����Ŀ������");
                		   		return false;	
                	       	  }
                	       	  var xmsbmc_dt1_val = jQuery(xmsbmc_dt1+index).val();
                	       	  var flag="0";
                	       	  flag=checkxmsbmcdt(xmsbmc_dt1_val,index);
                	       	  if(flag=="1"){
                	       	  	 Dialog.alert("��ϸ�д�����Ŀ/�豸�����ֶ��ظ�������");
                	       	  	 return false; 
                	               }
                        	   }
                        }
                   }
                	return true;
                }
      })
      function checkxmsbmcdt(xmsbmc_val,index1){
       var indexnum0=jQuery("#indexnum0").val(); 
       for( var index=index1+1;index<indexnum0;index++){
          	   if( jQuery(xmsbmc_dt1+index).length>0){
          	   	var xmsbmc_dt1_val = jQuery(xmsbmc_dt1+index).val(); 
          	   	if(xmsbmc_dt1_val == xmsbmc_val)  {
          	   		return "1";
          	      }
          	  }
      }
   }  	 
      function showordiaplaydt1(xmlx_val){
      if(xmlx_val == '' || xmlx_val == '0' || xmlx_val == '2' || xmlx_val == '3'){
        	jQuery(dt1yc1).hide();
 	      jQuery(dt1yc2).hide();
 	      jQuery(dt1yc3).hide();
 	      jQuery(dt1yc4).hide();
 	      jQuery(ysjeyc).show();	
       }
        if(xmlx_val == '1' ){
        	jQuery(dt1yc1).show();
 	      jQuery(dt1yc2).show();
 	      jQuery(dt1yc3).show();
 	      jQuery(dt1yc4).show();
 	       jQuery(ysjeyc).hide();		
       }
       
     }
</script>






