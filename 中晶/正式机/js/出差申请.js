<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var sfxyzz="#field7132";//是否需要暂支
	var clkm="#field7012";//差旅科目
    jQuery(document).ready(function(){
		checkCustomize = function () {
			var sfxyzz_val = jQuery(sfxyzz).val();
			var clkm_val = jQuery(clkm).val();
			if(sfxyzz_val == "0" && clkm_val==""){
			  alert("你的暂支科目暂时没有建立，暂时无法暂支，请联系财务人员");
			  return false;			 
			}
			return true;
		}
	});
</script>
