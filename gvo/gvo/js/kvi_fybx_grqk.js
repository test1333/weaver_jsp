jQuery(document).ready(function() {
    //alert("加载document");
    checkCustomize = function() {
		//alert("提交");
		var result = true;
		var grqk = "field13013";//个人欠款
		
		var grqk_c = jQuery("#"+grqk).val();
		
		if(grqk_c=="")
		{
			window.top.Dialog.alert("个人欠款不能为空！");
			result = false; 
		}
		else if(Number(grqk_c)<0)
		{
			window.top.Dialog.alert("个人欠款不能小于0！");
			result = false; 
		}

		return result;
	}
});