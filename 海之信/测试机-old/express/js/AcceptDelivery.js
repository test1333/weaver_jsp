jQuery(document).ready(function() {
	//alert("1111");
	var VerCode = "#field9259";     //(系统自动产生)验证码
	//var VerCodeRegister = "#field6971";    //（登记人输入）验证码
	var VerCodeRegister = "#field9265";//输入验证码 

	checkCustomize = function() {
		var result = true;
		
		var VerCode_val = jQuery(VerCode).val();
		var VerCodeRegister_val = jQuery(VerCodeRegister).val();
		//alert("VerCode_val="+VerCode_val);
		//alert("VerCodeRegister_val="+VerCodeRegister_val);

		if(VerCodeRegister_val.length!=4){
			result = false;
			alert("验证码为四位！！！");
		}else{			
				if (VerCode_val != VerCodeRegister_val) {
				result = false;
				alert("验证码错误，请重新输入验证码！！！");
			}
		}
		return result;
	}
});
