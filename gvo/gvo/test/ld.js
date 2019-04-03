// 订单单位
var dddw_str = "field8525_";
 //编号
var  bh_str = "field8381_";
//名称
var   mc_str ="field8382_";

//button
var csbtn_str = "field8526_";
// 目标存在
setTimeout('yourFunction()',1000);

function yourFunction(){
	for(var i =0;i<500;i++){
		// 目标存在
		if(jQuery("#"+bh_str+i).length>0){		

                       ismeth(i);
		}
	}
}


function ismeth(i){
                
	        jQuery("#"+dddw_str+i).bind("propertychange",function(){ 
   		var dddw_val = jQuery("#"+dddw_str+i).val();
                window.top.Dialog.alert("input 编号&&名称!");
                var needcheck = document.all("needcheck");
                if(dddw_val==1000)
                {
                   //alert("dddw_val = " + dddw_val+"");
                   jQuery("#"+csbtn_str+i).parent().find(".Browser").removeAttr("onclick");  
                   document.getElementById(bh_str+i).readOnly = true;
		   document.getElementById(mc_str+i).readOnly = true;
                }
                else
                {
                   //jQuery("#"+csbtn_str+i).parent().find(".Browser").attr("onclick","test();");  
                   document.getElementById(bh_str+i).removeAttribute("readOnly");
		   
                   document.all(bh_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
				if(needcheck.value.indexOf(bh_str+i)<0){  //如果非必填项，则加入必填项判断
					if(needcheck.value!='') needcheck.value+=",";
					needcheck.value+=bh_str+i;
				}
                   document.getElementById(mc_str+i).removeAttribute("readOnly");
                   document.all(mc_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			if(needcheck.value.indexOf(mc_str+i)<0){  //如果非必填项，则加入必填项判断
					if(needcheck.value!='') needcheck.value+=",";
					needcheck.value+=mc_str+i;
				}
                   
                }
       })
}
