<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
     
    var sfyxtj="#field13061";//是否允许提交
    jQuery(document).ready(function(){
    	checkCustomize = function(){
    		var sfyxtj_val=jQuery(sfyxtj).val();
    		if(sfyxtj_val !="0"){
    		  Dialog.alert("该流程不允许手动提交，如有疑问，请联系管理员");
    		  return false;	
    	    }
    		return true;
       }
   });
  
</script>
