
jQuery(document).ready(function() {
	var goodscateID = "#field7860_";
	var stock= "#field7453_";//库存量
	var borrowNum= "#field7454_";//借用量
	var goodsname= "#field7452_";//资产名称
	var applicant = "#field7445"; //申请人
	var admin = "#field8795"; //资产管理员
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
				
                if(jQuery(stock+index).length>0){
					var stock_val = jQuery(stock+index).val();
					var borrowNum_val = jQuery(borrowNum+index).val();
					if(Number(borrowNum_val)==0||Number(stock_val)<Number(borrowNum_val)){
						alert("所借数量为零或大于库存量,请重新填写!");
						result = false;
					}
			    }else{
			   	   	index = 201;
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
			    		alert("同一资产，在一个流程中只能申请一次借用，请检查");
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