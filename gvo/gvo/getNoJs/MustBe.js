var gjyhdm = "field6566";
var ygdm = "field8096";
var yhzh = "field6568";
var yhhz = "field6569";


jQuery(document).ready(function(){

	jQuery("#"+gjyhdm).bindPropertyChange(function () {
 //   jQuery("#"+gjyhdm).bind("propertychange",function(){
		var needcheck = document.all("needcheck");
		
		// 获取MRP类型
		var s_sm_val = jQuery("#"+gjyhdm).val();
	alert(s_sm_val );
		if(s_sm_val.length>0 ){
		        jQuery("#"+ygdm+"span").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			jQuery("#"+yhzh+"span").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			jQuery("#"+yhhz+"span").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			//document.all(zhmrp_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			if(needcheck.value.indexOf(ygdm)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=ygdm;
				
			}
			if(needcheck.value.indexOf(yhzh)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=yhzh;
				
			}
			if(needcheck.value.indexOf(yhhz)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=yhhz;
				
			}
		}else{
			if(needcheck.value.indexOf(ygdm)>=0){
				needcheck.value.replace(","+ygdm,"");  //可编辑
				document.all(ygdm+"span").innerHTML = "";	
				
			}
			if(needcheck.value.indexOf(yhzh)>=0){
				needcheck.value.replace(","+yhzh,"");  //可编辑
				document.all(yhzh+"span").innerHTML = "";	
				
			}
			if(needcheck.value.indexOf(yhhz)>=0){
				needcheck.value.replace(","+yhhz,"");  //可编辑
				document.all(yhhz+"span").innerHTML = "";	
				
			}
		}
	})


})