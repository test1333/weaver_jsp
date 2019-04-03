jQuery(document).ready(function() {

	var gzxz = "field11446_"; //工作性质
	var j_jblxCode = "field8826_";//加班类型编码
	var tmp_gzxz;
	var tem_j_jblxCode;
	//alert(123456);

	checkCustomize = function() {
		var result = true;
		var nowRow = parseInt($G("indexnum0").value) - 1;
		for (var i = 0; i <= nowRow; i++) {
			tmp_gzxz = jQuery("#" + gzxz + i).val();
			//alert("tmp_gzxz="+tmp_gzxz);
			if (tmp_gzxz == "B") {
				tem_j_jblxCode = jQuery("#" + j_jblxCode + i).val();
				//alert("tem_j_jblxCode="+tem_j_jblxCode);
				if (tem_j_jblxCode != "O_003") {
					window.top.Dialog.alert("当前加班非节假日加班,不能提交！");
					result = false;
				}
			}
		}

		return result;
	}
});
