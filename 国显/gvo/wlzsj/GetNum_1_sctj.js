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
// 特殊获取类型
var txhqlx_str = "field7520_";
// 是否委外
var sfww_str = "field7370_";

setTimeout('yourFunction()',1000);

function yourFunction(){
	for(var i =0;i<500;i++){
		// 目标存在
		if(jQuery("#"+sapbm_str+i).length>0){
			ismeth(i);
		}
	}
}

function ismeth(i){
	
	var sfww_val = jQuery("#"+sfww_str+i).val();
	//  不需要维护采购视图
	// alert("sfww_val = " + sfww_val);
	
	// 默认状态：特殊获取类型必填且默认值为30，当变成不需要委外是变成特殊获取类型可编辑，并且清空记录
	if(sfww_val=='1'){
		
		var needcheck = document.all("needcheck");
		
		if(needcheck.value.indexOf(txhqlx_str+i)>=0){
			needcheck.value=needcheck.value.replace(","+txhqlx_str+i,"");  //可编辑
			document.all(txhqlx_str+i+"span").innerHTML = "";
		    document.getElementById(txhqlx_str+i).value="";
		    document.getElementById(txhqlx_str+i+"span").html="";
       }
	}
	
	
	jQuery("#"+mrplx_str+i).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		// 获取MRP类型
		var s_sm_val = jQuery("#"+mrplx_str+i).val();
//		alert("s_sm_val  = " + s_sm_val);
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
				
				// 批量大小策略改变，固定大小
				if(needcheck.value.indexOf(gdpldx_str+i)>=0){
					needcheck.value=needcheck.value.replace(","+gdpldx_str+i,"");  //可编辑
					document.all(gdpldx_str+i+"span").innerHTML = "";	
					
				}
			}
			if(needcheck.value.indexOf(zdhd_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+zdhd_str+i,"");  //可编辑
				document.all(zdhd_str+i+"span").innerHTML = "";						
			}
		}
	});
		
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
	});

   	jQuery("#"+jhclz_str+i).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		// 获取综合MRP
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
	});
	
	jQuery("#"+zhmrp_str+i).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		// 获取综合MRP
		var s_sm_val = jQuery("#"+zhmrp_str+i).val();
		if(s_sm_val == null || s_sm_val.length==0){
			if(needcheck.value.indexOf(zhmrp_str+i)>=0){
				document.all(zhmrp_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			}
		}
	});
}