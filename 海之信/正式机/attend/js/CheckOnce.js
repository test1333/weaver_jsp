//alert("测试！");

jQuery(document).ready(function() {

	var isMore = "#field6011";//是否重复

	checkCustomize = function() {

        var isMore_val = jQuery(isMore).val();
		//alert("mealcredits_val="+isMore_val);
		var result = true;
		if (Number(isMore_val) > 0) {
			result = false;
			alert("本假期为一次性假期,请勿重复销假");
		}
		return result;
	}

});
