
jQuery(document).ready(function() {
	var goodscateID = "#field7858_";
	var stock= "#field7418_";//库存量
	var alreturn= "#field9508_";
	var lossNum= "#field7419_";//报损数量
	var isindependent= "#field8604_";//是否独立编号
	var goodsname= "#field7424_";//资产名称
	var applicant = "#field7409"; //申请人
	var admin = "#field8799"; //资产管理员
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
			    var isindependent_val = jQuery(isindependent+index).val();
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
                         	alert("本资产正在盘点中,暂不能报损,给您带来的不便,请谅解！");
                         	result =false;
                          }
                         }
                        }); 
			    }

                if(isindependent_val==0||isindependent_val==1){
				if(jQuery(stock+index).length>0){
					var stock_val = jQuery(stock+index).val();
					var lossNum_val = jQuery(lossNum+index).val();
					var alreturn_val = jQuery(alreturn+index).val();
						if(Number(lossNum_val)==0||Number(stock_val)-Number(alreturn_val)<Number(lossNum_val)){
						alert("报损数量超过库存或库存量小于1或的资产不能报损!");
						result = false;
					}

			    }
			}

			if(res){
			if(jQuery(stock+index).length>0){
			for(var yet=index+1;yet<max_lenx;yet++){
			    	var goodsname_val = jQuery(goodsname+index).val();
			    	var goodsname_val2 = jQuery(goodsname+yet).val();
			    	if(goodsname_val==goodsname_val2){
			    		alert("同一资产，在一个流程中只能申请一次报损，请检查");
			    		res= false;
			    		result = false;
			    		break;
			    	}   	    
			    }
            }
         }
        }
	}
		return result;
	}
});