<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var dh="#field12401";//单号
var ms="#field12398";//描述
jQuery(document).ready(function(){
	var dh_val = jQuery(dh).val();
	var ms_val = jQuery(ms+"span").text();
	var oldvalue=dh_val+","+ms_val;
	var newvalue=getDecodeValue(oldvalue);
	var values=newvalue.split("###");
	jQuery(dh+"span").text(values[0]);
	jQuery(ms+"span").html(values[1]);
	
})
function getDecodeValue(oldvalue){
	var value=encodeURIComponent(oldvalue);
	var newvalue="";
	var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
		xhr.open("GET","/appdevjsp/HQ/DECODE/get-decode-value-workflow.jsp?oldvalue="+value, false);
		xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
		  if (xhr.status == 200) {
			var text = xhr.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			newvalue = text;
	         }
		  }
	 }
       xhr.send(null);
     }
     return newvalue;
}
    
</script>
