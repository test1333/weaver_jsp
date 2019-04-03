<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var sfcf = "#field12881";
jQuery(document).ready(function(){
	checkCustomize = function(){ 
	  var sfcf_val = jQuery(sfcf).val();
	  if(sfcf_val != ''){
	   alert("此客户厂内机种名重复,请修改");
	   return false;
	  
	  }
	  return true;	  
	}	
});	
</script>
