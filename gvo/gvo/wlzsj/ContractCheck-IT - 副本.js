
jQuery(document).ready(function() {
	  var je="#field7180";//总金额
    var kyje="#field15006";//可用金额

checkCustomize = function() {
		var je_val = jQuery(je).val();
		var kyje_val = jQuery(kyje).val();
		var result = true;	

		
		if(Number(je_val) > Number(kyje_val)){
		alert("已超可用预算总额，不可提交");
		result = false;
		}
	
	return result;
	}
});



