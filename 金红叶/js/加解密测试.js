<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var name="#field17059";
var jmname="#field17060";
var dh="#field17068";
var jmdh="#field17069span";	
jQuery(document).ready(function(){
	var jmname_val = jQuery(jmname).val();
	var jmdh_val = jQuery(jmdh).text();
	
	alert(jmdh_val);
	var name_val=getDecodeValue(jmname_val);
		var dh_val=getDecodeValue(jmdh_val);
	
	alert(dh_val);
	jQuery(name).val(name_val);
	jQuery(name+"span").text(name_val);
	jQuery(dh).val(dh_val);
	jQuery(dh+"span").html(dh_val);
})
function getDecodeValue(oldvalue){
	var value=encodeURIComponent(oldvalue);
	var name_val="";
	var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
		xhr.open("GET","/appdevjsp/HQ/DECODE/get-decode-value.jsp?oldvalue="+value, false);
		xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
		  if (xhr.status == 200) {
			var text = xhr.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			name_val = text;
	         }
		  }
	 }
       xhr.send(null);
     }
     return name_val;
}
    
</script>
