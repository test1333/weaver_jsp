<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
     var bgce="#field_lable9341";//������
    var kyys="#field9342";//����Ԥ��
    var bglx="#field9337";//�������
    var bgce1="#field9341";//������
    var xmjhkssj="#field9338";//����Ŀ�ƻ���ʼʱ��
   var xmjhjssj="#field9339";//����Ŀ�ƻ�����ʱ��
     jQuery(document).ready(function(){
       jQuery(bgce).attr("readonly", "readonly");
         jQuery(kyys).attr("readonly", "readonly");
        checkCustomize = function () {
        	      var xmjhkssj_val=jQuery(xmjhkssj).val();
                	var xmjhjssj_val=jQuery(xmjhjssj).val();
                	if(xmjhkssj_val !="" && xmjhjssj_val !=""){
                		if(xmjhjssj_val < xmjhkssj_val){
                			alert("��Ŀ�ƻ�����ʱ�������ڵ�����Ŀ�ƻ���ʼʱ��");
                			return false;
                	       }
                   }
        	      var bglx_val=jQuery(bglx).val();
        		var kyys_val=jQuery(kyys).val();
        		var bgce_val=jQuery(bgce1).val();
        		if(bglx_val == '1'){
        		    	if(kyys_val ==''){
                			kyys_val = '0';	
                	       }
                	   	if(bgce_val ==''){
                			bgce_val = '0';	
                	       }
                	      if(Number(bgce_val)>Number(kyys_val)){
          	      	  alert("��������ڿ���Ԥ��,����");
          	      	  return false;
          	           }
        	      }
        	      return true;
        }
     });
</script>
