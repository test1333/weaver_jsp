var jb = "field8202";
var fjsc = "field6168";//下划线 区分明细和主表 var fjsc = "field6168_";

function load_t(){
//	alert(1);
	var s_sm_val = jQuery("#"+jb).val();
	
//	alert("s_sm_val = " + s_sm_val);
	//  获取表单页面 所有的必填项
	var needcheck = document.all("needcheck");
//	alert("needcheck = " + needcheck.value);
	if(s_sm_val != "L_005"&&s_sm_val != "L_006"&&s_sm_val != "L_007"){
		
		if(needcheck.value.indexOf(fjsc)>=0){
			needcheck.value=needcheck.value.replace(","+fjsc,"");  //可编辑
			document.all(fjsc+"span").innerHTML = "";	//去掉红色感叹号
		}
		
	}else{
        // 附件 
		var s_sm_val_1 = jQuery("#"+fjsc).val();
		if(s_sm_val_1.length>0){
			document.all(fjsc+"span").innerHTML = "";	//去掉红色感叹号
		}
	}
}

window.setTimeout(load_t, 2000);//延迟加载