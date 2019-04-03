jQuery(document).ready(
	 function() {

	  var sjjbss = "field5864_"; //系统建议时数=个人填写时间计算
	  var ygtxxsh = "field8985_";//员工填写时数
	  var tmp_sjjbss;
	  var tem_ygtxxsh;
   	  //alert(123456);

	  checkCustomize = function() {
		var result = true;
		var nowRow = parseInt($G("indexnum0").value) - 1;
		for (var i = 0; i <= nowRow; i++) {
			tmp_sjjbss = jQuery("#" + sjjbss + i).val();
			//alert("tmp_sjjbss="+tmp_sjjbss);
			tem_ygtxxsh = jQuery("#" + ygtxxsh + i).val();
			//alert("tem_ygtxxsh="+tem_ygtxxsh);
			if (Number(tmp_sjjbss)<Number(tem_ygtxxsh)) {
					window.top.Dialog.alert("员工填写时数有误！");
					result = false;
				}
			}
		return result;
	}
});