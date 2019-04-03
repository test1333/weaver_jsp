
	/*主表*/
	var gsb = "field28250";//公司别
	/*明细表*/
    var wlcx = "field12249_";//物料名称查询
	var wlcx_Z = "field29365_";//物料名称查询(ZVI)
   
	function checkM()
	{
		var gsb_val = jQuery("#"+gsb).val();
		var needcheck = document.all("needcheck");
		var nowRow = parseInt($G("indexnum0").value);
		//window.top.Dialog.alert(nowRow);
		if (gsb_val==1)
		{
            for (var i=0;i<nowRow;i++)
	        {
				if(jQuery("#"+wlcx+i).length>0)
				{
					document.all(wlcx+i+"span").innerHTML = "";// 值清空		
					if(needcheck.value.indexOf(wlcx+i)>=0)
					{ 
						needcheck.value=needcheck.value.replace(","+wlcx+i,"");  //可编辑			
					}
					jQuery("#"+wlcx+i).val("");
				}
				if(jQuery("#"+wlcx_Z+i).length>0)
				{
					document.all(wlcx_Z+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
					if(needcheck.value.indexOf(wlcx_Z+i)<0)
					{  //如果非必填项，则加入必填项判断
						if(needcheck.value!='')
						needcheck.value += ",";
						needcheck.value += wlcx_Z+i;
					}
				}
			}
		}
        else
		{
			for (var i=0;i<nowRow;i++)
	        {
				if(jQuery("#"+wlcx+i).length>0)
				{
					document.all(wlcx+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
					if(needcheck.value.indexOf(wlcx+i)<0)
					{  //如果非必填项，则加入必填项判断
						if(needcheck.value!='')
						needcheck.value += ",";
						needcheck.value += wlcx+i;
					}
				}
				if(jQuery("#"+wlcx_Z+i).length>0)
				{
					document.all(wlcx_Z+i+"span").innerHTML = "";// 值清空		
					if(needcheck.value.indexOf(wlcx_Z+i)>=0)
					{ 
						needcheck.value=needcheck.value.replace(","+wlcx_Z+i,"");  //可编辑			
					}
					jQuery("#"+wlcx_Z+i).val("");
				}
			}
		}			
	}
	
	jQuery("#"+gsb).bindPropertyChange(function(){
        checkM();
	});	

