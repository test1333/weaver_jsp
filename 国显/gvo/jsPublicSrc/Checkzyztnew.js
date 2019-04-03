jQuery(document).ready(function () {
	var wzzt = "#field11958";
	var zymc = "#field11994";//资源名称

	/*
	//资源名称
	var tmp_bookid = jQuery("#tmp_bookid").val();
	//	alert("tmp_bookid = " + tmp_bookid);
	if (tmp_bookid.length > 0) {
		//		alert(tmp_bookid);
		jQuery.post("/gvo/jsPublicSrc/getSrcInfo.jsp", { 'id': tmp_bookid }, function (data) {
			//                alert(data);
			data = data.replace(/\n/g, "").replace(/\r/g, "");
			eval('var obj =' + data);
			var srcID = obj.srcID;
			var srcName = obj.srcName;
			jQuery(zymc).val(srcID);
			jQuery(zymc + "span").html(srcName);
		});
		//		alert("book_id2 = " + tmp_bookid);
	}*/
	checkCustomize = function () {
		var wzzt_val = jQuery(wzzt).val();
		var result = true;
		alert("状态" + wzzt_val);
		if (Number(wzzt_val) > 0) {
			result = false;
			window.top.Dialog.alert("该物资非空闲，暂不可借用！");
		}
		return result;
	}
});