<script type="text/javascript">
var overtimeType = "#field16002";//加班类型
var overtimehours = "#field16258";//加班小时数 
var overtimeTypehide = "#field16324";//加班类型辅助字段
var startData = "#field15992";//加班开始日期
var endData = "#field15994";//加班结束日期
var startTime = "#field15993";
var endTime = "#field15995"; 
var rqjyyc = "#field16824";//日期校验  
jQuery(document).ready(function(){
jQuery(overtimehours).attr('readonly','readonly');
    //加班类型辅助字段
    jQuery(overtimeTypehide).bindPropertyChange(function(){
        overtimeChange();
    })

    setTimeout('overtimeChange()','500');

    //提交校验
    WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){  
		var flag = "1";
		 var startData_val = jQuery(startData).val();
		var endData_val = jQuery(endData).val();
		 var startTime_val = jQuery(startTime).val();
		var endTime_val = jQuery(endTime).val();
        
        if(jQuery(rqjyyc).val() >0){
            window.Dialog.alert("温馨提示：加班日期只能选择本月及本月之后日期");
            flag = "0";
			return;
        }
		if(startData_val != "" && endData_val != ""&&startTime_val != "" && endTime_val != ""){
			if(tab((endData_val+" "+endTime_val),(startData_val+" "+startTime_val))=='0'){
				window.Dialog.alert("温馨提示:加班结束时间不能小于加班开始时间");
				flag = "0";
				return;
			}
		}
        //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            window.Dialog.alert("温馨提示：加班申请单开始日期不能晚于 2019-06-01");
            flag = "0";
			return;
        }
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            window.Dialog.alert("温馨提示：加班申请单结束日期不能晚于 2019-06-01");
            flag = "0";
			return;
        }
        //加班类型
        if(jQuery(overtimeType).val() === ""){
            window.Dialog.alert("温馨提示：抱歉，您的加班日期选择有误。");
            flag = "0";
			return;
        }
        //加班时常
        if(jQuery(overtimehours).val() <2){
            window.Dialog.alert("温馨提示：按公司规定，加班申请时长须大于2小时。");
            flag = "0";
			return;
        }
       
        if(flag == "1"){
			callback();
		}	
      });
});

//overtimeChange
function overtimeChange(){
    jQuery(overtimeType).empty();
    var overtimeTypeValue = jQuery(overtimeTypehide).val();
    if (overtimeTypeValue === '0'){
        jQuery(overtimeType).append("<option value='0'>周末加班</option>")
    }else if (overtimeTypeValue === '1'){
        jQuery(overtimeType).append("<option value='1'>法定节假日加班</option>")
    }else{
        jQuery(overtimeType).append("<option value=''></option>")
    }
}
//日期校验函数
function getDetailDate(setDate){

    var datenew = setDate.replace(/-/g, '/');
    var date=new Date(datenew)
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




