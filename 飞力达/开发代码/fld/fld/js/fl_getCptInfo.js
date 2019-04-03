//js调用接口
jQuery(document).ready(function () {
	//alert("wwww");
	//明细1
	//var qjr_code = "field27310_"; //人员工号
	//var qjr_id = "field27311_"; //人员姓名
	var oadate = "#field11962"; //申请日期
	var useDept = "#field11967"; //使用部门
	var appDept = "#field11969"; //申请部门
	//var amount = "field27318_"; //预计结束开始时间
	var costCenter = "#field13902"; //成本中心
	var costCenter1 = "#field13903"; //责任成本中心

	//明细
	var _cpt = "field13057_"; //物品名称
	var _budget = "field11981_"; //预算信息
	var _cptNumber = "field13941_"; //资产编号

	jQuery("#indexnum0").bindPropertyChange(function () {
		fl_getBudget();
		//adoreFunction();
		//alert(111);
	});

	jQuery(useDept).bindPropertyChange(function () {
		//alert(111);
		get_cost_info(oadate, useDept, costCenter1);
		get_cost_info(oadate, useDept, costCenter);
	});

	//jQuery(appDept).bindPropertyChange(function () {
	//alert(222);
	//	get_cost_info(oadate, appDept, costCenter);
	//});

	function fl_getBudget() {
		var nowRow = parseInt($G("indexnum0").value) - 1;
		//fl_dtChange(_budget, nowRow);
		fl_dtChange(_cptNumber, nowRow);
	}

	function fl_dtChange(tmpObj, nowRow) {
		jQuery("#" + tmpObj + nowRow).bindPropertyChange(function () {
			var tmp_budget = "#" + _budget + nowRow;
			var tmp_cptNumber = "#" + _cptNumber + nowRow;

			get_cpt_info(tmp_cptNumber, oadate, tmp_budget);
		});
	}

	function get_cost_info(oadate, oadept, tempCost) {
		var oadate_val = jQuery(oadate).val();
		var oadept_val = jQuery(oadept).val();
		//alert("oadate_val=" + oadate_val);
		var amount = "0";
		if (oadate.length > 0 && oadate.length > 0) {
			jQuery.post("/feilida/js/cpt/fl_getCptInfoNew.jsp", {
				"OADATE": oadate_val,
				"DEPTID": oadept_val,
				"AMOUNT": amount
			}, function (data) {
				data = data.replace(/\n/g, "").replace(/\r/g, "");
				//alert(data);
				eval('var obj =' + data);
				var KOSTL = obj.KOSTL;
				var MSGTYP = obj.MSGTYP;
				var MSGTXT = obj.MSGTXT;

				if (MSGTYP != 'S') {
					alert(MSGTXT);
					jQuery(tempCost).val("");
					jQuery(tempCost + "span").html("");
				} else {
					jQuery(tempCost).val(KOSTL);
					jQuery(tempCost + "span").html(KOSTL);
				}

			});
		}
	}

	function get_cpt_info(tmp_cptNumber, oadate, tmp_budget) {
		var tmp_cptNumber_val = jQuery(tmp_cptNumber).val();
		var oadate_val = jQuery(oadate).val();
		var useDept_val = jQuery(useDept).val();
		var amount = "0";
		var exectype = "1";
		if (tmp_cptNumber.length > 0 && oadate.length > 0 && useDept_val.length > 0) {
			//			alert("进入");
			jQuery.post("/feilida/js/cpt/fl_getCptInfoNew.jsp", {
				'OADATE': oadate_val,
				'ANLKL': tmp_cptNumber_val,
				'AMOUNT': amount,
				'DEPTID': useDept_val,
				'EXECTYPE': exectype
			}, function (data) {
				data = data.replace(/\n/g, "").replace(/\r/g, "");
				//alert(data);
				eval('var obj =' + data);
				var AMOUNT0 = obj.AMOUNT0;
				var AMOUNT1 = obj.AMOUNT1;
				var AMOUNT2 = obj.AMOUNT2;
				var AMOUNT3 = obj.AMOUNT3;
				var MSGTYP = obj.MSGTYP;
				var MSGTXT = obj.MSGTXT;

				if (MSGTYP != 'S') {
					alert(MSGTXT);
					jQuery(tmp_budget).val("");
					jQuery(tmp_budget + "span").html("");
				} else {
					jQuery(tmp_budget).val(AMOUNT0);
					jQuery(tmp_budget + "span").html(AMOUNT0);
				}
			});
		}
	}
});