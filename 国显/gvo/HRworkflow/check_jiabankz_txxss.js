jQuery(document).ready(function() {
	var bc = "field8688_"      //班次
	var jblx = "field8825_"    //加班类型
	var ygtxss = "field8985_"  //员工填写时数

	checkCustomize = function() {
		var result = true;
		for(var index = 0; index<200; index++){
			if(result){ 
				if(jQuery("#"+bc+index).length>0){
					var val_bc = jQuery("#"+bc+index).val();
					var val_jblx = jQuery("#"+jblx+index).val();
					var val_ygtxss = jQuery("#"+ygtxss+index).val();
					
					if(val_ygtxss.length==0||Number(val_ygtxss)==0){
						//alert("1231241");
						result = false;
					}

					if(val_bc.length==0){
						result = false;
					}
					if(val_jblx.length==0){
						result = false;
					}
					
				}else{
					index = 201;
				}
			}else{
				index = 201;
			}
		}
		if(result == false)  window.top.Dialog.alert("员工填写小时数不能为0或空");
		return result;
	}
});
