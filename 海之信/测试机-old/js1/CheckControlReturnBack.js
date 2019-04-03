
jQuery(document).ready(function() {
	var goodscateID = "#field7866_";
	var borrowNum= "#field7560_";//领用量
	var alreadlyReturnNum= "#field7563_";//已退还
	var returnNum= "#field7564_";//退还还量
	var goodsname= "#field9617_";//资产名称
	var applicant = "#field7553"; //申请人
	var admin = "#field8798"; //资产管理员
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
			if(jQuery(borrowNum+index).length>0){
					var borrowNum_val = jQuery(borrowNum+index).val();
					var alreadlyReturnNum_val = jQuery(alreadlyReturnNum+index).val();
					var returnNumNum_val = jQuery(returnNum+index).val();
					if(Number(returnNumNum_val)==0||(Number(borrowNum_val)-Number(alreadlyReturnNum_val))<Number(returnNumNum_val)){
						alert("退还数量为零或大于领用数量,请重新填写!");
						result = false;
					}
			    }

			}else{
			   	index = 201;
			}

		if(res){
			if(jQuery(borrowNum+index).length>0){
			for(var yet=index+1;yet<max_lenx;yet++){
			    	var goodsname_val = jQuery(goodsname+index).val();
			    	var goodsname_val2 = jQuery(goodsname+yet).val();
			    	if(goodsname_val==goodsname_val2){
			    		alert("同一资产，在一个流程中只能申请一次退还，请检查");
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