<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var gwzj= "#field10881";



    jQuery(document).ready(function(){
	checkCustomize = function () {
		var gwzj_val = jQuery(gwzj).val();
			if(Number(gwzj_val)>9){				
		               window.top.Dialog.alert("经理级以上员工，不允许提交加班！");
			       return false;
			}

               


		return true;
	}
	
});
</script>




























