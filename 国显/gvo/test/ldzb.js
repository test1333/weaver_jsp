//样式
var ys_str = "field8379";
//样式描述
var ysms_str = "field8380";

jQuery("#"+ys_str).bind("change",function(){
		var needcheck = document.all("needcheck");		
		var ysms_val = jQuery("#"+ysms_str).val();
		var ys_val = jQuery("#"+ys_str).val();
                //alert(ys_val);

		if(ys_val.length>0 ){                        
			document.getElementById(ysms_str).removeAttribute("readOnly");
                        //alert(ys_val);
			document.all(ysms_str+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";			                if(needcheck.value.indexOf(ysms_str)<0){  //如果非必填项，则加入必填项判断
				if(needcheck.value!='') needcheck.value+=",";
				needcheck.value+=ysms_str;		
			
			}


		}else{
			if(needcheck.value.indexOf(ysms_str)>=0)
                        {
			    needcheck.value=needcheck.value.replace(","+ysms_str,"");  //可编辑
			    document.all(ysms_str+"span").innerHTML = "";					
			}
		      }
	      })
