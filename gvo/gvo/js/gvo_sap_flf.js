var fymc = "field7078_";	 // 费用名称
var fybm = "field7659_";	 // 费用编码
var bxje = "field7073_";     //  金额
var ysje = "field7148_";     //预算金额
var yyys = "field7149_";     //已用预算



var fymc_hj = "field8609_";  // 费用名称合计
var fybm_hj = "field8608_";  // 费用编码合计
var bxje_hj = "field8613_";  // 金额 合计
var ysje_hj = "field8610_";  // 预算金额合计
var yyys_hj = "field8611_";  // 已用预算合计
var kyys_hj = "field8612_";   //   

var max_res_len = 0;
	
function checkN(){
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
	jQuery("#"+fymc+nowRow).bind("propertychange",function(){ 	
			calCheck();
	});
	
	jQuery("#"+bxje+nowRow).bind("change",function(){ 	
			calCheck();
	});
	
	jQuery("#"+ysje+nowRow).bind("change",function(){ 	
			calCheck();
	});
	
	jQuery("#"+yyys+nowRow).bind("change",function(){ 	
			calCheck();
	});
	
	
}


// 合计不同类型
function calCheck(){
//	alert(4442);
	var fymc_arr = new Array();
	var fybm_arr = new Array();
	var bxje_arr = new Array();
	var ysje_arr = new Array();
	var yyys_arr = new Array();
	
	
	
	var max_len = 0;
	for(var i=0;i<1000;i++){
		if(jQuery("#"+fymc+i).length>0 && max_len<6){
			var tmp_fymc_val = jQuery("#"+fymc+i).val();
			// 重复合计
			var tmp_fybm_val = jQuery("#"+fybm+i).val();
			var tmp_bxje_val = jQuery("#"+bxje+i).val();
			var tmp_ysje_val = jQuery("#"+ysje+i).val();
			var tmp_yyys_val = jQuery("#"+yyys+i).val();
			
			
			

				// 是否有重复   0:不重复  1:有重复
				var is_now = 0;
				for(var j=0;j<max_len;j++){
					if(fybm_arr[j]==tmp_fybm_val){
			              	 bxje_arr[j] = Number(bxje_arr[j]) + Number(tmp_bxje_val);
					is_now = 1;
					}
				}
				if(is_now==0){
					fymc_arr[max_len] = tmp_fymc_val;
					fybm_arr[max_len] = tmp_fybm_val;
					bxje_arr[max_len] = tmp_bxje_val;
					ysje_arr[max_len] = tmp_ysje_val;
					yyys_arr[max_len] = tmp_yyys_val;
					
					max_len = max_len + 1;
				}
		}
	}
	
	// 放置到合计:  扩展行比数组长度小时才添加
	if(max_res_len<5&&max_res_len<max_len){
		addRow1(1);
		max_res_len =max_res_len+1;
	}
	
	// 清空合计记录
	for(var k=0;k<5;k++){
		if(jQuery("#"+fymc_hj+k).length>0){
			jQuery("#"+fymc_hj+k).val(""); jQuery("#"+fymc_hj+k+"span").text("");
			jQuery("#"+fybm_hj+k).val(""); jQuery("#"+fybm_hj+k+"span").text("");
			jQuery("#"+bxje_hj+k).val(""); jQuery("#"+bxje_hj+k+"span").text("");
			jQuery("#"+ysje_hj+k).val(""); jQuery("#"+ysje_hj+k+"span").text("");
			jQuery("#"+yyys_hj+k).val(""); jQuery("#"+yyys_hj+k+"span").text("");
			jQuery("#"+kyys_hj).val(""); jQuery("#"+kyys_hj+"span").text("");
			
		}
	 }
	
	for(var k=0;k<max_len;k++){
		var tmp_bxje = Number(bxje_arr[k]).toFixed(2);
		jQuery("#"+fymc_hj+k).val(fymc_arr[k]); jQuery("#"+fymc_hj+k+"span").text(fymc_arr[k]);
		jQuery("#"+fybm_hj+k).val(fybm_arr[k]); jQuery("#"+fybm_hj+k+"span").text(fybm_arr[k]);
		jQuery("#"+bxje_hj+k).val(tmp_bxje); jQuery("#"+bxje_hj+k+"span").text(tmp_bxje);
		jQuery("#"+ysje_hj+k).val(ysje_arr[k]); jQuery("#"+ysje_hj+k+"span").text(ysje_arr[k]);
		jQuery("#"+yyys_hj+k).val(yyys_arr[k]); jQuery("#"+yyys_hj+k+"span").text(yyys_arr[k]);
		
		
	}
	
}
