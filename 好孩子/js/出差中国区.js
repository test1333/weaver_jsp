<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var sqrq="#field8560";//申请日期
	var degzr="#field10995";//第二工作日
	var syrq="#field10996";//上月日期
	
	var jbksrq_dt1="#field8566_";//加班开始日期
	var jbjsrq_dt1="#field8568_";//加班结束日期

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
			window.top.Dialog.alert("出差/外出开始日期与结束日期必须在相同月，请检查");
			return false;
	    }
        if(!checkissamemonth2(sqrq_val.substring(0,7),syrq_val.substring(0,7),flag)){
			if(flag !="1"){
				window.top.Dialog.alert("出差/外出开始日期与结束日期必须与申请日期相同月，请检查");
			   return false;					
			}else{
				window.top.Dialog.alert("出差/外出开始日期与结束日期必须与申请日期相同月或上个月，请检查");
			   return false;	
				
			}
			
		}
		


		return true;
	}
	
});

function checkissamemonth2(sqrqstr,syrqstr,flag){
	var indexnum0= jQuery("#indexnum0").val();
	 for(var index=0;index <indexnum0;index++){
	      if(jQuery(jbksrq_dt1+index).length>0){
	         var jbksrq_dt1_val=jQuery(jbksrq_dt1+index).val();
			 var jbjsrq_dt1_val=jQuery(jbjsrq_dt1+index).val();
			 if(jbksrq_dt1_val !="" ){
				if(flag !="1"){
					if(jbksrq_dt1_val.substring(0,7) !=sqrqstr){
					   return false;
					}	
				}else{
					if(jbksrq_dt1_val.substring(0,7) !=sqrqstr && jbksrq_dt1_val.substring(0,7) != syrqstr){
					   return false;
					}
				}
			 }
			 if(jbjsrq_dt1_val !="" ){
				if(flag !="1"){
					if(jbjsrq_dt1_val.substring(0,7) !=sqrqstr){
					   return false;
					}	
				}else{
					if(jbjsrq_dt1_val.substring(0,7) !=sqrqstr && jbjsrq_dt1_val.substring(0,7) != syrqstr){
					   return false;
					}
				}
			 }
          }
	}
	return true;
	
}
function checkissamemonth(){
	var indexnum0= jQuery("#indexnum0").val();
	 for(var index=0;index <indexnum0;index++){
	      if(jQuery(jbksrq_dt1+index).length>0){
	         var jbksrq_dt1_val=jQuery(jbksrq_dt1+index).val();
			 var jbjsrq_dt1_val=jQuery(jbjsrq_dt1+index).val();
			 if(jbksrq_dt1_val !="" && jbjsrq_dt1_val !=""){
				if(jbksrq_dt1_val.substring(0,7) !=jbjsrq_dt1_val.substring(0,7)){
				   return false;
				}				
			 }
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




























