<script type="text/javascript" >
var tsmc_1 = "#field8647";//图书名称
var csxz_1 = "#field8649";//藏书性质
var tsszd_1 = "#field8945";//图书所在地
var tsbh_1 = "#field15588";//图书编号
var sslb_1 = "#field15589";//所属类别
jQuery(document).ready(function(){
//alert();
	// 归还 >> 已经提交的 不能再提交
//	alert("123");
	checkCustomize = function(){ 
//		alert("456");
		var result = true; 
		var tmp_bookid = jQuery(tsmc_1).val();
		var flag_x = calBooks(tmp_bookid);
		
	//	alert("flag_x = " + flag_x);
		if(flag_x=="1"){
			alert("无图书归还！");
			result = false; 
		}else if(flag_x=="2"){
			alert("已经申请归还！");
			result = false; 
		}
		return result;
	}
	
	
	var tsmc = "field8647";
});
	function calBooks(tmp_bookid) {
		var res = "0";
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器  
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var timestamp=new Date().getTime();
			var postStr = "ranTime="+timestamp+"&id="+tmp_bookid;
		//		alert("12233 = " + postStr );
			xhr.open("GET","/gvo/jsBooks/isCommitBook.jsp?"+postStr, false);
				
			xhr.onreadystatechange =	function () {
						
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//		alert("text = " + text);		
					res = text;
				}
						}
					}
				xhr.send(null);
			}
		return res;
	}


</script>