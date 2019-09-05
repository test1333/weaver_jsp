<script type="text/javascript">
var leaveType = "#field16284";//请假类型
var breakOffDays = "#field16388";//剩余调休天数
var annualLeaveDays = "#field16292";//剩余年假天数
var startData = "#field16272";//请假开始日期
var endData = "#field16274";//请假结束日期
var startTime = "#field16273";
var endTime = "#field16275"; 
jQuery(document).ready(function () {

    //提交校验
    checkCustomize = function(){ 
        var leaveTypeValue = jQuery(leaveType).val(); //请假类型
        var breakOffDaysValue = jQuery(breakOffDays).val();//剩余调休天数
        var annualLeaveDaysValue = jQuery(annualLeaveDays).val();//剩余年假天数
        
        if(breakOffDaysValue === ''){
            breakOffDaysValue = '0';
        }
        if(annualLeaveDaysValue === ''){
            annualLeaveDaysValue = '0';
        }
        var startData_val = jQuery(startData).val();
		var endData_val = jQuery(endData).val();
		 var startTime_val = jQuery(startTime).val();
		var endTime_val = jQuery(endTime).val();
		if(startData_val != "" && endData_val != ""&&startTime_val != "" && endTime_val != ""){
			if(tab((endData_val+" "+endTime_val),(startData_val+" "+startTime_val))=='0'){
				window.Dialog.alert("温馨提示:请假结束时间不能小于请假开始时间");
				return false;
			}
		}
        //调休
        if (leaveTypeValue === '-13'){
            if (annualLeaveDaysValue > 0.00){
                window.Dialog.alert("温馨提示:请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天）");
                return false;
            }
        }
        //事假
        if(leaveTypeValue === '27'){
            if(annualLeaveDaysValue > 0){
                if(breakOffDaysValue === '0'){
                    window.Dialog.alert("温馨提示：请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天），调休假剩余天数为（"+breakOffDaysValue+"小时）");
                    return false;
                }
            }
            if(annualLeaveDaysValue === '0'){
                if(breakOffDaysValue > '0'){
                    window.Dialog.alert("温馨提示：请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天），调休假剩余天数为（"+breakOffDaysValue+"小时）");
                    return false;
                }
            }
            if(annualLeaveDaysValue > 0){
                if(breakOffDaysValue > '0'){
                    window.Dialog.alert("温馨提示：请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天），调休假剩余天数为（"+breakOffDaysValue+"小时）");
                    return false;
                }
            }
        }

        //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            window.Dialog.alert("温馨提示：调休申请流程开始日期不能晚于 2019-06-01");
            return false;
        }
        
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            window.Dialog.alert("温馨提示：调休申请流程结束日期不能晚于 2019-06-01");
            return false;
        }
        
        return true;
    }

//日期校验函数
function getDetailDate(setDate){
    var date=new Date(setDate);
    var year=date.getFullYear(); 
    var month=date.getMonth()+1;
    var day=date.getDate();
    month =(month<10 ? "0"+month:month);
    day =(day<10 ? "0"+day:day);

    var newDate  = year.toString()+month.toString()+day.toString();

    if(newDate > '20190531'){
        return false;
    }else{
        return true;
    }
}

})
function tab(date1,date2){
		var oDate1 = new Date(date1.replace(/-/g, "/"));
		var oDate2 = new Date(date2.replace(/-/g, "/"));
		if(oDate1.getTime() < oDate2.getTime()){
			return "0";
		} else {
			return "1";
		}
	}

</script>






