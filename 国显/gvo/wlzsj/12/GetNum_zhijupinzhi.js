//sap 
var sapbm_str = "field6833_";
// 总货架寿命
var zhjsm_str = "field7673_";
// 最小剩余货架寿命
var zxsm_str = "field7612_";
//类别类型
var lblx_str="field7775_";
//类别
var lb_str="field7885_";
for(var i =0;i<500;i++){
	// 目标存在
	if(jQuery("#"+sapbm_str+i).length>0){
		ismeth(i);
	}
}


function ismeth(i){
                  
          
	  
          jQuery("#"+lblx_str+i).bind("change",function()
          {
             var lblx_val = jQuery("#"+lblx_str+i).val(); 
             alert(lblx_val);
             var needcheck = document.all("needcheck");
             if(lblx_val!='023') 
             { 
                 if(needcheck.value.indexOf(lb_str+i)>=0){
                 alert(lblx_val);
	         document.all(lb_str+i+"span").innerHTML = "";
                 needcheck.value.replace(","+lb_str+i,"");  //可编辑
               }
             }

           }
		if(lblx_val=="023"){
                   document.all(lb_str+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
                   if(needcheck.value.indexOf(lb_str+i)<0){  //如果非必填项，则加入必填项判断
                    
                   if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=lb_str+i;
                   }
           }
              

)
             
        
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
				needcheck.value.replace(","+zxsm_str+i,"");  //可编辑
				document.all(zxsm_str+i+"span").innerHTML = "";	
				
			}
		}
	})
}