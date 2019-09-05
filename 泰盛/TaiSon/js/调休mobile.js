
<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<head>

<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
</head>





<script type="text/javascript">
window.cardCollapse = function() {
    $('tr.wea-zd-start').click(function() {
      var $start = $(this);
      var $end = $start.next();
      while ($end.attr('class') != 'wea-zd-end') {
        $end.toggle();
        $end = $end.next();
      }
    })
  }
var leaveType = "#field16284";//请假类型
var breakOffDays = "#field16388";//剩余调休天数
var annualLeaveDays = "#field16292";//剩余年假天数
var startData = "#field16272";//请假开始日期
var endData = "#field16274";//请假结束日期
var sqr = '#field16265';//申请人
var byyqjts = '#field16278';//本月已请假天数
var startTime = "#field16273";
var endTime = "#field16275"; 
jQuery(document).ready(function () {
	getTxts();
	//alert(111);
	jQuery(sqr).bindPropertyChange(function () {
		
		getTxts();
	})
	jQuery(leaveType).bindPropertyChange(function () {
		
		getTxts();
	})
    //提交校验
	var checkCustomizeOld = checkCustomize;
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
				alert("温馨提示:请假结束时间不能小于请假开始时间");
				return false;
			}
		}
        //调休
        if (leaveTypeValue === '-13'){
            if (annualLeaveDaysValue > 0.00){
                alert("温馨提示:请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天）");
                return false;
            }
        }
        //事假
        if(leaveTypeValue === '27'){
            if(annualLeaveDaysValue > 0){
                if(breakOffDaysValue === '0'){
                    alert("温馨提示：请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天），调休假剩余天数为（"+breakOffDaysValue+"小时）");
                    return false;
                }
            }
            if(annualLeaveDaysValue === '0'){
                if(breakOffDaysValue > '0'){
                    alert("温馨提示：请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天），调休假剩余天数为（"+breakOffDaysValue+"小时）");
                    return false;
                }
            }
            if(annualLeaveDaysValue > 0){
                if(breakOffDaysValue > '0'){
                    alert("温馨提示：请优先使用年休假，年休假剩余天数为（"+annualLeaveDaysValue+"天），调休假剩余天数为（"+breakOffDaysValue+"小时）");
                    return false;
                }
            }
        }

        //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            alert("温馨提示：调休申请流程开始日期不能晚于 2019-06-01");
            return false;
        }
        
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            alert("温馨提示：调休申请流程结束日期不能晚于 2019-06-01");
            return false;
        }
        
        return checkCustomizeOld();
    }
	function getTxts(){
		//alert(222);
		var sqr_v = jQuery(sqr).val();
		var leaveType_v = jQuery(leaveType).val();
		//alert(sqr_v);
		var a = {
            url: "/TaiSon/jsp/getTxsq.jsp?sqr="+sqr_v
			+"&qjlx="+leaveType_v, // 参数p_segment_no为明细表1当前行的[分部编码]字段
            type: 'get',
            // 定义请求完成时的回调函数
            success: function (d) {
                //alert("data="+d);
				var text = d.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
				var text_arr = text.split("@@@");				
				//alert(text_arr);
				var breakOffDays = "#field16388";//剩余调休天数
				var annualLeaveDays = "#field16292";//剩余年假天数
				jQuery(breakOffDays).val(text_arr[2]);
				jQuery(annualLeaveDays).val(text_arr[1]);
				jQuery(byyqjts).val(text_arr[0]);
            }
        };
        // top.Dialog.//alert(a.url);
        // 发送请求
        jQuery.ajax(a);
	}

//日期校验函数
function getDetailDate(setDate){
    var date=new Date(setDate);
    var year=date.getFullYear(); 
    var month=date.getMonth()+1;
    var day=date.getDate();
    month =(month<10 ? "0"+month:month);
    day =(day<10 ? "0"+day:day);

    var newDate  = year+month+day

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

$(document).ready(function(){
  $(".Inputstyle").css('width','100%');
 cardCollapse();
});

window.onload = function(){
  $(".Inputstyle").css('width','100%');
}

</script>

<style>

body{
 background:#f3f3f3
}

.Inputstyle{
  border:none;
   text-align:right !important;

 
}
.excelMainTable textarea{
 width:100%;
}

input.InputStyle, input.Inputstyle, input.inputStyle, input.inputstyle,.excelMainTable input[type="text"],.excelMainTable input[type="password"], .e8_innerShowContent,.excelMainTable textarea, .sbHolder{

  border:none;
  width: 100%!important;


}

input.InputStyle, input.Inputstyle, input.inputStyle, input.inputstyle, .excelMainTable input[type="text"], .excelMainTable input[type="password"], .e8_innerShowContent, .excelMainTable textarea, .sbHolder{
  text-align: right !important;

}
.excelMainTable{
width: 100% !important;
}
 .form_out_content{
 margin: 0px !important;
}


/*圆角样式*/

td{
 padding:0px;
}
.ysyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-right-radius:9px;
}
.zxyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-left-radius:9px;
}
.yxyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-bottom-right-radius:9px;
}
.zsyj{
  height:100%;
  width:100%;
  background:#ffffff!important;
  border: 1px solid #ffffff!important;
  border-top-left-radius:9px;
}


</style>





