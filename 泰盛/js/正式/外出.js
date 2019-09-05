<script type="text/javascript">
var startData = "#field16244";//外出开始日期
var endData = "#field16246";//外出结束日期
var tjsjkz = "#field16906";//提交时间控制

jQuery(document).ready(function(){  
    jQuery('#field16246browser').attr('disabled','disabled');
    //流程提交校验
    checkCustomize = function () {
        
         //提交时间控制
        if(jQuery(tjsjkz).val()>0){
            window.Dialog.alert("温馨提示：外出开始日期只能选择本月及本月之后日期");
            return false; 
        }
        
        //开始日期校验
        if(getDetailDate(jQuery(startData).val())){
            window.Dialog.alert("温馨提示：外出申请单开始日期不能晚于 2019-06-01");
            return false;
        }
        //结束日期校验
        if(getDetailDate(jQuery(endData).val())){
            window.Dialog.alert("温馨提示：外出申请单结束日期不能晚于 2019-06-01");
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

    var newDate  = year.toString()+month.toString()+day.toString();

    if(newDate > '20190531'){
        return false;
    }else{
        return true;
    }
}

</script>






