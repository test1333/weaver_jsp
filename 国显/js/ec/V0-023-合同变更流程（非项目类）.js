<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
     var hswrmbje="#field8483";//����Ϊ����ҽ��
    
    var sfcg ="#field8446";//�Ƿ񳬹�5000W
    var sfyy="#field8457";//�Ƿ���ӡ
    var gz="#field8458";//����
    var htz="#field8459";//��ͬ��
    var frz="#field8460";//������
    var frqz="#field8461";//����ǩ��
    var bhsj="#field8501"//���ʱ��
    var htksrq="#field8484";//��ͬ��ʼ����
    var htjsrq="#field11196";//��ͬ��������
     jQuery(document).ready(function(){
      jQuery(hswrmbje).bindPropertyChange(function () {
         var hswrmbje_val= jQuery(hswrmbje).val();
          if(Number(hswrmbje_val)>50000000){
                jQuery(sfcg).val("0");
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
			       alert("��ӡ���ƣ������ٹ�ѡ1�");
			      return false;
			    }
   		
        	      }
        	      var bhsj_val=jQuery(bhsj).val();
        	      var htksrq_val=jQuery(htksrq).val();
        	      var htjsrq_val=jQuery(htjsrq).val();
        	     if(bhsj_val=="0"){
        	      if(htjsrq_val<htksrq_val){
        	      	   Dialog.alert("��ͬ�������ڱ�����ڵ��ڿ�ʼ����");
        	      	   return false;
        	     }
        	} 
        	      return true;
        }   
         
     });
</script>



