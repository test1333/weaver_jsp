jQuery(document).ready(function() {
    //alert(123);
	var leftdays = "#field6516"; //剩余天数
	var leavehours = "#field6529"; //请假小时数
	var isSalary="#field8608";//是否带薪

	checkCustomize = function() {

		var leftdays_val = jQuery(leftdays).val();
	    var leavehours_val = jQuery(leavehours).val();
		var isSalary_val = jQuery(isSalary).val();

		//alert("isSalary_val="+isSalary_val);
		//alert("leftdays_val="+leftdays_val);

		var result = true;

        if(Number(leavehours_val) <=0){
           alert("填写的请假日期和结束日期无效，请查证后重新填写！");
           return false;
        }
	   	//根据是否带薪控制
      	if(isSalary_val==0){  
          if(Number(leavehours_val)>Number(leftdays_val)){
             result = false;
             alert("申请时间大于剩余时间,请重新填写！");
          }
	}

	   return result;
    }
});
