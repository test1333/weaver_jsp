var zymc = "#field17876";//资源名称

//alert(1234);
//setTimeout('yourFunction1()',1000);

//function yourFunction1(){
	//资源名称
	var tmp_bookid = jQuery("#tmp_bookid").val();
//	alert("tmp_bookid = " + tmp_bookid);
	if(tmp_bookid.length>0){
//		alert(tmp_bookid);
			jQuery.post("/gvo/jsPublicSrc/getSrcInfo.jsp",{'id':tmp_bookid},function(data){
//                alert(data);
				data = data.replace(/\n/g,"").replace(/\r/g,"");
                eval('var obj ='+data);
                var srcID = obj.srcID;
                var srcName = obj.srcName;
                jQuery(zymc).val(srcID);
                jQuery(zymc+"span").html(srcName);
			});
//		alert("book_id2 = " + tmp_bookid);
	}
//}





jQuery(document).ready(function(){
	//  资源状态
	//alert(11111);
	var wzzt = "#field18447";
	checkCustomize = function(){
		var wzzt_val = jQuery(wzzt).val();
		var result = true;
		if(Number(wzzt_val) > 0){
			result = false;
			window.top.Dialog.alert("该物资非空闲，暂不可借用！");
		}
		return result;
	}
});