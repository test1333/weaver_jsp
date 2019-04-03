jQuery(document).ready(function() {
    var jb = "#field8202";//请假类型
    var qjxs = "#field5886";//实际请假小时
    var fjsc = "field6168";//有效证明文件
	var fjsc1 = "field_6168";//有效证明文件
	
	checkdata();
	
	function checkdata()
	{
		var jb_val = jQuery(jb).val();//病假 L_004
		var qjxs_val = jQuery(qjxs).val();
		var needcheck = document.all("needcheck");
		//alert(jb_val);
		
		if((jb_val == "L_004" && Number(qjxs_val) > 8) || jb_val == "L_005" || jb_val == "L_006" || jb_val == "L_007" || jb_val == "L_008" || jb_val == "L_015" || jb_val == "L_012")
		{
		    if(jQuery("#"+fjsc).length>0)
		    {	 
		        document.all(fjsc1+"span").innerHTML = "(必填)";
			    if(needcheck.value.indexOf(fjsc)<0)
		        { 
			        if(needcheck.value!='')
				        needcheck.value += ",";
                        needcheck.value += fjsc;				   
		        }	
            }
		}
        else{
		    if(needcheck.value.indexOf(fjsc)>=0)
		    {  //如果非必填项，则加入必填项判断
				needcheck.value=needcheck.value.replace(","+fjsc,"");  //可编辑				
		        document.all(fjsc1+"span").innerHTML = "";// 值清空
		        jQuery("#"+fjsc).val("");
			}
		}
	}

    jQuery(qjxs).bindPropertyChange(function(){
		checkdata();
	});	

    jQuery(jb).bindPropertyChange(function(){
		checkdata();
	});		
});