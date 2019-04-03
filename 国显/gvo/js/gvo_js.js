// 判断身份证是否重复
function startCardIdDiff() {
	var cardid_1 = document.getElementById("certificatenum").value;
	var id_1 = document.getElementById("id").value;
//	alert("cardid_1 = " + cardid_1 + ",id="+id_1);
	
	if (cardid_1.length>0){
	
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器  
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var timestamp=new Date().getTime();
			var postStr = "ranTime="+timestamp+"&emp_id="+id_1+"&card_id="+cardid_1;
	//		alert("12233 = " + postStr );
			xhr.open("GET","/gvo/hrm/gvo_hrm_card_edit.jsp?"+postStr, true);
			
			xhr.onreadystatechange =	function () {
			
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var text = xhr.responseText;
						text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						
				//		alert(text);
						if(text.length>2){
						//	alert(text);
							document.getElementById("gvo_cer_id").innerText=text;
					//		document.getElementById("gvo_cer_id").style.color="red"
							document.getElementById("certificatenum").value = "";
						}else{
							document.getElementById("gvo_cer_id").innerText="无重复可以使用!";
						}
					}
				}
			}
			xhr.send(null);
		}
	}
}