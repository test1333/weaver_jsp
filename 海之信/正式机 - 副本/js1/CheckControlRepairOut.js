jQuery(document).ready(function() {
	var goodscateID = "#field7870_";
	var price = "#field8746_";
	var price1 = "#field9719_";//管理员
	var price2 = "#field10421_";//财务
	var price3 = "#field10420_";//审批
	var repairprice = "#field7634_";
	var goodsname= "#field7639_";//资产名称
	var max_lenx = 200;

	checkCustomize = function() {
		var result = true;
		var res = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
					var tmp_1 = jQuery(goodscateID+index).val();
                    
				if(jQuery(price+index).length>0){
					var price_val = jQuery(price+index).val();
					var price1_val = jQuery(price1+index).val();
					var price2_val = jQuery(price2+index).val();
					var price3_val = jQuery(price3+index).val();
					var price4_val = jQuery(repairprice+index).val();
					var repairprice_val = 0;
					if(typeof(price1_val)!="undefined"&&price1_val){
						repairprice_val=price1_val;
					}
					if(typeof(price2_val)!="undefined"&&price2_val){
						repairprice_val=price2_val;
					}
					if(typeof(price3_val)!="undefined"&&price3_val){
						repairprice_val=price3_val;
					}
					if(typeof(price4_val)!="undefined"&&price4_val){
						repairprice_val=price4_val;
					}
					if(Number(price_val)*0.5<Number(repairprice_val)){
						alert("维修金额超过物品单价的50%，请确认!");
					}
                  }

			if(res){
			if(jQuery(price+index).length>0){
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