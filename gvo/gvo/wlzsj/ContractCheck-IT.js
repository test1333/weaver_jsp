
jQuery(document).ready(function() {
	var sqlx="#field10093";//申请类型
	  var je="#field7180";//总金额
    var kyje11="#field14954";//可用金额
	//alert ("12");
checkCustomize = function() {
	  var sqlx_val = jQuery(sqlx).val();
		var je_val = jQuery(je).val();
		var kyje11_val = jQuery(kyje11).val();
		var result = true;	
			//alert ("123");
		if(sqlx_val=="1") {			//alert ("1234");
		if(Number(je_val) > Number(kyje11_val)){
		window.top.Dialog.alert("已超可用预算总额，不可提交");
		result = false;
	}}
	return result;
}
});



