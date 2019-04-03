var ksrqsj = "#field14639"; // 开始日期时间
var jsrqsj = "#field14641";// 结束日期时间
//alert(11111);
jQuery(document).ready(function() {
  checkCustomize = function() {
    var tmp_ksrqsj = jQuery(ksrqsj).val();
    var tmp_jsrqsj = jQuery(jsrqsj).val();
    //alert("开始日期时间=" + tmp_ksrqsj);
    //alert("结束日期时间=" + tmp_jsrqsj);
    var result = true;
    var d1 = new Date(tmp_ksrqsj.replace("-", "/"));
    //alert("d1 = " + d1);
    var d2 = new Date(tmp_jsrqsj.replace("-", "/"));
    //alert("d2 = " + d2);
	if (d1 > d2) {
      result = false;
      window.top.Dialog.alert("结束日期早于开始日期");
    }
    return result;

  }
});