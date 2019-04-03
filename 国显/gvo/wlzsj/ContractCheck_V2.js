var htbh = "#field23385";//合同编号
var sfcf = "#field24466"; //是否重复
//var pdsfcf = "#field13939"; //判断是否重复
//alert(123456);


//jQuery(htbh).bind("propertychange", function() {
jQuery(htbh).bindPropertyChange(function () {
	checkCustomize = function() {
		var result = true;
		var tmp_htbh = jQuery(htbh).val();
		if (tmp_htbh.length>0) {
				var tmp_sfcf = jQuery(sfcf).val();
				//alert("tmp_sfcf="+tmp_sfcf);
				if (tmp_sfcf != "不重复,可以使用！") {
					window.top.Dialog.alert("合同编号重复，请重新填写！");
					result = false;
				}
			}
			return result;
		}
});
