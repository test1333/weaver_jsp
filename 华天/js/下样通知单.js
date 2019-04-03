<script type="text/javascript">
	var xmsfwc="field12466";
      var  jjcd="field12701";
   	jQuery(document).ready(function () {
   		checkCustomize = function(){
   			var xmsfwc_val=jQuery("#"+xmsfwc).val();
   			var  jjcd_val=jQuery("#"+jjcd).val();
   			if(jjcd_val == '0'){
	   		       if(Number(xmsfwc_val) >0){
	   		       alert("提交失败！\n【原因】所选客户机种名在立项流程中还有"+Number(xmsfwc_val)+"条任务未经市场部审核通过，不能下样。详情请点击客户机种名查看。");
	   		         return false;
	   		       }
   		     }
   		       return true;
      	}
   	 });	
</script>