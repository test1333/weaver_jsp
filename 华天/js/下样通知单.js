<script type="text/javascript">
	var xmsfwc="field12466";
      var  jjcd="field12701";
   	jQuery(document).ready(function () {
   		checkCustomize = function(){
   			var xmsfwc_val=jQuery("#"+xmsfwc).val();
   			var  jjcd_val=jQuery("#"+jjcd).val();
   			if(jjcd_val == '0'){
	   		       if(Number(xmsfwc_val) >0){
	   		       alert("�ύʧ�ܣ�\n��ԭ����ѡ�ͻ������������������л���"+Number(xmsfwc_val)+"������δ���г������ͨ�����������������������ͻ��������鿴��");
	   		         return false;
	   		       }
   		     }
   		       return true;
      	}
   	 });	
</script>