
jQuery(document).ready(function() {
	var goodscateID = "#field7865_";
	var goodscateID2 = "#field9098_";
	var original= "#field7549_";//来源
	var price= "#field7533_";//单价
	var original2= "#field9094_";//来源
	var price2= "#field9084_";//单价
	var max_lenx = 200;

	checkCustomize = function() {
		var result = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
				if(jQuery(goodscateID+index).length>0){
					var tmp_1 = jQuery(goodscateID+index).val();
                    jQuery.ajax({ 
                        async: false, 
                        type : "POST", 
                        data : {"goodscateID":tmp_1},
                        url : "/seahonor/jsp/CheckControlIntake.jsp", 
                        dataType : "json", 
                        success : function(data){ 
                         if(data == '1'){
                         	alert("本资产正在盘点中,暂不能入库,给您带来的不便,请谅解！");
                         	result =false;
                          }
                         }
                        }); 
			    }

                if(jQuery(goodscateID+index).length>0){
					var price_val = jQuery(price+index).val();
					var original_val = jQuery(original+index).val();
					if(price_val<0){
						alert("明细1:预估单价不应小于零，请重新填写!");
						result = false;
					}
					if(original_val==0||original_val2==7){
						if(price_val>0){
							alert("明细1:拆分预估单价应为零!");
							result = false;
						}
					}
					if(original_val==4||original_val==2){
						if(price_val==0){
							alert("明细1:托管或赠送预估单价应为大于零!");
							result = false;
						}
					}

			    }

			}
		}

		for(var index2=0;index2<max_lenx;index2++){
			if(result){
				if(jQuery(goodscateID2+index2).length>0){
					var tmp_2 = jQuery(goodscateID2+index2).val();
                    jQuery.ajax({ 
                        async: false, 
                        type : "POST", 
                        data : {"goodscateID2":tmp_2},
                        url : "/seahonor/jsp/CheckControlIntake.jsp", 
                        dataType : "json", 
                        success : function(data){ 
                         if(data == '1'){
                         	alert("明细1:检测有资产在被盘点中，无法申请！");
                         	result =false;
                          }
                         }
                        }); 
			    }

                if(jQuery(goodscateID2+index2).length>0){
					var price_val2 = jQuery(price2+index2).val();
					var original_val2 = jQuery(original2+index2).val();
					if(price_val2<0){
						alert("明细2:预估单价不应小于零，请重新填写!");
						result = false;
					}
					if(original_val2==0||original_val2==7){
						if(price_val2>0){
							alert("明细2:拆分预估单价应为零!");
							result = false;
						}
					}
					if(original_val2==4||original_val2==2){
						if(price_val2==0){
							alert("明细2:托管或赠送预估单价应为大于零!");
							result = false;
						}
					}

			    }

			}
		}
		return result;
	}
});