jQuery(document).ready(function () {
	//明细1
	var _emp_code = "field8361_"; //人员工号
	var _emp_id = "field5854_"; //人员姓名
	var _belongDate = "field8195_"; //归属日期

	//明细2
	var _workcode = "field27241_"; //工号
	var _name = "field27242_"; //姓名
	var _month1 = "field27225_"; //一月份
	var _month2 = "field27226_"; //二月份
	var _month3 = "field27227_"; //三月份
	var _month4 = "field27228_"; //四月份
	var _month5 = "field27229_"; //五月份
	var _month6 = "field27230_"; //六月份

	var _month7 = "field27231_"; //七月份
	var _month8 = "field27232_"; //八月份
	var _month9 = "field27233_"; //九月份
	var _month10 = "field27234_"; //十月份
	var _month11 = "field27235_"; //十一月份
	var _month12 = "field27236_"; //十二月份

	jQuery("button[name=addbutton0]").live("click", function () {
		var indexnum0 = jQuery("#indexnum0").val();
		for (var index = 0; index < indexnum0; index++) {
			if (jQuery("#" + _emp_code + index).length > 0 && jQuery("#" + _belongDate + index).length > 0) {
				//alert("www");
				gvo_bindchange(index);
			}
		}

	});

	jQuery("button[name=delbutton0]").live("click", function () {
		var indexnum1 = jQuery("#nodesnum1").val();
		if (indexnum1 > 0) {
			jQuery("[name = check_node_1]:checkbox").attr("checked", true);
			deleteRow1(1);
		}
		getData1();
	});

	jQuery("#indexnum0").bindPropertyChange(function () {
		adoreFunction();
		//alert(111);
	});

	function getdetail2(_emp_code, _emp_id, _emp_name, _belongDate) {
		//alert(000001);
		addRow1(1);
		//var nowRow0 = parseInt($G("indexnum0").value) - 1;
		var indexnum1 = jQuery("#indexnum1").val();
		var nowRow1 = parseInt($G("indexnum1").value) - 1;
		//alert("nowRow1=" + nowRow1);
		//var _emp_code_2 = jQuery("#" + _emp_code + nowRow0).val();
		if (_emp_code.length > 0 && _emp_id.length > 0 && _emp_name.length > 0 && _belongDate.length > 0) {
			jQuery.post("/gvo/HRworkflow/getOverInfo.jsp", {
				"emp_code": _emp_code,
				"belongDate": _belongDate
			}, function (data) {
				data = data.replace(/\n/g, "").replace(/\r/g, "");
				//alert(data);
				eval('var obj =' + data);
				var monthValue1 = obj.month1;
				var monthValue2 = obj.month2;
				var monthValue3 = obj.month3;
				var monthValue4 = obj.month4;
				var monthValue5 = obj.month5;
				var monthValue6 = obj.month6;
				var monthValue7 = obj.month7;
				var monthValue8 = obj.month8;
				var monthValue9 = obj.month9;
				var monthValue10 = obj.month10;
				var monthValue11 = obj.month11;
				var monthValue12 = obj.month12;

				jQuery("#" + _workcode + nowRow1).val(_emp_code);
				jQuery("#" + _workcode + nowRow1 + "span").text(_emp_code);

				jQuery("#" + _name + nowRow1).val(_emp_id);
				jQuery("#" + _name + nowRow1 + "span").text(_emp_name);

				jQuery("#" + _month1 + nowRow1).val(monthValue1);
				jQuery("#" + _month1 + nowRow1 + "span").text(monthValue1);

				jQuery("#" + _month2 + nowRow1).val(monthValue2);
				jQuery("#" + _month2 + nowRow1 + "span").text(monthValue2);

				jQuery("#" + _month3 + nowRow1).val(monthValue3);
				jQuery("#" + _month3 + nowRow1 + "span").text(monthValue3);

				jQuery("#" + _month4 + nowRow1).val(monthValue4);
				jQuery("#" + _month4 + nowRow1 + "span").text(monthValue4);

				jQuery("#" + _month5 + nowRow1).val(monthValue5);
				jQuery("#" + _month5 + nowRow1 + "span").text(monthValue5);

				jQuery("#" + _month6 + nowRow1).val(monthValue6);
				jQuery("#" + _month6 + nowRow1 + "span").text(monthValue6);

				jQuery("#" + _month7 + nowRow1).val(monthValue7);
				jQuery("#" + _month7 + nowRow1 + "span").text(monthValue7);

				jQuery("#" + _month8 + nowRow1).val(monthValue8);
				jQuery("#" + _month8 + nowRow1 + "span").text(monthValue8);

				jQuery("#" + _month9 + nowRow1).val(monthValue9);
				jQuery("#" + _month9 + nowRow1 + "span").text(monthValue9);

				jQuery("#" + _month10 + nowRow1).val(monthValue10);
				jQuery("#" + _month10 + nowRow1 + "span").text(monthValue10);

				jQuery("#" + _month11 + nowRow1).val(monthValue11);
				jQuery("#" + _month11 + nowRow1 + "span").text(monthValue11);

				jQuery("#" + _month12 + nowRow1).val(monthValue12);
				jQuery("#" + _month12 + nowRow1 + "span").text(monthValue12);

			});
		}
	}


	function adoreFunction() {
		//alert(222);
		var _indexnum0 = jQuery("#indexnum0").val();
		var _nodesnum0 = jQuery("#nodesnum0").val();
		//var work_code = "field27310_"; //人员工号
		//alert("_indexnum0=" + _indexnum0);
		//alert("_nodesnum0=" + _nodesnum0);
		if (_nodesnum0 > 0) {
			for (var ii = 0; ii < _indexnum0; ii++) {
				var _emp_code_val = jQuery("#" + _emp_code + ii).val();
				var _belongDate_val = jQuery("#" + _belongDate + ii).val();
				//alert("obj=" + _emp_code_val + "|ii=" + ii);
				if (_emp_code_val.length > 0 && _belongDate_val.length > 0) {
					//alert("www");
					gvo_bindchange(ii);
				}
			}
		}
	}

	function gvo_bindchange(index) {
		jQuery("#" + _emp_code + index).bindPropertyChange(function () {
			var indexnum1 = jQuery("#nodesnum1").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_1]:checkbox").attr("checked", true);
				deleteRow1(1);
			}
			getData1();
		})

		jQuery("#" + _belongDate + index).bindPropertyChange(function () {
			var indexnum1 = jQuery("#nodesnum1").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_1]:checkbox").attr("checked", true);
				deleteRow1(1);
			}
			getData1();
		})
	}

	function getData1() {
		var indexnum0 = jQuery("#indexnum0").val();
		for (var index1 = 0; index1 < indexnum0; index1++) {
			if (jQuery("#" + _emp_code + index1).length > 0) {
				var bh_val = jQuery("#" + _emp_code + index1).val();
				var _empid = jQuery("#" + _emp_id + index1).val();
				var _belongDateVal = jQuery("#" + _belongDate + index1).val();
				var _empname = jQuery("#" + _emp_id + index1 + "span").text();
				_empname = _empname.replace("x", "")
					//alert(_empname);
				if (bh_val != '' && _belongDateVal != '') {
					getdetail2(bh_val, _empid, _empname, _belongDateVal);
				}
			}
		}
	}
});