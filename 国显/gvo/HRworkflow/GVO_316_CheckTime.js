jQuery(document).ready(function() {
    //alert("加载document");
    checkCustomize = function() {
		//alert("提交");
		var result = true;
		var wdklx = "field8203";//未打卡类型
		var sjsbsj = "field5892";//实际上班时间
		var sjxbsj = "field5893";//实际下班时间
		
		var wdklx_val = jQuery("#"+wdklx).val();
		var sjsbsj_val = jQuery("#"+sjsbsj).val();
		var sjxbsj_val = jQuery("#"+sjxbsj).val();
		//alert(""+wdklx_val.length+"");
		if(wdklx_val.length>0)
		{
			if (wdklx_val==0)//上班未打卡
       	    {
			    if(sjsbsj_val!="08:30" && sjsbsj_val!="20:30")
			    {
				    result = false;
			    }
			    if(result == false)  
			    {
				    window.top.Dialog.alert("实际上班时间选择错误！");				
			    }				
		    }
		
		    if (wdklx_val==1)//下班未打卡
       	    {
			    if(sjxbsj_val!="17:30" && sjxbsj_val!="05:30")
			    {
				    result = false;
			    }
			    if(result == false)
			    {
				    window.top.Dialog.alert("实际下班时间选择错误！");
			    }				
		    }
		
	        if (wdklx_val==2)//全天未打卡
       	    {
			    if(sjsbsj_val!="08:30" && sjsbsj_val!="20:30")
			    {
				    result = false;
			    }
			    if(result == false)  
			    {
				    window.top.Dialog.alert("实际上班时间选择错误！");
			    }	
			
			    if(sjxbsj_val!="17:30" && sjxbsj_val!="05:30")
			    {
				    result = false;
			    }
			    if(result == false)
			    {
				    window.top.Dialog.alert("实际下班时间选择错误！");
			    } 				            
		    }
		}
		return result;
	}
});






