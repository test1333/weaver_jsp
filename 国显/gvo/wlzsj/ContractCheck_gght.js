
jQuery(document).ready(function () {
	var htbh = "#field12389"; //合同编号
	var sfcf = "#field13125"; //是否重复
	checkCustomize = function () {
		var result = true;
		var tmp_htbh = jQuery(htbh).val();
		if (tmp_htbh.length > 0) {
			var tmp_sfcf = jQuery(sfcf).val();
			//alert("tmp_sfcf="+tmp_sfcf);
			if (tmp_sfcf != "不重复,可以使用！") {
				alert("合同编号重复，请重新填写！");
				result = false;
			}
		}
		return result;
	}
});
