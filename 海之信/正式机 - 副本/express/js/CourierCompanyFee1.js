//alert("测试！");

jQuery(document).ready(function() {

    var CourierCompanyFee = "#field7028";//快递公司费用
	var ActualTotalFee = "#field7029";//实际总费用

	checkCustomize = function() {

        var CourierCompanyFee_val = jQuery(CourierCompanyFee).val();
        var ActualTotalFee_val = jQuery(ActualTotalFee).val();

		//alert("CourierCompanyFee_val="+CourierCompanyFee_val);
		//alert("ActualTotalFee_val="+ActualTotalFee_val);
		
		var result = true;
		if (Number(CourierCompanyFee_val) > Number(ActualTotalFee_val)) {
			result = false;
			alert("快递结算费用大于行政登记费用，请核对后再申请！");
		}

		return result;
	}

});
