
jQuery(document).ready(function() {
	var difference = "#field6402_";
	var max_lenx = 200;
	checkCustomize = function() {
		var result = true;
		for(var index=0;index<max_lenx;index++){
			if(result){
				if(jQuery(difference+index).length>0){
				var differencex = jQuery(difference+index).val();
                 if(differencex!==0){
                 	result = false;
                 }
			    }else{
			   	   	index = 201;
			    }
			}else{
			   	index = 201;
			}
		}
		return false;
	}
});