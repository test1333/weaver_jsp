
jQuery(document).ready(function() {
	var goodscateID = "#field7862_";
	var stock= "#field7489_";//库存量
	var receiveNum= "#field7490_";//领用量
	var goodsname= "#field7496_";//资产名称
	var applicant = "#field7482"; //申请人
	var admin = "#field8797"; //资产管理员
	var max_lenx = 100;

		jQuery(applicant).bindPropertyChange(function () {
				jQuery(admin).val("");
          		jQuery(admin+"span").text("");
          		jQuery(admin+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
			for(var i=0;i<=max_lenx;i++){
          		jQuery(goodsname+i).val("");
          		jQuery(goodsname+i+"span").text("");
          		jQuery(goodsname+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     		}
		});
		jQuery(admin).bindPropertyChange(function () {
			for(var i=0;i<=max_lenx;i++){
          		jQuery(goodsname+i).val("");
          		jQuery(goodsname+i+"span").text("");
          		jQuery(goodsname+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     		}
		});

	checkCustomize = function() {
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
                         	alert("本资产正在盘点中,暂不能领用,给您带来的不便,请谅解！");
                         	result =false;
                          }
                         }
                        }); 
			    }

				if(jQuery(stock+index).length>0){
					var stock_val = jQuery(stock+index).val();
					var receiveNum_val = jQuery(receiveNum+index).val();
					if(Number(receiveNum_val)==0||Number(stock_val)<Number(receiveNum_val)){
					alert("所领数量为零或大于库存量,请重新填写!");
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
			    		alert("同一资产，在一个流程中只能申请一次领用，请检查");
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