
jQuery(document).ready(function() {
	var goodscateID = "#field7869_";
	var stock= "#field7586_";//库存量
	var receiveNum= "#field7587_";//出库量
	var goodscateIDx = "#field7867";
	var wrandom = "#field8239";
	var randoms = "#field8240" ; 
	var max_lenx = 200;

	checkCustomize = function() {
		var result = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
			    
				if(jQuery(goodscateIDx+index).length>0){
					var tmp_1 = jQuery(goodscateIDx+index).val();
                    $.ajax({ 
                        async: false, 
                        type : "POST", 
                        data : {"goodscateIDx":tmp_1},
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

				if(jQuery(stock+index).length>0){
					var stock_val = jQuery(stock+index).val();
					var receiveNum_val = jQuery(receiveNum+index).val();
					if(Number(receiveNum_val)==0||Number(stock_val)<Number(receiveNum_val)){
						alert("出库数量为零或大于库存量,请重新填写!");
						result = false;
					}
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