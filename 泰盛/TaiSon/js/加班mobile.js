


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

var overtimeType = "#field16002";//加班类型
var overtimehours = "#field16258";//加班小时数 
var overtimeTypehide = "#field16324";//加班类型辅助字段
var startData = "#field15992";//加班开始日期
var endData = "#field15994";//加班结束日期
var kssj = '#field15993';//加班开始时间
var jssj = '#field15995';//加班结束时间
var startTime = "#field15993";
var endTime = "#field15995"; 
jQuery(document).ready(function(){
	jQuery(overtimehours).attr('readonly','readonly'); 
	getJbxs();
	//alert(111);
	jQuery(startData).bindPropertyChange(function () {
		//alert(111);
		getJbxs();
	})
	jQuery(endData).bindPropertyChange(function () {
		
		getJbxs();
	})
	jQuery(kssj).bindPropertyChange(function () {
		
		getJbxs();
	})
	jQuery(jssj).bindPropertyChange(function () {
		
		getJbxs();
	})
    //加班类型辅助字段
    jQuery(overtimeTypehide).bindPropertyChange(function(){
        overtimeChange();
    })

    setTimeout('overtimeChange()','500');

    //提交校验
    checkCustomize = function(){
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
         //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            alert("温馨提示：加班申请单开始日期不能晚于 2019-06-01");
            return false;
        }
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            alert("温馨提示：加班申请单结束日期不能晚于 2019-06-01");
            return false;
        }
        //加班类型
        if(jQuery(overtimeType).val() === ""){
            alert("温馨提示：您申果流程中加班起始日期或者加班结束日期等于工作时间，则流程无法提交。");
            return false;
        }
        //加班时常
        if(jQuery(overtimehours).val() <2){
            alert("温馨提示：按公司规定，加班申请时长须大于2小时。");
            return false;
        }
       
        return true;  
    }
});

function getJbxs(){
		//alert(222);
		var ksrq_v = jQuery(startData).val();
		var jsrq_v = jQuery(endData).val();
		var kssj_v = jQuery(kssj).val();
		var jssj_v = jQuery(jssj).val();
		//alert(jssj_v);
		var a = {
            url: "/TaiSon/jsp/getJbsq.jsp?ksrq="+ksrq_v
			+"&jsrq="+jsrq_v+"&kssj="+kssj_v+"&jssj="+jssj_v, // 参数p_segment_no为明细表1当前行的[分部编码]字段
            type: 'get',
            // 定义请求完成时的回调函数
            success: function (d) {
                //alert("data="+d);
				var text = d.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
				var text_arr = text.split("@@@");				
				//alert(text_arr);
			
				jQuery(overtimeTypehide).val(text_arr[1]);
				jQuery(overtimeType).val(text_arr[1]);
				jQuery(overtimehours).val(text_arr[0]);
            }
        };
        // top.Dialog.//alert(a.url);
        // 发送请求
        jQuery.ajax(a);
	}


//overtimeChange
function overtimeChange(){
	//alert(0);
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










