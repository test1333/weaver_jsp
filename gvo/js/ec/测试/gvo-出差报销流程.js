<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var glsqsq="#field8084";
var rysfjc="#field12132";//��Ա�Ƿ��鳬��
var sfcb="#field12133";//�Ƿ񳬱�
var sfcb_dt4="#field12129_";//�Ƿ񳬱�����ϸ4
var cbyy_dt4="#field12134_";//����ԭ����ϸ4	
     jQuery(document).ready(function(){
     	 	var glsqsq_val=jQuery(glsqsq).val();
     	 	if(glsqsq_val != ""){
     	 	    jQuery(glsqsq+"span span a").removeAttr("href");	
     	        }
     	 	jQuery(glsqsq).bindPropertyChange(function (){ 
	    	jQuery(glsqsq+"span span a").removeAttr("href");	
        	})
         checkCustomize = function(){
        	var rysfjc_val=jQuery(rysfjc).val();
        	var indexnum0 = jQuery("#indexnum3").val();
    		 var countnum=0;
    		 jQuery(sfcb).val("0");
    		 for(var index=0; index<indexnum0;index++){
    		 	 if(jQuery(cbyy_dt4+index).length>0){
    		 	 	 countnum = countnum+1;
    		 	 	 var sfcb_dt4_val=jQuery(sfcb_dt4+index).val();
    		 	 	  var cbyy_dt4_val=jQuery(cbyy_dt4+index).val();
    		 	 	  if(rysfjc_val=="1" && sfcb_dt4_val=="0" ){
    		 	 	  	 jQuery(sfcb).val("1");
    		 	 	  }
    		 	 	  if(rysfjc_val=="1" && sfcb_dt4_val=="0" && cbyy_dt4_val==""){
    		 	 	  	  Dialog.alert("��"+countnum+"�н�ͨ����ϸ���꣬����д����ԭ��");
    		 	 	  	  return false;
    		 	 	  }
    		        }
    		}
    		return true;
        }
 });
</script>
