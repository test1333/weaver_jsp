jQuery(document).ready(function () {
	var applyworkflow = "#field13721"; // 物品申请流程
	var expenseType = "#field11171"; // 报销类型

	var _dept = "field9915_"; // 部门
	var _deptName = "field9354_"; // 部门名称
	var _cptCard = "field13761_"; // 资产卡片
	var _cptDescribe = "field10802_"; // 资产描述
	var _budgetMoney = "field9917_"; // 预算金额
	var _expense = "field10645_"; // 报销金额
	var _businessRange = "field10693_"; // 业务范围
	var _busiRangeName = "field11309_"; // 业务范围名称
	var _tax = "field10853_"; // 税码
	var _taxRate = "field10855_"; // 税率
	var _taxes = "field12202_"; //税金
	var _noTax = "field10853_"; // 不含税金额
	var _insideOrder = "field9918_"; // 内部订单号
	var _insideOrderDesc = "field9359_"; //内部订单号描述

	jQuery(expenseType).bindPropertyChange(function () {
		var expenseType_val = jQuery(expenseType).val();
		if (expenseType_val == '1') {
			adoreFunction();
		} else {
			deleteDt();
			jQuery(applyworkflow).val("");
			jQuery(applyworkflow + "span").html("");
		}

	});

	jQuery(applyworkflow).bindPropertyChange(function () {
		adoreFunction();
	});

	function fl_change(_rowdtid) {
		//alert("_rowdtid=" + _rowdtid);
		var xhr = null;
		if (window.ActiveXObject) { //IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var _applywf_val = jQuery(applyworkflow).val();
			alert("_applywf_val= " + _applywf_val);
			//alert("_emp_code_val= " + _emp_code_val);
			xhr.open("GET", "/feilida/js/cpt/cptApply.jsp?reqid=" + _applywf_val + " ", false);
			xhr.onreadystatechange = function () {

				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var text = xhr.responseText;
						text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						alert("text= " + text);
						var text_arr = text.split("@@@");
						if (text_arr.length > 1) {
							var length_dt = Number(text_arr.length) - 1 + Number(_rowdtid);
							for (var i = _rowdtid; i < length_dt; i++) {
								//alert("lenth" + text_arr.length);
								//alert("index="+index);
								addRow0(0);

								var tmp_arr = text_arr[i - _rowdtid].split("###");

								jQuery("#" + _deptName + i).val(tmp_arr[0]); //存放id
								jQuery("#" + _deptName + i + "span").html(tmp_arr[0]); //存放名称

								jQuery("#" + _dept + i).val(tmp_arr[1]); //存放id
								jQuery("#" + _dept + i + "span").html(tmp_arr[1]); //存放名称

								jQuery("#" + _cptCard + i).val(tmp_arr[2]); //存放id
								jQuery("#" + _cptCard + i + "span").html(tmp_arr[2]); //存放名称

								jQuery("#" + _cptDescribe + i).val(tmp_arr[3]); //存放id
								jQuery("#" + _cptDescribe + i + "span").html(tmp_arr[3]); //存放名称

								jQuery("#" + _budgetMoney + i).val(tmp_arr[4]); //存放id
								jQuery("#" + _budgetMoney + i + "span").html(tmp_arr[4]); //存放名称

								jQuery("#" + _expense + i).val(tmp_arr[5]); //存放id
								jQuery("#" + _expense + i + "span").html(tmp_arr[5]); //存放名称

								jQuery("#" + _businessRange + i).val(tmp_arr[6]); //存放id
								jQuery("#" + _businessRange + i + "span").html(tmp_arr[6]); //存放名称

								jQuery("#" + _busiRangeName + i).val(tmp_arr[7]); //存放id
								jQuery("#" + _busiRangeName + i).val(tmp_arr[7]); //存放id
								//jQuery("#" + _cityType + i + "span").html(tmp_arr[6]); //存放名称

								jQuery("#" + _tax + i).val(tmp_arr[8]); //存放id
								jQuery("#" + _tax + i + "span").html(tmp_arr[8]); //存放名称

								jQuery("#" + _taxRate + i).val(tmp_arr[9]); //存放id
								jQuery("#" + _taxRate + i + "span").html(tmp_arr[9]); //存放名称

								jQuery("#" + _taxes + i).val(tmp_arr[10]); //存放id
								jQuery("#" + _taxes + i + "span").html(tmp_arr[10]); //存放名称

								jQuery("#" + _insideOrder + i).val(tmp_arr[11]); //存放id
								jQuery("#" + _insideOrder + i + "span").html(tmp_arr[11]); //存放id
								//jQuery("#" + _cityType + i + "span").html(tmp_arr[6]); //存放名称

								jQuery("#" + _insideOrderDesc + i).val(tmp_arr[12]); //存放id
								jQuery("#" + _insideOrderDesc + i + "span").html(tmp_arr[12]); //存放名称

								//jQuery("#" + _hotelStandard + i).val(tmp_arr[9]); //存放id
								//jQuery("#" + _hotelStandard + i + "span").html(tmp_arr[9]); //存放名称

								//jQuery("#" + _foodStandard + i).val(tmp_arr[10]); //存放id
								//jQuery("#" + _foodStandard + i + "span").html(tmp_arr[10]); //存放名称

							}
						}
					}
				}
			}
			xhr.send(null);
		}
	}

	function adoreFunction() {
		jQuery(applyworkflow).bindPropertyChange(function () {
			var _indexnum0 = jQuery("#indexnum0").val();
			deleteDt();
			fl_change(_indexnum0);
		});

	}

	function deleteDt() {
		var _nodesnum0 = jQuery("#nodesnum0").val();
		//alert("_nodesnum0=" + _nodesnum0);
		if (_nodesnum0 > 0) {
			jQuery("[name = check_node_0]:checkbox").attr("checked", true);
			deleteRow0(0);
		}
	}
});