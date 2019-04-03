jQuery(document).ready(function(){
	var bc = "field8688_"      //班次
	var jblx = "field8825_"    //加班类型
	var sfztx = "field17805_"    //是否转调休
	var tmp_sfztx;
	var ygtxss = "field8985_"  //员工填写时数
    //alert(123456);
	
	var gzxz = "field11446_"; //工作性质
	var j_jblxCode = "field8826_";//加班类型编码
	var tmp_gzxz;
	var tem_j_jblxCode;
	//alert(8888888);
	// 当前日期
	var date = new Date();
	//alert(date);
	date.setDate(date.getDate() - 3);
	//date = date - 1000*60*60*24*3;
	//alert(date);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var today = date.getDate();
	
	if (month >= 1 && month <= 9) {
	   month = "0" + month;
	}
	if (today >= 0 && today <= 9) {
	   today = "0" + today;
	}
	// 系统当前日期后3天
	var currentDate = year + "-" + month + "-" + today;
	checkCustomize = function() {
	//  归属日期字段
	var s_date = "field8195_";
	var res = true;
	for(var index=0;index<100;index++){
		
		if(jQuery("#"+s_date+index).length>0){
			var tmp_1 = jQuery("#"+s_date+index).val();
			
			// 如果有一行的归属日期在 系统当前日期前3天  就返回false
			if(tmp_1 < currentDate){
				res =false;
				index = 101;
			}
			
		}else{
			index = 101;
		}
	}
	
	if(	res== false) { alert("3天前的加班不允许提报");
	return result;
	}
	//检查提交时间
	var result = true;
		for(var index = 0; index<200; index++){
			if(result){ 
				if(jQuery("#"+bc+index).length>0){
					var val_bc = jQuery("#"+bc+index).val();
					var val_jblx = jQuery("#"+jblx+index).val();
					var val_ygtxss = jQuery("#"+ygtxss+index).val();
					//alert(123456789);
					
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
		if(result == false)  alert("加班类型或班次，不能为空");
		
		//修改内容
		
		//检查班次、班别为空
	   // var result = true;
		var nowRow = parseInt($G("indexnum0").value) - 1;
		for (var i = 0; i <= nowRow; i++) {
			tmp_gzxz = jQuery("#" + gzxz + i).val();
			//alert("tmp_gzxz="+tmp_gzxz);
			if (tmp_gzxz == "B") {
				tem_j_jblxCode = jQuery("#" + j_jblxCode + i).val();
				//alert("tem_j_jblxCode="+tem_j_jblxCode);
				if (tem_j_jblxCode != "O_003") {
					//alert("当前加班非节假日加班,不能提交！");
					result = false;
				}
			}
		}
        if(result == false)  alert("当前加班非节假日加班,不能提交！");
		//return result;
		//工作性质检查
		//修改内容
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
        if(result == false)  alert("当前加班与是否转调休不符,不能提交！");

			 	return result;
	}
});