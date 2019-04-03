//  sap编码
var sapbm_str = "field6833_";
// MRP类型
var mrplx_str = "field7511_";
// MRP控制者
var mrpkzz_str = "field7665_";
// 再订货点 
var zdhd_str = "field7587_";
// 批量大小策略 
var pldxcl_str = "field7517_";
// 固定批量大小
var gdpldx_str = "field7588_";
//  计划策略组
var jhclz_str = "field7468_";
// 综合MRP
var zhmrp_str = "field7525_";

	for(var i =0;i<500;i++){
		// 目标存在
		if(jQuery("#"+sapbm_str+i).length>0){
			ismeth(i);
		}
	}


function ismeth(i){
	
	jQuery("#"+mrplx_str+i).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		// 获取MRP类型
		var s_sm_val = jQuery("#"+mrplx_str+i).val();
		if(s_sm_val !='ND'){
			document.all(mrpkzz_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			if(needcheck.value.indexOf(mrpkzz_str+i)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=mrpkzz_str+i;
			}
			document.all(pldxcl_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			if(needcheck.value.indexOf(pldxcl_str+i)<0){  //如果非必填项，则加入必填项判断				
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=pldxcl_str+i;
			}
			
			
			if(s_sm_val == 'VB'){
				document.all(zdhd_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
				if(needcheck.value.indexOf(zdhd_str+i)<0){  //如果非必填项，则加入必填项判断
					if(needcheck.value!='') needcheck.value+=",";
					needcheck.value+=zdhd_str+i;
				}
			}else{
				if(needcheck.value.indexOf(zdhd_str+i)>=0){
					needcheck.value=needcheck.value.replace(","+zdhd_str+i,"");  //可编辑
					document.all(zdhd_str+i+"span").innerHTML = "";						
				}
			}
			
		}else{
			if(needcheck.value.indexOf(mrpkzz_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+mrpkzz_str+i,"");  //可编辑
				document.all(mrpkzz_str+i+"span").innerHTML = "";						
			}
			if(needcheck.value.indexOf(pldxcl_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+pldxcl_str+i,"");  //可编辑
				document.all(pldxcl_str+i+"span").innerHTML = "";						
			}
		}
	})
		
	jQuery("#"+pldxcl_str+i).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		// 批量大小策略
		var s_sm_val = jQuery("#"+pldxcl_str+i).val();
		if(s_sm_val== 'FX'){
			document.all(gdpldx_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			if(needcheck.value.indexOf(gdpldx_str+i)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=gdpldx_str+i;
				
			//	document.getElementById(gdpldx_str+i).value="100";
		//		document.getElementById(gdpldx_str+i).readOnly = true;
		//		document.all(gdpldx_str+i+"span").innerHTML = "";
			}
		}else{
			if(needcheck.value.indexOf(gdpldx_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+gdpldx_str+i,"");  //可编辑
				document.all(gdpldx_str+i+"span").innerHTML = "";	
				
			}
		}
	})

   	jQuery("#"+jhclz_str+i).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		// 获取MRP类型
		var s_sm_val = jQuery("#"+jhclz_str+i).val();
		if(s_sm_val== '11' || s_sm_val== '70' ){
			document.all(zhmrp_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			if(needcheck.value.indexOf(zhmrp_str+i)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=zhmrp_str+i;
				
			//	document.getElementById(gdpldx_str+i).value="100";
		//		document.getElementById(gdpldx_str+i).readOnly = true;
		//		document.all(gdpldx_str+i+"span").innerHTML = "";
			}
		}else{
			if(needcheck.value.indexOf(zhmrp_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+zhmrp_str+i,"");  //可编辑
				document.all(zhmrp_str+i+"span").innerHTML = "";	
				
			}
		}
	})
}