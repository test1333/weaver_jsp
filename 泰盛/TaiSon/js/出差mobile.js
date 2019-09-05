
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
var startData = "#field16248";//出差开始日期
var endData = "#field16250";//出差结日期 
var startTime = "#field16249";
var endTime = "#field16251"; 
jQuery(document).ready(function(){  
     
    //流程提交校验
    checkCustomize = function () {
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
        console.log(jQuery("#indexnum0").val());
        console.log(getDetailDate(jQuery(startData).val()));
            
        //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            window.Dialog.alert("温馨提示：出差流程开始日期不能晚于 2019-06-01");
            return false;
        }
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            window.Dialog.alert("温馨提示：出差流程结束日期不能晚于 2019-06-01");
            return false;
        }
        
        return true;

    }
});

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



