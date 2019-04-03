<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function() {
	/*主表*/
	var aqjb = "field31445";//安全级别
    var gllc = "field29706";//出差申请流程
   var bxlx = "field32327";//报销类型	
	function check()
	{
		var aqjb_val = jQuery("#"+aqjb).val();
		var needcheck = document.all("needcheck");
		if (Number(aqjb_val)<43 && Number(aqjb_val)>=10)
		{
			if(jQuery("#"+gllc).length>0)
			{					
                document.all(gllc+"spanimg").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";	
				if(needcheck.value.indexOf(gllc)<0)
				{  //如果非必填项，则加入必填项判断
					if(needcheck.value!='')
					needcheck.value += ",";
					needcheck.value += gllc;
				}				
			}
		}
        else if (Number(aqjb_val)>=43 || Number(aqjb_val)==7 || Number(aqjb_val)==8)
		{
			if(jQuery("#"+gllc).length>0)
			{					
				document.all(gllc+"spanimg").innerHTML = "";// 值清空		
				if(needcheck.value.indexOf(gllc)>=0)
				{ 
					needcheck.value=needcheck.value.replace(","+gllc,"");  //可编辑			
				}			
			}
		}
	}
	
	jQuery("#"+aqjb).bindPropertyChange(function(){
        check();
	});	
	
	
	checkCustomize = function() {
		//alert("提交");
		var result = true;
		var aqjb_v = jQuery("#"+aqjb).val();
		var gllc_v = jQuery("#"+gllc).val();
		var bxlx_v = jQuery("#"+bxlx).val();
		if(bxlx_v == '1'){
			if (Number(aqjb_v)<43 && Number(aqjb_v)>=10 && gllc_v.length==0) 
			{
				Dialog.alert("\"出差申请流程\"未填写");
				result = false; 
				check();
			}
     	}

		return result;
	}
});
</script>













