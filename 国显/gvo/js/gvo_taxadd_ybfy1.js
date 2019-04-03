//进项税金发票号码必填控制
jQuery(document).ready(function() {
	var fykmbm = "field7556_";//费用科目编码
	var fp = "field23765_";//发票

    for(var j=0;j<100;j++){
	    if(jQuery("#"+fykmbm+j).length>0)
		{
		    checkfp(j);
	    }else{
		    j = 101;
	    }
    }

    function checkN(){
	    var nowRow=parseInt($G("indexnum0").value)-1;
	    checkM1(nowRow);
    }


    function checkM1(index){     
		if(jQuery("#"+fykmbm+i).length>0){
            jQuery("#"+fykmbm+i).bindPropertyChange(function(){
				checkfp(index);			
			});	
		} 	   
    }
		
	function checkfp(index)
	{   
	    for (var i =0;i <index;i ++)
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






