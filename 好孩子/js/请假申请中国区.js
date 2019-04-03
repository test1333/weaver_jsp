<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  var sqrq="#field8730";//申请日期
	var degzr="#field10991";//第二工作日
	var syrq="#field10992";//上月日期
	
	var jbksrq="#field8739";
	var jbjsrq="#field8741";
	
	 jQuery(document).ready(function(){
	checkCustomize = function () {
		
	   var sqrq_val=jQuery(sqrq).val();
		var degzr_val=jQuery(degzr).val();
		var syrq_val=jQuery(syrq).val();
		var flag="0";
		if(tab(sqrq_val,degzr_val)=="0"){
			flag = "1";
		}
		if(!checkissamemonth()){
			window.top.Dialog.alert("请假开始日期与结束日期必须在相同月，请检查");
			return false;
	    }
        if(!checkissamemonth2(sqrq_val.substring(0,7),syrq_val.substring(0,7),flag)){
			if(flag !="1"){
				window.top.Dialog.alert("请假开始日期与结束日期必须与申请日期相同月，请检查");
			   return false;					
			}else{
				window.top.Dialog.alert("请假开始日期与结束日期必须与申请日期相同月或上个月，请检查");
			   return false;	
				
			}
			
		}

		return true;
	}
	
});

function checkissamemonth2(sqrqstr,syrqstr,flag){
	     
	         var jbksrq_val=jQuery(jbksrq).val();
			 var jbjsrq_val=jQuery(jbjsrq).val();
			 if(jbksrq_val !="" ){
				if(flag !="1"){
					if(jbksrq_val.substring(0,7) !=sqrqstr){
					   return false;
					}	
				}else{
					if(jbksrq_val.substring(0,7) !=sqrqstr && jbksrq_val.substring(0,7) != syrqstr){
					   return false;
					}
				}
			 }
			 if(jbjsrq_val !="" ){
				if(flag !="1"){
					if(jbjsrq_val.substring(0,7) !=sqrqstr){
					   return false;
					}	
				}else{
					if(jbjsrq_val.substring(0,7) !=sqrqstr && jbjsrq_val.substring(0,7) != syrqstr){
					   return false;
					}
				}
			 }
         
	return true;
	
}
function checkissamemonth(){
	var jbksrq_val=jQuery(jbksrq).val();
	var jbjsrq_val=jQuery(jbjsrq).val();
	if(jbksrq_val !="" && jbjsrq_val !=""){
		if(jbksrq_val.substring(0,7) !=jbjsrq_val.substring(0,7)){
		 return false;
		}				
	}
     
	return true;
}
function tab(date1,date2){
    var oDate1 = new Date(date1.replace(/-/g, "/"));
    var oDate2 = new Date(date2.replace(/-/g, "/"));
    if(oDate1.getTime() <= oDate2.getTime()){
        return "0";
    } else {
        return "1";
    }
}
</script>
