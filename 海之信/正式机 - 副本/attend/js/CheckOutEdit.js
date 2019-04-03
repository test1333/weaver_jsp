//alert("测试！");

jQuery(document).ready(function() {

	var isMore = "#field6033";//是否重复

	checkCustomize = function() {

        var isMore_val = jQuery(isMore).val();
		//alert("mealcredits_val="+isMore_val);
		var result = true;
		if (Number(isMore_val) > 0) {
			result = false;
			alert("外出计划未变更,请变更后再提交！");
		}
		return result;
	}

});
