
jQuery(document).ready(function() {
	var goodscateID = "#field7870_";
	var wrandom = "#field8235";
	var randoms = "#field8236" ; 
	var max_lenx = 200;

	checkCustomize = function() {
		var result = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
				if(jQuery(goodscateID+index).length>0){
					var tmp_1 = jQuery(goodscateID+index).val();
                    $.ajax({ 
                        async: false, 
                        type : "POST", 
                        data : {"goodscateID":tmp_1},
                        url : "/seahonor/jsp/CheckControlIntake.jsp", 
                        dataType : "json", 
                        success : function(data){ 
                         if(data == '1'){
                         	alert("检测有资产在被盘点中，无法申请！");
                         	result =false;
                          }
                         }
                        }); 
			    }else{
			   	   	index = 201;
			    }

			var wrandomx = jQuery(wrandom).val();
        	var randomx = jQuery(randoms).val();
        	if (wrandomx!==randomx){
        	alert("验证码错误，请重新输入");
        	result = false;	
        	}

			}else{
			   	index = 201;
			}
		}
		return result;
	}
});