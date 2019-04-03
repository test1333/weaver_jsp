var qjksrq = "#field12005"; // 请假开始日期
var qjjsrq = "#field12007";// 请假结束日期
//alert(11111);
jQuery(document).ready(function() {
  checkCustomize = function() {
    var tmp_qjksrq = jQuery(qjksrq).val();
    var tmp_qjjsrq = jQuery(qjjsrq).val();
    //alert("请假开始日期=" + tmp_qjksrq);
    //alert("请假结束日期=" + tmp_qjjsrq);
    var result = true;
    var d1 = new Date(tmp_qjksrq.replace("-", "/"));
    //alert("d1 = " + d1);
    var d2 = new Date(tmp_qjjsrq.replace("-", "/"));
    //alert("d2 = " + d2);
	if (d1 > d2) {
      result = false;
      window.top.Dialog.alert("请假结束日期早于请假开始日期");
    }
    return result;

  }
});