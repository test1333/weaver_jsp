
jQuery(document).ready(function() {
	var goodscateID = "#field10532_";
	var goodsname= "#field10531_";//资产名称
	var applicant = "#field9354"; //申请人
	var admin = "#field9363"; //资产管理员
	var wrandom = "#field10557";
	var randoms = "#field10558" ; 
	var max_lenx = 100;

		jQuery(applicant).bindPropertyChange(function () {
			    jQuery(admin).val("");
          		jQuery(admin+"span").text("");
          		jQuery(admin+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
			for(var i=0;i<=max_lenx;i++){
          		jQuery(goodsname+i).val("");
          		jQuery(goodsname+i+"span").text("");
          		jQuery(goodsname+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     		}
		});
		jQuery(admin).bindPropertyChange(function () {
			for(var i=0;i<=max_lenx;i++){
          		jQuery(goodsname+i).val("");
          		jQuery(goodsname+i+"span").text("");
          		jQuery(goodsname+i+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     		}
		});

	checkCustomize = function() {
		var result = true;
		var res = true;

		for(var index=0;index<max_lenx;index++){
			if(result){

			    var wrandomx = jQuery(wrandom).val();
        		var randomx = jQuery(randoms).val();
        		if(typeof(wrandomx)!="undefined"&&wrandomx&&typeof(randomx)!="undefined"&&randomx){
        			if (wrandomx!==randomx){
        			alert("验证码错误，请重新输入");
        			result = false;	
        		}
        	}
			}

        if(res){
        	if(jQuery(goodscateID+index).length>0){
			for(var yet=index+1;yet<max_lenx;yet++){
			    	var goodsname_val = jQuery(goodsname+index).val();
			    	var goodsname_val2 = jQuery(goodsname+yet).val();
			    	  if(goodsname_val==goodsname_val2){
			    		alert("同一资产，在一个流程中只能申请一次归还，请检查");
			    		res= false;
			    		result = false;
			    		break;
			      }   	    
			    }
			}
            }
	 }
		return result;
	}
});