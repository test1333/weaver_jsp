//alert("测试！");
var leftdays = "#field5929"; //剩余天数
var leaveStartDate = "#field5930"; //请假开始日期
var leaveStartTime = "#field5946"; //开始时间
var leaveEndDate = "#field5931"; //请假结束日期
var leaveEndTime = "#field5947"; //结束时间
var leavehours = "#field5943"; //请假小时数


jQuery(document).ready(function() {
	var leftdays_val = jQuery(leftdays).val();
	var leaveStartDate_val = jQuery(leaveStartDate).val();
	var leaveStartTime_val = jQuery(leaveStartTime).val();
	var leaveEndDate_val = jQuery(leaveEndDate).val();
	var leaveEndTime_val = jQuery(leaveEndTime).val();
	var leavehours_val = jQuery(leavehours).val();

	checkCustomize = function() {

		var result = true;

		if ((leaveStartDate_val>leaveEndDate_val)||((leaveStartDate_val==leaveEndDate_val)&&Number(leaveStartTime_val)>Number(leaveEndTime_val))||(Number(leavehours_val)/8)>Number(leftdays_val)) {
			result = false;
			alert("请假时间填写有误,请重新填写！");
		}
		return result;
	}

});


// 计算两个日期的间隔天数  
function DateDiff(sDate1, sDate2){ //sDate1和sDate2是2002-12-18格式   
    var aDate, oDate1, oDate2, iDays   
        aDate = sDate1.split("-")   
        oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]) //转换为12-18-2002格式   
        aDate = sDate2.split("-")   
        oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])   
        iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 /24) //把相差的毫秒数转换为天数   
    return iDays   
} 