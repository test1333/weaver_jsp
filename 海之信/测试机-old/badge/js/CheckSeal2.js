jQuery(document).ready(function() {
	
	//alert("1122");
	var Name = "#field7191_";//证章名称
	var SelectType = "#field7196_";//选择分类	
	var max_lenx = 200;

	checkCustomize = function() {
		var result = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
				if(jQuery(SelectType+index).length>0){
					var Name_val = jQuery(Name+index).val();
                    $.ajax({ 
                        async: false, 
                        type : "POST", 
                        data : {"Name":Name_val},
                        url : "/seahonor/badge/jsp/CheckSeal.jsp", 
                        dataType : "json", 
                        success : function(data){ 
                         if(data > 1){
                         	alert("证章入库重复");
                         	//result =false;
                          }
                         }
                        }); 
               	}
               }

		}
		return result;
	}
});