<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
     var hswrmbje="#field8431";//����Ϊ����ҽ��
    
    var sfcg ="#field8391";//�Ƿ񳬹�5000W
    var sfyy="#field8403";//�Ƿ���ӡ
    var gz="#field8404";//����
    var htz="#field8405";//��ͬ��
    var frz="#field8406";//������
    var frqz="#field8407";//����ǩ��
    var htksrq="#field8433";//��ͬ��ʼ����
    var htjsrq="#field8434";//��ͬ��������
    	 var gzname="field8404";//����
     jQuery(document).ready(function(){
      jQuery(hswrmbje).bindPropertyChange(function () {
         var hswrmbje_val= jQuery(hswrmbje).val();
          if(Number(hswrmbje_val)>50000000){
                jQuery(sfcg).val("0");
            //  alert("1");
             }else{
                jQuery(sfcg).val("1");
             }
       })
          var sfyy_val=jQuery(sfyy).val();
         if(sfyy_val == "1"){
         	jQuery(gz).attr("disabled", "disabled");
             jQuery(htz).attr("disabled", "disabled");
            jQuery(frz).attr("disabled", "disabled");
            jQuery(frqz).attr("disabled", "disabled");
         }   
       jQuery(sfyy).bind("change",function(){
        var sfyy_val=jQuery(sfyy).val();
          if(sfyy_val == "1"){
        	jQuery("span").removeClass("jNiceChecked");
        	jQuery(gz).val("0");
        	jQuery(htz).val("0");
        	jQuery(frz).val("0");
        	jQuery(frqz).val("0");
        	jQuery(gz).attr("disabled", "disabled");
             jQuery(htz).attr("disabled", "disabled");
            jQuery(frz).attr("disabled", "disabled");
            jQuery(frqz).attr("disabled", "disabled");
          }else{
          	  	jQuery(gz).attr("disabled", "");
             jQuery(htz).attr("disabled", "");
            jQuery(frz).attr("disabled", "");
            jQuery(frqz).attr("disabled", "");
       }
       });
       checkCustomize = function () {
        	      var sfyy_val=jQuery(sfyy).val();
        	      if(sfyy_val == "0"){
        	        var gz_val=jQuery(gz).is(':checked') ;
        	        var htz_val=jQuery(htz).is(':checked') ;
        	        var frz_val=jQuery(frz).is(':checked') ;
        	        var frqz_val=jQuery(frqz).is(':checked') ;
        	          if(gz_val == false && htz_val== false && frz_val== false  && frqz_val== false  ){
			       Dialog.alert("��ӡ���ƣ������ٹ�ѡ1�");
			      return false;
			    }
   		
        	      }
        	      var htksrq_val=jQuery(htksrq).val();
        	      var htjsrq_val=jQuery(htjsrq).val();
        	      if(htjsrq_val<htksrq_val){
        	      	   Dialog.alert("��ͬ�������ڱ�����ڵ��ڿ�ʼ����");
        	      	   return false;
        	     }
        	
        	      return true;
        }   
     });
</script>






