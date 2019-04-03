//var jkr = "#field6606";	 // 借款人
var jkr_code = "#field7461"; // 借款人编码
var com_code = "#field7355"; // 公司编码 

var jkrje = "#field7969"; // 个人借款余额

jQuery(jkr_code).bindPropertyChange(function () {
//jQuery(jkr_code).bind("propertychange",function(){ 	
//	var jkr_1 = jQuery(jkr).val();
	var jkr_code_1 = jQuery(jkr_code).val();
//	var com_code_1 = jQuery(com_code).val();
	
	if(jkr_code_1.length>0){
		com_code_1 = "1000";
		get_some_sap(jkr_code_1,com_code_1);
	}
});


function get_some_sap(jkr_code_1,com_code_1){
			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器  
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}
			if (null != xhr) {
				var timestamp=new Date().getTime();
				var postStr = "ranTime="+timestamp+"&emp_code="+jkr_code_1+"&com_code="+com_code_1;
		//		alert("12233 = " + postStr );
				xhr.open("GET","/gvo/sap/gvo_get_sap_return.jsp?"+postStr, false);
				
				xhr.onreadystatechange =	function () {
						
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								
								var obj = eval( "(" + text + ")" );
								var sap_val = obj.type.E_DMBTR;
								
								jQuery(jkrje).val(sap_val);
								jQuery(jkrje+"span").html(sap_val);
							}
						}
					}
				xhr.send(null);
			}
				
}
