//  sap编码
var sapbm_str = "field6833_";
// 总货架寿命
var zhjsm_str = "field7673_";
// 最小剩余货架寿命
var zxsm_str = "field7612_";
// 类别类型
var lblx_str = "field8201_"
// 类别
var lb_str = "field7885_";
// 批次管理
var pcgl_str = "field7672_";

for(var i =0;i<500;i++){
	// 目标存在
	if(jQuery("#"+sapbm_str+i).length>0){
		ismeth(i);
	}
}


function ismeth(i){
	
   	jQuery("#"+zhjsm_str+i).bind("change",function(){
		var needcheck = document.all("needcheck");
		// 获取总货架寿命
		var s_sm_val = jQuery("#"+zhjsm_str+i).val();
		if(s_sm_val.length>0 ){
			document.all(zxsm_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			if(needcheck.value.indexOf(zxsm_str+i)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=zxsm_str+i;
				
			//	document.getElementById(gdpldx_str+i).value="100";
		//		document.getElementById(gdpldx_str+i).readOnly = true;
		//		document.all(gdpldx_str+i+"span").innerHTML = "";
			}
		}else{
			if(needcheck.value.indexOf(zxsm_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+zxsm_str+i,"");  //可编辑
				document.all(zxsm_str+i+"span").innerHTML = "";	
				
			}
		}
	})

	jQuery("#"+pcgl_str+i).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		// 获取类别类型
		var s_sm_val = jQuery("#"+pcgl_str+i).val();
		if(s_sm_val.length>0 ){
			var s_sm_val_1 = jQuery("#"+lblx_str+i).val();
			if(s_sm_val_1==null||s_sm_val_1.length==0 ){
				document.all(lblx_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			}
			
			if(needcheck.value.indexOf(lblx_str+i)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=lblx_str+i;
			}
			
			var s_sm_val_2 = jQuery("#"+lb_str+i).val();
			if(s_sm_val_2==null||s_sm_val_2.length==0 ){
				document.all(lb_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			}
			if(needcheck.value.indexOf(lb_str+i)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=lb_str+i;
			}
		}else{
			if(needcheck.value.indexOf(lblx_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+lblx_str+i,"");  //可编辑
				document.all(lblx_str+i+"span").innerHTML = "";	
			}
			
			if(needcheck.value.indexOf(lb_str+i)>=0){
				needcheck.value=needcheck.value.replace(","+lb_str+i,"");  //可编辑
				document.all(lb_str+i+"span").innerHTML = "";	
			}
		}
	})
	
	jQuery("#"+lblx_str+i).bind("change",function(){
		var s_sm_val = jQuery("#"+lblx_str+i).val();
		
		if(s_sm_val.length>0){
			document.all(lblx_str+i+"span").innerHTML = "";
		}else{
			var s_sm_val_1 = jQuery("#"+pcgl_str+i).val();
			if(s_sm_val_1.length>0 ){
				document.all(lblx_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			}
		}
	})
	
	jQuery("#"+lb_str+i).bind("change",function(){
		var s_sm_val = jQuery("#"+lb_str+i).val();
		
		if(s_sm_val.length>0){
			document.all(lb_str+i+"span").innerHTML = "";
		}else{
			var s_sm_val_1 = jQuery("#"+pcgl_str+i).val();
			if(s_sm_val_1.length>0 ){
				document.all(lb_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			}
		}
	})
	
//	jQuery("#"+lblx_str+i).bind("change",function(){
//		var needcheck = document.all("needcheck");
		// 获取类别类型
//		var s_sm_val = jQuery("#"+lblx_str+i).val();
		
//		if(s_sm_val.length>0){
//			document.all(lblx_str+i+"span").innerHTML = "";
//	}
//		if(s_sm_val=='023' ){
		
//			var s_sm_val_1 = jQuery("#"+lb_str+i).val();
//			if(s_sm_val_1==null||s_sm_val_1.length==0 ){
//				document.all(lb_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	//	}
//			if(needcheck.value.indexOf(lb_str+i)<0){  //如果非必填项，则加入必填项判断
//				if(needcheck.value!='') needcheck.value+=",";
//				needcheck.value+=lb_str+i;
	//	}
//		}else{
//			var s_sm_val_1 = jQuery("#"+pcgl_str+i).val();
//			
//			if(s_sm_val_1.length>0){
//				if(s_sm_val ==null ||s_sm_val.length==0){
//					document.all(lblx_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
		//	}
				
//				var s_sm_val_2 = jQuery("#"+lb_str+i).val();
				
//				if(s_sm_val_2==null||s_sm_val_2.length==0 ){
//					document.all(lb_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
		//	}
				
//				if(needcheck.value.indexOf(lblx_str+i)<0){  //如果非必填项，则加入必填项判断
//					if(needcheck.value!='') needcheck.value+=",";
//					needcheck.value+=lblx_str+i;
		//	}
				
//				if(needcheck.value.indexOf(lb_str+i)<0){  //如果非必填项，则加入必填项判断
//					if(needcheck.value!='') needcheck.value+=",";
//					needcheck.value+=lb_str+i;
		//	}
//			}else{
			
//				if(needcheck.value.indexOf(lblx_str+i)>=0){
//					needcheck.value=needcheck.value.replace(","+lblx_str+i,"");  //可编辑
//					document.all(lblx_str+i+"span").innerHTML = "";	
		//	}
				
//				if(needcheck.value.indexOf(lb_str+i)>=0){
//					needcheck.value=needcheck.value.replace(","+lb_str+i,"");  //可编辑
//					document.all(lb_str+i+"span").innerHTML = "";	
//					
//	//	}
	//	}
////	}
//	})
		
//	jQuery("#"+lb_str+i).bind("change",function(){
//		var needcheck = document.all("needcheck");
		// 获取类别类型
//		var s_sm_val = jQuery("#"+lb_str+i).val();
//		if(s_sm_val == null || s_sm_val.length==0 ){
//			document.all(lb_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
//		}else{
//			document.all(lb_str+i+"span").innerHTML = "";
//	}
//	})
}