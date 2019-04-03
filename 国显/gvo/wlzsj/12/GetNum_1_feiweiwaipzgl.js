// SAPbianma
var sapbm_str = "field6833_";
// 总货架寿命
var zhjsm_str = "field7673_";
// 最小剩余货架寿命
var zxsm_str = "field7612_";


for(var i =0;i<500;i++){
	// 目标存在
	if(jQuery("#"+sapbm_str+i).length>0){
		ismeth(i);
	}
}


function ismeth(i){
	
   	jQuery("#"+zhjsm_str+i).bind("change",function(){
		var needcheck = document.all("needcheck");
		// 获取MRP类型
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
				needcheck.value.replace(","+zxsm_str+i,"");  //可编辑
				document.all(zxsm_str+i+"span").innerHTML = "";	
				
			}
		}
	})
}