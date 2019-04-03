jQuery(document).ready(function() {
	var wk = "field8361_"      //工号
	var name = "field5854_"    // 姓名取span
	


	checkCustomize = function() {
		var result = true;
		for(var index = 0; index<200; index++){
			
			if(jQuery("#"+wk+index).length>0){	
			    //alert("val_wk="+jQuery("#"+wk+index).length);		
				var val_wk = jQuery("#"+wk+index).val();
				var val_name = jQuery("#"+name+index).val();
				var val_name_1 = jQuery("#"+name+index+"span").text();
				//alert(123);
				var isT = isRight(val_wk,val_name);
                                var tmp_index = Number(index)+1;
				//alert(isT);
                                //alert(tmp_index);
				if(isT==false){
					window.top.Dialog.alert("第"+tmp_index+"行人员工号["+val_wk+"]和姓名["+val_name_1+"]不匹配！");
					return false;
				}
			}
		}
		return true;
	}

	function isRight(wk,name){ 
		var tmp_1 = ""; 
		$.ajax({
         		type : "post",  
          		url : "/gvo/hrm/gvo_hrm.jsp",
          		dataType: "json",  
                	data:{'wk':wk,'name':name},
          		
          		async : false,
          		success : function(datar){
            			tmp_1 = datar;
          		        
            			
          		}  
     		}); 
	// alert("tmp_1="+tmp_1);
	if(tmp_1 == "1")  return true;
				        	
		return false;
		
	}
});
