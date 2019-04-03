//jQuery(document).ready(function () {
//明细1
var qjr_code = "field27310_"; //人员工号
var qjr_id = "field27311_"; //人员姓名
var yjqjksrq = "field27315_"; //实际请假开始日期
var yjqjjsrq = "field27319_"; //实际请假结束日期
var yjqjkssj = "field27316_"; //实际请假开始时间
var yjqjjssj = "field27320_"; //实际结束开始时间
var xjlxbm = "field27312_"; //休假类型编码
var yjsjxss = "field27322_"; //实际休假小时数

setTimeout('gvo_countHoliday()', 1200);

function gvo_countHoliday() {
	//alert(111);
	var nowRow = parseInt($G("indexnum0").value) - 1;
	//alert("nowRow=" + nowRow);
	gvo_change(qjr_code, nowRow);
	gvo_change(yjqjksrq, nowRow);
	gvo_change(yjqjjsrq, nowRow);
	gvo_change(yjqjkssj, nowRow);
	gvo_change(yjqjjssj, nowRow);
	gvo_change(xjlxbm, nowRow);
}

function gvo_change(tmpObj, nowRow) {
	jQuery("#" + tmpObj + nowRow).bindPropertyChange(function () {
		//alert(222)
		var tmp_qjr_code = "#" + qjr_code + nowRow;
		var tmp_yjqjksrq = "#" + yjqjksrq + nowRow;
		var tmp_yjqjjsrq = "#" + yjqjjsrq + nowRow;
		var tmp_yjqjkssj = "#" + yjqjkssj + nowRow;
		var tmp_yjqjjssj = "#" + yjqjjssj + nowRow;
		var tmp_xjlxbm = "#" + xjlxbm + nowRow;
		var tmp_yjsjxss = "#" + yjsjxss + nowRow;
		//alert("tmp_yjqjksrq=" + tmp_yjqjksrq);

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
//});