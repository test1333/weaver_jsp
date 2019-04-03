jQuery(document).ready(function () {
	//明细1
	var qjr_code = "field27310_"; //人员工号
	var qjr_id = "field27311_"; //人员姓名
	var yjqjksrq = "field27313_"; //预计请假开始日期
	var yjqjjsrq = "field27317_"; //预计请假结束日期
	var yjqjkssj = "field27314_"; //预计请假开始时间
	var yjqjjssj = "field27318_"; //预计结束开始时间
	var xjlxbm = "field27312_"; //休假类型编码
	var yjsjxss = "field27321_"; //预计休假小时数

	//明细2
	var _workcode = "field27323_"; //工号
	var _name = "field27324_"; //姓名
	var nyyxxss = "field27329_"; //年假本年新增时数
	var nyyxxss1 = "field27327_"; //年假本年已休小时
	var nywxxss = "field27545_"; //年假本年未休小时
	var njjy_id = "field27331_"; //年假上年顺延时数
	var njgq_id = "field27333_"; //年假过期时数

	var txjyxxss = "field27330_"; //调休假本年新增时数
	var txjyxxss1 = "field27328_"; //调休假本年已休小时
	var txjwxxss = "field27546_"; //调休假本年未休小时
	var txjy_id = "field27332_"; //调休假上年结转时数
	var txgq_id = "field27334_"; //调休假过期时数

	jQuery("button[name=addbutton0]").live("click", function () {
		var indexnum0 = jQuery("#indexnum0").val();
		for (var index = 0; index < indexnum0; index++) {
			if (jQuery("#" + qjr_code + index).length > 0) {
				//alert("www");
				gvo_bindchange(index);
			}
		}

	});
	jQuery("#indexnum0").bindPropertyChange(function () {
		gvo_countHoliday();
		adoreFunction();
		//alert(111);
	});

	function gvo_countHoliday() {
		var nowRow = parseInt($G("indexnum0").value) - 1;
		gvo_change(qjr_code, nowRow);
		gvo_change(yjqjksrq, nowRow);
		gvo_change(yjqjjsrq, nowRow);
		gvo_change(yjqjkssj, nowRow);
		gvo_change(yjqjjssj, nowRow);
		gvo_change(xjlxbm, nowRow);
	}

	function gvo_change(tmpObj, nowRow) {
		jQuery("#" + tmpObj + nowRow).bindPropertyChange(function () {
			var tmp_qjr_code = "#" + qjr_code + nowRow;
			var tmp_yjqjksrq = "#" + yjqjksrq + nowRow;
			var tmp_yjqjjsrq = "#" + yjqjjsrq + nowRow;
			var tmp_yjqjkssj = "#" + yjqjkssj + nowRow;
			var tmp_yjqjjssj = "#" + yjqjjssj + nowRow;
			var tmp_xjlxbm = "#" + xjlxbm + nowRow;
			var tmp_yjsjxss = "#" + yjsjxss + nowRow;

			get_holi_Times(tmp_qjr_code, tmp_yjqjksrq, tmp_yjqjjsrq, tmp_yjqjkssj, tmp_yjqjjssj, tmp_xjlxbm, tmp_yjsjxss);
		});
	}

	function get_holi_Times(qjr_code, yjqjksrq, yjqjjsrq, yjqjkssj, yjqjjssj, xjlxbm, yjsjxss) {
		var qjr_code_1 = jQuery(qjr_code).val();
		var yjqjksrq1 = jQuery(yjqjksrq).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq).val();
		var yjqjkssj1 = jQuery(yjqjkssj).val();
		var yjqjjssj1 = jQuery(yjqjjssj).val();
		var xjlxbm1 = jQuery(xjlxbm).val();

		if (yjqjksrq1.length > 0 && yjqjjsrq1.length > 0 && yjqjkssj1.length > 0 && yjqjjssj1.length > 0 && xjlxbm1.length > 0) {
			//			alert("进入");
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp", {
				'yjqjksrq': yjqjksrq1,
				'yjqjjsrq': yjqjjsrq1,
				'yjqjkssj': yjqjkssj1,
				'yjqjjssj': yjqjjssj1,
				'xjlxbm': xjlxbm1,
				'qjr_code': qjr_code_1
			}, function (data) {
				//alert(data);
				data = data.replace(/\n/g, "").replace(/\r/g, "");
				eval('var obj =' + data);
				var xss = obj.xss;
				jQuery(yjsjxss).val(xss);
				jQuery(yjsjxss + "span").text(xss);
			});
		}
	}

	function getdetail2(qjr_code, qjr_id, qjr_name) {
		//alert(000001);
		addRow1(1);
		//var nowRow0 = parseInt($G("indexnum0").value) - 1;
		var indexnum1 = jQuery("#indexnum1").val();
		var nowRow1 = parseInt($G("indexnum1").value) - 1;
		//alert("nowRow1=" + nowRow1);
		//var qjr_code_2 = jQuery("#" + qjr_code + nowRow0).val();
		if (qjr_code.length > 0 && qjr_id.length > 0 && qjr_name.length > 0) {
			jQuery.post("/gvo/HRworkflow/getInfo.jsp", {
				"qjr_code": qjr_code
			}, function (data) {
				data = data.replace(/\n/g, "").replace(/\r/g, "");
				//alert(data);
				eval('var obj =' + data);
				var totalValue1 = obj.totalValue1;
				var totalValue2 = obj.totalValue2;
				var userValue1 = obj.userValue1;
				var userValue2 = obj.userValue2;
				var labelVale1 = obj.labelVale1;
				var labelVale2 = obj.labelVale2;


				var forwardVaule1 = obj.forwardVaule1;
				var expiedValue1 = obj.expiedValue1;
				var forwardVaule2 = obj.forwardVaule2;
				var expiedValue2 = obj.expiedValue2;

				jQuery("#" + _workcode + nowRow1).val(qjr_code);
				jQuery("#" + _workcode + nowRow1 + "span").text(qjr_code);

				jQuery("#" + _name + nowRow1).val(qjr_id);
				jQuery("#" + _name + nowRow1 + "span").text(qjr_name);

				jQuery("#" + nyyxxss + nowRow1).val(totalValue1);
				jQuery("#" + nyyxxss + nowRow1 + "span").text(totalValue1);

				jQuery("#" + nyyxxss1 + nowRow1).val(userValue1);
				jQuery("#" + nyyxxss1 + nowRow1 + "span").text(userValue1);

				jQuery("#" + txjyxxss + nowRow1).val(totalValue2);
				jQuery("#" + txjyxxss + nowRow1 + "span").text(totalValue2);

				jQuery("#" + txjyxxss1 + nowRow1).val(userValue2);
				jQuery("#" + txjyxxss1 + nowRow1 + "span").text(userValue2);

				jQuery("#" + njjy_id + nowRow1).val(forwardVaule1);
				jQuery("#" + njjy_id + nowRow1 + "span").text(forwardVaule1);

				jQuery("#" + njgq_id + nowRow1).val(expiedValue1);
				jQuery("#" + njgq_id + nowRow1 + "span").text(expiedValue1);

				jQuery("#" + txjy_id + nowRow1).val(forwardVaule2);
				jQuery("#" + txjy_id + nowRow1 + "span").text(forwardVaule2);

				jQuery("#" + txgq_id + nowRow1).val(expiedValue2);
				jQuery("#" + txgq_id + nowRow1 + "span").text(expiedValue2);

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
				var qjr_code_val = jQuery("#" + qjr_code + ii).val();
				//alert("obj=" + qjr_code_val + "|ii=" + ii);
				if (qjr_code_val.length > 0) {
					//alert("www");
					gvo_bindchange(ii);
				}
			}
		}
	}

	function gvo_bindchange(index) {
		jQuery("#" + qjr_code + index).bindPropertyChange(function () {
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
			if (jQuery("#" + qjr_code + index1).length > 0) {
				var bh_val = jQuery("#" + qjr_code + index1).val();
				var _empid = jQuery("#" + qjr_id + index1).val();
				var _empname = jQuery("#" + qjr_id + index1 + "span").text();
				_empname = _empname.replace("x", "")
					//alert(_empname);
				if (bh_val != '') {
					getdetail2(bh_val, _empid, _empname);
				}
			}
		}
	}
});