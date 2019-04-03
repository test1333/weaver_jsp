jQuery(document).ready(function() {
	//alert("1111");

	var ReportCN = "#field7305"; //中文报告
	var ReportEN = "#field7306"; //英文报告
	var ReportJN = "#field7307"; //日文报告

	checkCustomize = function() {
		var result = true;
		//alert("1111");
		//var ReportCN_val= jQuery(ReportCN).val();
	//	var ReportEN_val=document.getElementsById(ReportEN);
	//	var ReportJN_val=document.getElementsByName(ReportJN);
		//var ReportCN_val = document.all(ReportCN)[0].checked;

		var ReportCN_val= jQuery(ReportCN).is(':checked');
		var ReportEN_val= jQuery(ReportEN).is(':checked');
		var ReportJN_val= jQuery(ReportJN).is(':checked');
		//其中ReportCN_val的值是：选中了就true，没有选中就是false

		/*var ReportEN_val = jQuery(ReportEN).val();
		var ReportJN_val = jQuery(ReportJN).val();*/

		/*alert("ReportCN_val="+ReportCN_val);
		//alert("ReportCN_val.length="+jQuery(ReportCN).is(':checked'));
		alert("ReportEN_val="+ReportEN_val);
		alert("ReportJN_val="+ReportJN_val);*/		

		if(!ReportCN_val&&!ReportEN_val&&!ReportEN_val){
			    result = false;
				alert("报告修改版本不能为空！！！");
			}

		return result;
	}
});
