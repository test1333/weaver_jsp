//进项税金发票号码必填控制
jQuery(document).ready(function() {
	var fykmbm = "field21488_";//费用科目编码
	var fp = "field22366_";//发票

    jQuery("button[name=addbutton0]").live("click",function(){
        var indexnum0=jQuery("#indexnum0").val();
		//alert(indexnum0);
        for(var index =0;index <indexnum0;index ++){     
		    if(jQuery("#"+fykmbm+index).length>0){
                jQuery("#"+fykmbm+index).bindPropertyChange(function(){
				    checkfp(indexnum0);			
			    });	
		    } 	   
        } 
    });
		
	function checkfp(indexnum0)
	{
		for(var i=0;i<indexnum0;i++)
		{
			var fykmbm_d = jQuery("#"+fykmbm+i).val();
			var needcheck = document.all("needcheck");	
			//alert(fykmbm_d);
			if (fykmbm_d=="2221010100")
			{		
			    if(jQuery("#"+fp+i).length>0)
		        {	
	                if (jQuery("#"+fp+i).val()=="" || jQuery("#"+fp+i).val()==null)
		            {   
			            document.all(fp+i+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"; 
		            }
		
		            if(needcheck.value.indexOf(fp+i)<0)
		            {  //如果非必填项，则加入必填项判断
			            if(needcheck.value!='')
				        needcheck.value += ",";
                        needcheck.value += fp+i;
			        }		
                }
			}
			else
			{   
				if(needcheck.value.indexOf(fp+i)>=0)
		        { 
	                needcheck.value=needcheck.value.replace(","+fp+i,"");  //可编辑
				
		            document.all(fp+i+"span").innerHTML = "";// 值清空
		            jQuery("#"+fp+i).val("");
		        }
			}
		}			
	}
});