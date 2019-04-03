var bcfke = "field8615";
var yhmc = "field10317";
var yhzh = "field10318";

jQuery("#"+bcfke).bind("change",function(){
	var needcheck = document.all("needcheck");
	// 获取值
	var fke_val = jQuery("#"+bcfke).val();
	if(Number(fke_val)>0){
	document.all(yhmc+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	if(needcheck.value.indexOf(yhmc)<0){  //如果非必填项，则加入必填项判断
	if(needcheck.value!='') needcheck.value += ",";
	needcheck.value += yhmc;
					    }
         document.all(yhzh+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	if(needcheck.value.indexOf(yhzh)<0){  //如果非必填项，则加入必填项判断
	if(needcheck.value!='') needcheck.value += ",";
	needcheck.value += yhzh;
					    }
         
				}else
	    {
		if(needcheck.value.indexOf(yhmc)>=0){
		needcheck.value=needcheck.value.replace(","+yhmc,"");  //可编辑
		document.all(yhmc+"span").innerHTML = "";	

						     }
if(needcheck.value.indexOf(yhzh)>=0){
		needcheck.value=needcheck.value.replace(","+yhzh,"");  //可编辑
		document.all(yhzh+"span").innerHTML = "";	

						     }

	    		     }
					    })