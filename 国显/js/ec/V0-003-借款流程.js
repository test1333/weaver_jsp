<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var grjkje="#field9987";//���˽����
	var sqje="#field5974";//������
	var jked="#field11492";//�����
     var disjked="#disfield11492";//�����
     jQuery(document).ready(function(){
        checkCustomize = function(){
     	 var grjkje_val=jQuery(grjkje).val();
     	 var sqje_val=jQuery(sqje).val();
     	 if(Number(sqje_val)>Number(grjkje_val)){
     	    jQuery(jked).val("1");
     	    jQuery(disjked).val("1");
     	 }else{
     	  jQuery(jked).val("0");
     	  jQuery(disjked).val("0");
            }		
     	 return true;		
        }
     	 
   });
</script>
