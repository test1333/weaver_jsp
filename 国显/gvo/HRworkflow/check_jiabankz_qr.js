jQuery(document).ready(function() {
	var bc = "field8688_"      //班次
	var jblx = "field8825_"    //加班类型
	var ygtxss = "field8985_"  //员工填写时数
	var sfztx = "field17805_"    //是否转调休
	var tmp_sfztx;
	var gzxz = "field11446_"; //工作性质
	var j_jblxCode = "field8826_";//加班类型编码
	var tmp_gzxz;
	var tem_j_jblxCode;

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
		var nowRow1 = parseInt($G("indexnum0").value) - 1;
		for (var i = 0; i <= nowRow1; i++) {
			tmp_sfztx = jQuery("#" + sfztx + i).val();
			//alert("tmp_sfztx="+tmp_sfztx);
			if (tmp_sfztx == "1") {
				tem_j_jblxCode = jQuery("#" + j_jblxCode + i).val();
				//alert("tem_j_jblxCode="+tem_j_jblxCode);
				if (tem_j_jblxCode == "O_001" || tem_j_jblxCode == "O_002") {
					//alert("当前加班非节假日加班,不能提交！");
					result = false;
				}
			}
			if (tmp_sfztx == "0") {
				tem_j_jblxCode = jQuery("#" + j_jblxCode + i).val();
				//alert("tem_j_jblxCode="+tem_j_jblxCode);
				if (tem_j_jblxCode == "O_004" || tem_j_jblxCode == "O_005") {
					//alert("当前加班非节假日加班,不能提交！");
					result = false;
				}
			}
		}
        if(result == false)  window.top.Dialog.alert("当前加班与是否转调休不符,不能提交！");
		
		return result;
	}
});
