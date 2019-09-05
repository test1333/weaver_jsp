<script type="text/javascript">
jQuery(document).ready(function () {
    var qjlx = '#field16106' //请假类型
    var qjxx = '#field16205' //请假信息
    var sqr = '#field16038'//申请人
    var qjts = '#field16052' //请假天数
    var qjxss = '#field16400' //请假小时数
    var qjxssyc = '#field16052' //请假小时数隐藏字段
    var leaveMonth = "#field16516";//跨越辅助字段
    var startData = "#field16045";//请假开始日期
    var endData = "#field16047";//请假结束日期
    var shnnjs = "#field16604";//剩余年假天数
	var qjlxnew = '#field16389' //请假类型(新)
	var hj = '#field16051';//本月已申请
	 var startTime = "#field16046";
	var endTime = "#field16048"; 
	getQjxs();
	//alert(111);
	jQuery(startData).bindPropertyChange(function () {
		//alert(111);
		getQjxs();
	})
	jQuery(endData).bindPropertyChange(function () {
		
		getQjxs();
	})
	jQuery(qjlxnew).bindPropertyChange(function () {
		
		getQjxs();
	})
	jQuery(sqr).bindPropertyChange(function () {
		
		getQjxs();
	})
    jQuery(qjxssyc).bindPropertyChange(function () {
        //请假天数字段赋值
        jQuery(qjxss).val(conversionTime(jQuery(qjxssyc).val()));
        jQuery(qjxss+"span").html(conversionTime(jQuery(qjxssyc).val()));
	});

    checkCustomize = function () {
        var sqr_v = jQuery(sqr).val();
        var qjlx_v = jQuery(qjlx).val();
        var qjxx_v = jQuery(qjxx).val();
        var qjts_v = jQuery(qjts).val();
        var qjxssValue = jQuery(qjxss).val();
		var qjlxnewValue = jQuery(qjlxnew).val();
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
        //年假校验
		if(qjlxnewValue === '2'){
			if(Number(jQuery(shnnjs).val()) < Number(jQuery(qjxss).val())){
				alert("温馨提示:年休假剩余天数为"+Number(jQuery(shnnjs).val())+"天");
				return false;
			}
		}
		
		//婚假
		if(qjlxnewValue === '3'){
			if(qjxssValue > 10){
				alert("温馨提示:婚假天数最多请10天");
				return false;
			}
		}
		//产假
		if(qjlxnewValue === '4'){
			if(qjxssValue > 98){
				alert("温馨提示:产假天数最多请98天");
				return false;
			}
		}
		//生育假
		if(qjlxnewValue === '8'){
			if(qjxssValue > 30){
				alert("温馨提示:生育假天数最多请30天");
				return false;
			}
		}
		//陪产假
		if(qjlxnewValue === '7'){
			if(qjxssValue > 10){
				alert("温馨提示:陪产假天数最多请10天");
				return false;
			}
		}
		//丧家
		if(qjlxnewValue === '6'){
			if(qjxssValue > 3){
				alert("温馨提示:丧假天数最多请3天");
				return false;
			}
		}
       
	  
		
        //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            alert("温馨提示：请假申请流程开始日期不能晚于 2019-06-01");
            return false;
        }
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            alert("温馨提示：请假申请流程结束日期不能晚于 2019-06-01");
            return false;
        }
        
        if(!isFiveMutiple(qjxssValue)){
            Dialog.alert("请假天数以0.5天为单位！");
            return false;
        }   
        if(qjlx_v==-13||qjlx_v==27){
            Dialog.alert("调休和事假请走调休申请流程");
            return false;
        }

        //请假跨月计算
        if(jQuery(leaveMonth).val()>0){
            alert("温馨提示：该请假类型不能跨月申请。");
            return false;
        }

        return true;
    }
	
	function getQjxs(){
		//alert(222);
		var ksrq_v = jQuery(startData).val();
		var jsrq_v = jQuery(endData).val();
		var sqr_v = jQuery(sqr).val();
		var qjlx_v = jQuery(qjlxnew).val();
		//alert(jssj_v);
		var a = {
			url: "/TaiSon/jsp/getQjsq.jsp?sqr="+sqr_v
			+"&qjlx="+qjlx_v+"&ksrq="+ksrq_v+"&jsrq="+jsrq_v, // 参数p_segment_no为明细表1当前行的[分部编码]字段
			type: 'get',
			// 定义请求完成时的回调函数
			success: function (d) {
				//alert("data="+d);
				var text = d.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
				var text_arr = text.split("@@@");				
				//alert(text_arr);
				jQuery(leaveMonth).val(text_arr[2]);
				jQuery(shnnjs).val(text_arr[1]);
				jQuery(hj).val(text_arr[0]);
			}
		};
		// top.Dialog.//alert(a.url);
		// 发送请求
		jQuery.ajax(a);
	}
	
})

function isFiveMutiple(number){
    var isTen=number%0.5;
    if(isTen==0){
        return true;
    }else{
        return false;
    }
}

//转换请假小时
function conversionTime(time){
    return Math.ceil(time/0.5)*5*0.1;
}

//日期校验函数
function getDetailDate(setDate){
    var date=new Date(setDate);
    var year=date.getFullYear(); 
    var month=date.getMonth()+1;
    var day=date.getDate();
    month =(month<10 ? "0"+month:month);
    day =(day<10 ? "0"+day:day);

    var newDate  =year.toString()+month.toString()+day.toString()

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






