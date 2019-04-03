var workflowstatus = "#field11175";
var orderstatus = "#field11184";
var dis_orderstatus = "#disffield11184";


 // 主表下拉框值改变，也是重新判断的
jQuery(workflowstatus).bind("change",function(){ 	
	cal_check();
});

function cal_check(){
	var tmp_1= jQuery(workflowstatus).val();
	if(tmp_1 == "2"){
		jQuery(orderstatus +"span").html("删除");
		jQuery(orderstatus).val(40);
	}else{
		jQuery(orderstatus +"span").html("审批中");
		jQuery(orderstatus).val(20);
	}
}
