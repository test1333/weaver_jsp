
jQuery(document).ready(function() {
	var goodscateID = "#field7869_";
	var stock= "#field7586_";//库存量
	var receiveNum= "#field7587_";//出库量
	var goodscateIDx = "#field7867";
	var goodsname= "#field7617_";//资产名称
	var intime= "#field9348";//在保修期内
	var max_lenx = 200;

	checkCustomize = function() {
    var intime_val = jQuery(intime).val();
    if(intime_val==0){
    	alert("资产尚在保修期内，请确认！");
    }

		var result = true;
		var res = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
				if(jQuery(goodscateID+index).length>0){
					var tmp_1 = jQuery(goodsname+index).val();
                    jQuery.ajax({ 
                        async: false, 
                        type : "POST", 
                        data : {"goodsname":tmp_1},
                        url : "/seahonor/jsp/CheckControlIntake.jsp", 
                        dataType : "json", 
                        success : function(data){ 
                         if(data == '1'){
                         	alert("本资产正在盘点中,暂不能维修,给您带来的不便,请谅解！");
                         	result =false;
                          }
                         }
                        }); 
			    }

				if(jQuery(stock+index).length>0){
					var stock_val = jQuery(stock+index).val();
					var receiveNum_val = jQuery(receiveNum+index).val();
					if(Number(receiveNum_val)==0||Number(stock_val)<Number(receiveNum_val)){
						alert("出库数量为零或大于库存量,请重新填写!");
						result = false;
					}
			    }

			}else{
			   	index = 201;
			}

			if(res){
			if(jQuery(goodscateID+index).length>0){
			for(var yet=index+1;yet<max_lenx;yet++){
			    	var goodsname_val = jQuery(goodsname+index).val();
			    	var goodsname_val2 = jQuery(goodsname+yet).val();
			    	if(goodsname_val==goodsname_val2){
			    		alert("同一资产，在一个流程中只能申请一次维修，请检查");
			    		res= false;
			    		result = false;
			    		break;
			    	}   	    
			    }
            }
          }
		}
		return result;
	}
});