var jiediao = "field6403";
var ksrq = "field10779";
var jsrq = "field8966";

jQuery("#"+jiediao).bind("change",function(){

	// 获取所有必填信息
	var needcheck = document.all("needcheck");
	
	var aItem = document.getElementById(jiediao).checked;		
	if(aItem == true)
	{		
		if(jQuery("#"+ksrq).length>0)
		{	
                document.all(ksrq+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";		
		if(needcheck.value.indexOf(ksrq)<0){  //如果非必填项，则加入必填项判断								if(needcheck.value!='') needcheck.value += ",";			
		needcheck.value += ksrq;}		
                                                    }		
		if(jQuery("#"+jsrq).length>0)	
		{
		document.all(jsrq+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";		
		if(needcheck.value.indexOf(jsrq)<0){  //如果非必填项，则加入必填项判断								if(needcheck.value!='') needcheck.value += ",";			
		needcheck.value += jsrq;}		}	
	}else{			
		if(needcheck.value.indexOf(ksrq)>=0)			
		needcheck.value=needcheck.value.replace(","+ksrq,"");  //可编辑				
		document.all(ksrq+"span").innerHTML = "";			// 值清空				
		jQuery("#"+ksrq).val("");						    		
		if(needcheck.value.indexOf(jsrq)>=0)												needcheck.value=needcheck.value.replace(","+jsrq,"");  //可编辑			
		document.all(jsrq+"span").innerHTML = "";	// 值清空							
		jQuery("#"+jsrq).val("");			            	
	      }
});
