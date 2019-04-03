//alert("测试！");

jQuery(document).ready(function() {

	var isRepeat = "#field5979"; //是否重复

	checkCustomize = function() {

		var isRepeat_val = jQuery(isRepeat).val();
		//alert("是否重复="+isRepeat_val);

		var result = true;

		if (Number(isRepeat_val)>0) {
			result = false;
			alert("加班时间重复,请重新填写！");
		}
		return result;
	}

});