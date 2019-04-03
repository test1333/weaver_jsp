//alert("测试！");

jQuery(document).ready(function() {
	var arrengedStaff = "#field5794"; //安排人员
    //var isRepeat = "#field5906"; //是否重复
    var startDate = "#field5795"; //开始日期
    var endDate = "#field5796"; //结束日期

	checkCustomize = function() {

		var arrengedStaff_val = jQuery(arrengedStaff).val();
        var startDate_val = jQuery(startDate).val();
        var endDate_val = jQuery(endDate).val();
        //alert("arrengedStaff_val="+arrengedStaff_val);
		var result = true;
		var v_num = 0;
		if (arrengedStaff_val.length > 0 && startDate_val.length > 0 &&endDate_val.length>0) {

		   $.ajaxSettings.async = false;//同步传值
	       jQuery.post("/seahonor/js/replace.jsp", {
		         'arrengedStaff' : arrengedStaff_val,
		         'startDate' : startDate_val,
		         'endDate' : endDate_val
	       }, function(data) {
		              //alert("data="+data);
		              data = data.replace(/\n/g, "").replace(/\r/g, "");
		              eval('var obj =' + data);
		              v_num = obj.v_num.split(",");
		              //alert("v_num = " + v_num);
	          });
	      }
	    //alert("v_num = " + v_num);
		if (v_num > 0) {
			result = false;
			alert("外出日期重复,请重新填写！");
		}
		return result;
	}

});
