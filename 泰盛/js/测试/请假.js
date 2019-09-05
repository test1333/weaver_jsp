<script type="text/javascript">
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
    var cjlsjl = "#field16593";//请假历史记录
    var startTime = "#field16046";
	var endTime = "#field16048";   
    var qjStarttTime = "#field16808";//请假开始时间 下拉框
    var qjEndtTime = "#field16809";//请假结束时间  下拉框
    
    var tjsjkz = "#field16826"; //提交时间控制
    
    
    jQuery(document).ready(function () {
        jQuery(qjxssyc).bindPropertyChange(function () {
        
jQuery( "#field16808").change(function(){
setInterval(setLeaveDays,500)
});
  jQuery( "#field16809").change(function(){
setInterval(setLeaveDays,500)
});



            //请假天数字段赋值
            jQuery(qjxss).val(conversionTime(jQuery(qjxssyc).val()));
            jQuery(qjxss+"span").html(conversionTime(jQuery(qjxssyc).val()));
            
        });
        
        //请假开始时间
        jQuery(qjStarttTime).bindPropertyChange(function(){
            setLeaveDays();
        })
        //请假结束时间
        jQuery(qjEndtTime).bindPropertyChange(function(){
            setLeaveDays();
        })
        
    
    
    
        //请假类型
        jQuery(qjlxnew).bindPropertyChange(function(){
            isShowHideVacation();
        })

        setTimeout('isShowHideVacation()','500');//延迟加载
WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){  
var flag = "1";
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
            
            if(jQuery(tjsjkz).val() >0){
                window.Dialog.alert("温馨提示：请假开始日期只能选择本月及本月之后日期");
                flag = "0";
				return;
            }
            if(startData_val != "" && endData_val != ""&&startTime_val != "" && endTime_val != ""){
                if(tab((startData_val+" "+startTime_val),(endData_val+" "+endTime_val))=='1'){
                    window.Dialog.alert("温馨提示:请假结束时间不能小于请假开始时间");
                   flag = "0";
				   return;
                }
            }

            //年假校验
            if(qjlxnewValue === '2'){
                if(Number(jQuery(shnnjs).val()) < Number(jQuery(qjxss).val())){
                    window.Dialog.alert("温馨提示:年休假剩余天数为"+Number(jQuery(shnnjs).val())+"天");
                   flag = "0";
				   return;
                }
            }
            
            //婚假
            if(qjlxnewValue === '3'){
                if(qjxssValue > 10){
                    window.Dialog.alert("温馨提示:婚假天数最多请10天");
                   flag = "0";
				   return;
                }
            }
            //产假
            if(qjlxnewValue === '4'){
                if(qjxssValue > 98){
                    window.Dialog.alert("温馨提示:产假天数最多请98天");
                    flag = "0";
					return;
                }
            }
            //生育假
            if(qjlxnewValue === '8'){
                if(qjxssValue > 30){
                    window.Dialog.alert("温馨提示:生育假天数最多请30天");
                   flag = "0";
				   return;
                }
            }
            //陪产假
            if(qjlxnewValue === '7'){
                if(qjxssValue > 10){
                    window.Dialog.alert("温馨提示:陪产假天数最多请10天");
                    flag = "0";
					return;
                }
            }
            //丧家
            if(qjlxnewValue === '6'){
                if(qjxssValue > 3){
                    window.Dialog.alert("温馨提示:丧假天数最多请3天");
                   flag = "0";
				   return;
                }
            }
           
          
            
            //开始日期校验
            if(getDetailDate(jQuery(startData).val())){
                window.Dialog.alert("温馨提示：请假申请流程开始日期不能晚于 2019-06-01");
               flag = "0";
			   return;
            }
            //结束日期校验
            if(getDetailDate(jQuery(endData).val())){
                window.Dialog.alert("温馨提示：请假申请流程结束日期不能晚于 2019-06-01");
               flag = "0";
			   return;
            }
            
            if(!isFiveMutiple(qjxssValue)){
                Dialog.alert("请假天数以0.5天为单位！");
               flag = "0";
			   return;
            }   
            if(qjlx_v==-13||qjlx_v==27){
                Dialog.alert("调休和事假请走调休申请流程");
               flag = "0";
			   return;
            }

            //请假跨月计算
            if(jQuery(leaveMonth).val()>0){
                window.Dialog.alert("温馨提示：该请假类型不能跨月申请。");
                flag = "0";
				return;
            }

            if(flag == "1"){
				callback();
			}	
         });
})
    //时间判断
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
        var integrValue = parseInt((time*8)/8);
        var decimalValue = ((time*8)%8*0.1).toFixed(2);
        if(decimalValue<= 0.4 && decimalValue> 0.00 ){
            decimalValue= 0.5
        }else if (decimalValue >0.4){
            decimalValue = 1;
        }else if(decimalValue == 0.00){
            decimalValue = 0;
        }

        return integrValue+decimalValue
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
    
    //历史假期按钮显示隐藏
    function  isShowHideVacation(){
        var qjlxnewValue = jQuery(qjlxnew).val();
        if(qjlxnewValue =='3' || qjlxnewValue =='6' || qjlxnewValue === '7' || qjlxnewValue == '8' || qjlxnewValue === '4'  || qjlxnewValue === '1'){
            jQuery(cjlsjl+"span").show();
        }else {
            jQuery(cjlsjl+"span").hide();
        }
    }
    
    //弹出框色设置
    function showDialog(){
        var title = "历史假期明细";
        var url = "/TaiSon/attendance/maternityleaveURL.jsp?sqr="+jQuery("#field16038").val()+"&qjlx="+jQuery(qjlxnew).val();
        var diag_vote = new window.top.Dialog();
        diag_vote.currentWindow = window;
        diag_vote.Width = 700;
        diag_vote.Height = 650;
        diag_vote.Modal = true;
        diag_vote.Title = title;
        diag_vote.URL = url;
        diag_vote.isIframe=false;
        diag_vote.show();
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
















