//alert(1122);
jQuery(document).ready(function() {

	var plannum = "field8457_";//计划数量
	var purchasenum = "field8452_";//采购数量
	var haspurchasenum = "field8454_";//已采购数量

	var planprice = "field8447_";//计划单价
    var purchaseprice = "field8440_"; //采购单价
    
	checkCustomize = function() {
		var result = true;
		for(var index = 0; index<200; index++){
			if(result){ 
				if(jQuery("#"+plannum+index).length>0){
					var plannum_val = jQuery("#"+plannum+index).val();
					var purchasenum_val = jQuery("#"+purchasenum+index).val();
					var haspurchasenum_val = jQuery("#"+haspurchasenum+index).val();

					//alert("haspurchasenum_val="+haspurchasenum_val);
					var temp = Number(plannum_val)-Number(haspurchasenum_val);
					//alert("temp="+temp);

				
					var planprice_val = jQuery("#"+planprice+index).val();
					var purchaseprice_val = jQuery("#"+purchaseprice+index).val();
					
					//if (parseInt(purchasenum_val) > parseInt(plannum_val)) {
					//效果是一样的
					if (Number(purchasenum_val)==0) {	
						result = false;
						alert("第"+(index+1)+"行中：采购数量不能添加为0");
						return result;
					}
					if (Number(purchasenum_val) > Number(temp)) {	
						result = false;
						alert("第"+(index+1)+"行中：采购数量大于计划数量！");
						return result;
					}
					if (Number(purchaseprice_val) > Number(planprice_val)){
						result = false;
						alert("第"+(index+1)+"行中：采购单价大于计划单价！");
						return result;
					}
					
				}else{
					index = 201;
				}
			}else{
				index = 201;
			}
		}	
		/*if(result == false) alert("采购数量大于计划数量或者采购单价大于计划单价！");*/
		return result;
	}
});
