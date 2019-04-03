jQuery(document).ready(function() {
    //alert("加载document");
    checkCustomize = function() {
		//alert("提交");
		var result = true;
		var grqk = "field13013";//个人欠款
		var cdxjkje = "field13014";//冲抵消借款金额
		
		var grqk_c = jQuery("#"+grqk).val();
		var cdxjkje_c = jQuery("#"+cdxjkje).val();
		
		if(grqk_c=="")
		{
			window.top.Dialog.alert("\"个人欠款\"不能为空！");
			result = false; 
		}
		else if(Number(grqk_c)<0)
		{
			window.top.Dialog.alert("\"个人欠款\"不能小于0！");
			result = false; 
		}
		else if(Number(cdxjkje_c)>=0 && Number(cdxjkje_c)>Number(grqk_c))
		{
			window.top.Dialog.alert("\"冲抵消借款金额\"不能大于\"个人借款\"！");
			result = false; 
		}

		return result;
	}
});