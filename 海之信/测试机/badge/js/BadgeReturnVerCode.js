jQuery(document).ready(function() {
	//alert("1111");
	var VerCode = "#field8231";     //(系统自动产生)验证码
	var VerCodeRegister = "#field8232";    //（登记人输入）验证码
       var applicantData_str = "field11068_";// 证章
       var state_id = "field11084_";// 状态
	checkCustomize = function() {
		var result = true;
		
		var VerCode_val = jQuery(VerCode).val();
		var VerCodeRegister_val = jQuery(VerCodeRegister).val();
		//alert("VerCode_val="+VerCode_val);
		//alert("VerCodeRegister_val="+VerCodeRegister_val);
             for(var index =0;index <900;index ++){
	           if(jQuery("#"+applicantData_str+index).length>0){
	                var state_val =  jQuery("#"+state_id +index).val();
	                 if( state_val =="3"){
	                      alert("归还客户的证章中还有在借出状态的证章，请等待证章归还后再执行此操作");
	                      return false;
	                 }
	            }else{
	             index = 901;
	           }
	       }
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
