var s_emp_1 = "field8361_";
var g_date_1 = "field8195_";
var b_bc = "field8688_";
var j_jblx = "field8825_";
var j_jblxCode = "field8826_";
var sfztx_s = "field17805_";

setTimeout('yourFunction_2()', 1200);
jQuery("#indexnum0").bindPropertyChange(function () {
	get_bc();
});

function yourFunction_2() {
	for (var i = 0; i < 200; i++) {
		// 目标存在
		if (jQuery("#" + sfztx_s + i).length > 0) {
			getBC_be(i);
		}
	}
}

//jQuery(document).ready(function(){




function getBC_be(nowRow) {

	jQuery("input[id='" + s_emp_1 + nowRow + "']").bind("propertychange", function () {
		//	jQuery("#"+s_emp_1+nowRow).bindPropertyChange(function () { 
		// alert("1.1");	
		var tmp_s_emp_1 = "#" + s_emp_1 + nowRow;
		var tmp_g_date_1 = "#" + g_date_1 + nowRow;
		var tmp_b_bc = "#" + b_bc + nowRow;
		var tem_j_jblx = "#" + j_jblx + nowRow;
		var tem_j_jblxCode = "#" + j_jblxCode + nowRow;
		var tem_sfztx_s = "#" + sfztx_s + nowRow;
		//alert(1);
		get_bc(tmp_s_emp_1, tmp_g_date_1, tmp_b_bc, tem_j_jblx, tem_j_jblxCode, tem_sfztx_s);
	});

	jQuery("input[id='" + g_date_1 + nowRow + "']").bind("propertychange", function () {
		//	jQuery("#"+g_date_1+nowRow).bindPropertyChange(function () { 
		//	alert("2.1");	
		var tmp_s_emp_1 = "#" + s_emp_1 + nowRow;
		var tmp_g_date_1 = "#" + g_date_1 + nowRow;
		var tmp_b_bc = "#" + b_bc + nowRow;
		var tem_j_jblx = "#" + j_jblx + nowRow;
		var tem_j_jblxCode = "#" + j_jblxCode + nowRow;
		var tem_sfztx_s = "#" + sfztx_s + nowRow;

		get_bc(tmp_s_emp_1, tmp_g_date_1, tmp_b_bc, tem_j_jblx, tem_j_jblxCode, tem_sfztx_s);
	});

	jQuery("#" + sfztx_s + nowRow).change(function () {
		//	  jQuery("#"+sfztx_s+nowRow).bindPropertyChange(function () { 
		//	alert("3");	
		var tmp_s_emp_1 = "#" + s_emp_1 + nowRow;
		var tmp_g_date_1 = "#" + g_date_1 + nowRow;
		var tmp_b_bc = "#" + b_bc + nowRow;
		var tem_j_jblx = "#" + j_jblx + nowRow;
		var tem_j_jblxCode = "#" + j_jblxCode + nowRow;
		var tem_sfztx_s = "#" + sfztx_s + nowRow;
		get_bc(tmp_s_emp_1, tmp_g_date_1, tmp_b_bc, tem_j_jblx, tem_j_jblxCode, tem_sfztx_s);
	});
}


function getBC() {
	// alert(0);
	var nowRow = parseInt($G("indexnum0").value) - 1;

	jQuery("input[id='" + s_emp_1 + nowRow + "']").bind("propertychange", function () {
		//	jQuery("#"+s_emp_1+nowRow).bindPropertyChange(function () { 
		//alert("1.1");	
		var tmp_s_emp_1 = "#" + s_emp_1 + nowRow;
		var tmp_g_date_1 = "#" + g_date_1 + nowRow;
		var tmp_b_bc = "#" + b_bc + nowRow;
		var tem_j_jblx = "#" + j_jblx + nowRow;
		var tem_j_jblxCode = "#" + j_jblxCode + nowRow;
		var tem_sfztx_s = "#" + sfztx_s + nowRow;
		//alert(1);
		get_bc(tmp_s_emp_1, tmp_g_date_1, tmp_b_bc, tem_j_jblx, tem_j_jblxCode, tem_sfztx_s);
	});

	jQuery("input[id='" + g_date_1 + nowRow + "']").bind("propertychange", function () {
		//	jQuery("#"+g_date_1+nowRow).bindPropertyChange(function () { 	
		var tmp_s_emp_1 = "#" + s_emp_1 + nowRow;
		var tmp_g_date_1 = "#" + g_date_1 + nowRow;
		var tmp_b_bc = "#" + b_bc + nowRow;
		var tem_j_jblx = "#" + j_jblx + nowRow;
		var tem_j_jblxCode = "#" + j_jblxCode + nowRow;
		var tem_sfztx_s = "#" + sfztx_s + nowRow;
		//	alert(2);
		get_bc(tmp_s_emp_1, tmp_g_date_1, tmp_b_bc, tem_j_jblx, tem_j_jblxCode, tem_sfztx_s);
	});

	jQuery("#" + sfztx_s + nowRow).change(function () {
		//	jQuery("#"+sfztx_s+nowRow).bindPropertyChange(function () { 
		var tmp_s_emp_1 = "#" + s_emp_1 + nowRow;
		var tmp_g_date_1 = "#" + g_date_1 + nowRow;
		var tmp_b_bc = "#" + b_bc + nowRow;
		var tem_j_jblx = "#" + j_jblx + nowRow;
		var tem_j_jblxCode = "#" + j_jblxCode + nowRow;
		var tem_sfztx_s = "#" + sfztx_s + nowRow;
		get_bc(tmp_s_emp_1, tmp_g_date_1, tmp_b_bc, tem_j_jblx, tem_j_jblxCode, tem_sfztx_s);
	});
}


function get_bc(s_emp, g_date, b_bc, j_jblx, j_jblxCode, j_sfztx_s) {


	if (jQuery(s_emp).length > 0 && jQuery(g_date).length > 0 && jQuery(j_sfztx_s).length > 0) {
		//    alert(1);
		var emp_s_emp = jQuery(s_emp).val();
		var emp_g_date = jQuery(g_date).val();
		var emp_sfztx_s = jQuery(j_sfztx_s).val();
		// alert("emp_sfztx_s = " + emp_sfztx_s);
		//alert(emp_g_date);
		if (emp_s_emp.length > 0 && emp_g_date.length > 0 && emp_sfztx_s.length > 0) {
			//     alert(2);
			jQuery.post("/gvo/HRworkflow/getJiaBanInfo_1.jsp", {
				'gsrq': emp_g_date,
				'qjr_code': emp_s_emp,
				'sfztx_s': emp_sfztx_s
			}, function (data) {

				data = data.replace(/\n/g, "").replace(/\r/g, "");
				//data = data.replace("(","").replace(")","");
				//alert(data);
				eval('var obj =' + data);
				var ClassName = obj.ClassName;
				var OTTypeName = obj.OTTypeName;
				var OTTypeCode = obj.OTTypeCode;

				jQuery(b_bc).val(ClassName);
				jQuery(b_bc + "span").html(ClassName);
				jQuery(j_jblx).val(OTTypeName);
				jQuery(j_jblx + "span").html(OTTypeName);
				jQuery(j_jblxCode).val(OTTypeCode);
				jQuery(j_jblxCode + "span").html(OTTypeCode);
			});
		}
	}
}
//});