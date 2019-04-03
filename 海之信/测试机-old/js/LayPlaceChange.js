﻿
jQuery(document).ready(function() {
	var goodscateID = "#field7861_";
	var stock= "#field7477_";//库存量
	var moveNum= "#field7473_";//转移量
	var goodsname= "#field7476_";//资产名称
	var max_lenx = 200;
	checkCustomize = function() {
		var result = true;
		var res = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
				if(jQuery(goodscateID+index).length>0){
					var tmp_1 = jQuery(goodscateID+index).val();
                    jQuery.ajax({ 
                        async: false, 
                        type : "POST", 
                        data : {"goodsname":tmp_1},
                        url : "/seahonor/jsp/CheckControlIntake.jsp", 
                        dataType : "json", 
                        success : function(data){
                         if(data == '1'){
                         	alert("本资产正在盘点中,暂不能移库,给您带来的不便,请谅解！");
                         	result =false;
                          }
                         }
                        }); 
			    }

                if(jQuery(stock+index).length>0){
					var stock_val = jQuery(stock+index).val();
					var moveNum_val = jQuery(moveNum+index).val();
					if(Number(moveNum_val)==0||Number(stock_val)<Number(moveNum_val)){
						alert("转移数量为零或大于库存量,请重新填写!");
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
			    		alert("同一资产，在一个流程中只能申请一次移库，请检查");
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