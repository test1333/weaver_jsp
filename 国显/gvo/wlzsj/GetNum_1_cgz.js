// 是否委外
var sfww_str = "field7370_";
// 订单单位
var ddwd_str = "field6842_";
//采购组
var cgz_str = "field6837_";
// 基本计量单位分母 
var jlfm_str = "field7834_";
// 基本计量单位分子 
var jlfz_str = "field7835_";
//货源清单 
var hlqd_str = "field7668_";
//配额安排 
var peap_str = "field7764_";

setTimeout('yourFunction()',1000);

function yourFunction(){
	for(var i =0;i<500;i++){
		// 目标存在
		if(jQuery("#"+sfww_str+i).length>0){
			ismeth(i);
		}
	}
}


function ismeth(i){
	// 委外的值
	var sfww_val = jQuery("#"+sfww_str+i).val();
	//  不需要维护采购视图
	// alert("sfww_val = " + sfww_val);
	var needcheck = document.all("needcheck");
//	alert("123 = " + needcheck.value + " # " + (cgz_str+i));
	if(sfww_val=='1'){
		
		// 文本框只读
		document.getElementById(jlfm_str+i).readOnly = true;
		document.getElementById(jlfz_str+i).readOnly = true;
		
		// 按钮失效
		jQuery("#"+ddwd_str+i).parent().find(".Browser").removeAttr("onclick");
		jQuery("#"+hlqd_str+i).parent().find(".Browser").removeAttr("onclick");
		jQuery("#"+peap_str+i).parent().find(".Browser").removeAttr("onclick");
		
		
		
//		var needcheck = document.getElementById("needcheck");
//		alert("123 = " + needcheck);
		
		// ?????  必填转编辑  编辑转无效
//		var needcheck = jQuery("#needcheck");
//		alert("123text = " + needcheck.text());
		
		if(needcheck.value.indexOf(cgz_str+i)>=0){
			needcheck.value=needcheck.value.replace(","+cgz_str+i,"");  //可编辑
			document.all(cgz_str+i+"span").innerHTML = "";
		    jQuery("#"+cgz_str+i).parent().find(".Browser").removeAttr("onclick");
       }
		
	}else{
		
		jQuery("#"+ddwd_str+i).bind("propertychange",function(){
				// 获取单位
			 var s_sm_val = jQuery("#"+ddwd_str+i).val();
			 // 获取单位 有值  则必填
			 if(s_sm_val.length > 0 ){
			    	// 获取必填信息
			    	document.getElementById(jlfm_str+i).removeAttribute("readOnly");
			    	document.getElementById(jlfz_str+i).removeAttribute("readOnly");
			    	
					var needcheck = document.all("needcheck");
					
			       	document.all(jlfm_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
				    if(needcheck.value.indexOf(jlfm_str+i)<0){  //如果非必填项，则加入必填项判断
			            if(needcheck.value!='') needcheck.value+=",";
			            needcheck.value+=jlfm_str+i;
		    		}
		    		
					document.all(jlfz_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
				    if(needcheck.value.indexOf(jlfz_str+i)<0){  //如果非必填项，则加入必填项判断
			            if(needcheck.value!='') needcheck.value+=",";
			            needcheck.value+=jlfz_str+i;
		    		}
			  }else{
			  	  // 获取必填信息
				  var needcheck = document.all("needcheck");
			      if(needcheck.value.indexOf(jlfm_str+i)>=0){
						needcheck.value=needcheck.value.replace(","+jlfm_str+i,"");  //可编辑
						document.all(jlfm_str+i+"span").innerHTML = "";
						document.getElementById(jlfm_str+i).value="";
						
						document.getElementById(jlfm_str+i).readOnly = true;
						
				//		document.getElementById(jlfm_str+i).setAttribute("readOnly",true);
						
		
				  }
				  if(needcheck.value.indexOf(jlfz_str+i)>=0){
						needcheck.value=needcheck.value.replace(","+jlfz_str+i,"");  //可编辑
						document.all(jlfz_str+i+"span").innerHTML = "";
						document.getElementById(jlfz_str+i).value="";
						document.getElementById(jlfz_str+i).readOnly = true;
						
				//		document.getElementById(jlfz_str+i).setAttribute("readOnly",true);

				  }
			  }
		})

	}

}