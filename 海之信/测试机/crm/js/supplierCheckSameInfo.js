jQuery(document).ready(function() {

	var nameInfo = "#field8079" ; 
	var telInfo= "#field8080";
        var websitInfo = "#field8081";
        
	checkCustomize = function() {
            var tmp_nameInfo = jQuery(nameInfo).val();
            if(tmp_nameInfo == "重复"){
                 alert("名称重复,请检查后更改不重复的名称！");
                 return false;
            }
            var tmp_telInfo = jQuery(telInfo).val();
            if(tmp_telInfo == "重复"){){
                 alert("电话重复,请检查后更改不重复的电话！");
                 return false;
            }
            var tmp_websitInfo = jQuery(websitInfo).val();
            if(tmp_websitInfo == "重复"){){
                 alert("网站重复,请检查后更改不重复的网站！");
                 return false;
            }
          return true;
	}
});


