
<script type="text/javascript">
var startData = "#field16248";//出差开始日期
var endData = "#field16250";//出差结日期 
var startTime = "#field16249";
var endTime = "#field16251";   
var tjjysj = "#field16827";  //提交校验时间 
jQuery(document).ready(function(){  
    
    //流程提交校验
    WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){  
	var flag = "1";
        var startData_val = jQuery(startData).val();
		var endData_val = jQuery(endData).val();
		 var startTime_val = jQuery(startTime).val();
		var endTime_val = jQuery(endTime).val();
        
        if(jQuery(tjjysj).val() >0 ){
            window.Dialog.alert("温馨提示：出差开始日期只能选择本月及本月之后日期");
            flag = "0";
			return;
        }
        
		if(startData_val != "" && endData_val != ""&&startTime_val != "" && endTime_val != ""){
			if(tab((startData_val+" "+startTime_val),(endData_val+" "+endTime_val))=='1'){
				window.Dialog.alert("温馨提示:出差结束时间不能小于出差开始时间");
				 flag = "0";
				 return;
			}
		}    
        //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            window.Dialog.alert("温馨提示：出差流程开始日期不能晚于 2019-06-01");
             flag = "0";
			 return;
        }
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            window.Dialog.alert("温馨提示：出差流程结束日期不能晚于 2019-06-01");
             flag = "0";
			 return;
        }
        
        if(flag == "1"){
			callback();
		}	
      });
});

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









