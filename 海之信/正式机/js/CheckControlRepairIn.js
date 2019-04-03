
jQuery(document).ready(function() {
	var goodscateID = "#field7867";
	var goodsname = "#field7616";
	var max_lenx = 200;

	checkCustomize = function() {
		var result = true;
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
			    }else{
			   	   	index = 201;
			    }
			}else{
			   	index = 201;
			}
		}
		return result;
	}
});