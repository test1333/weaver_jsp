
<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var gx_dt1 = '#field16255_';
	var gx_dt1_new = 'field16255';//明细字段勾选
	var ldkrq_dt1 = '#field16252_';
	var ldkjd_dt1 = '#field16253_';
	var checkrq = '#field16724';
	var ly_dt1 = 'field16254_';
	jQuery(document).ready(function () {
		var indexnum0 = jQuery("#indexnum0").val();
		for(var index=0; index<indexnum0;index++){
			if(jQuery(ldkjd_dt1+index).length>0){
				if (WfForm.getFieldValue(gx_dt1_new+"_"+index)== "1") {
					WfForm.changeFieldAttr(ly_dt1+index, 3); 									 
				}
			}
			
		}
		 WfForm.bindDetailFieldChangeEvent(gx_dt1_new,function(id,rowIndex,value){
			var fieldid = id+"_"+rowIndex;
			var fieldvalue = WfForm.getFieldValue(fieldid);
			if(fieldvalue == "1"){
			   WfForm.changeFieldAttr(ly_dt1+rowIndex, 3); 
			}else{
			   WfForm.changeFieldAttr(ly_dt1+rowIndex, 2); 
			}
		 }); 
		
		
		
		WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){  
			var flag = "1";
			var nowdate = getNowFormatDate();
			var checkrq_val = jQuery(checkrq).val();
			if(tab(checkrq_val,nowdate)=="0"){
				alert("每个月5号顺延的5个工作日之后,不允许提交漏打卡流程");
				flag = "0";
				return;
			}
			var indexnum0 = jQuery("#indexnum0").val();
			var count = 0;
			for(var index=0; index<indexnum0;index++){
				if(jQuery(ldkjd_dt1+index).length>0){
					 if (WfForm.getFieldValue(gx_dt1_new+"_"+index) == "1") {
						 count = count+1;
						 if(count>3){
							alert("勾选明细行数量大于3条，请检查");
							flag = "0";
						 }
						 var ldkrq_dt1_val = jQuery(ldkrq_dt1+index).val();
						 var ldkjd_dt1_val = jQuery(ldkjd_dt1+index).val();
						 var checkResult = checkdata(ldkrq_dt1_val,ldkjd_dt1_val,index);
						 if(checkResult == "1"){
							alert("同一天上下班都未打卡，无法补卡，请检查");
							flag = "0";			
							return;							
						 }						 						 
					 }
				}		
			}
			if(count == 0){
				 if(confirm("您上月存在漏打卡，允许最多勾选三天记录申请补卡，如需补卡请勾选，是否返回申请？")){
					flag = "0";
					return;
				}else{
					
				}

				
			}
			if(flag == "1"){
			callback();
			}	
      });
	  
	})
	
	
	function checkdata(ldkrq,ldkjd,index0){
		var indexnum0 = jQuery("#indexnum0").val();
		for(var index=0; index<indexnum0;index++){
			if(jQuery(ldkjd_dt1+index).length>0){
				if(index == index0){
					continue;
				}
				var ldkrq_dt1_val = jQuery(ldkrq_dt1+index).val();
				var ldkjd_dt1_val = jQuery(ldkjd_dt1+index).val();
				if( ldkrq_dt1_val == ldkrq && ldkjd_dt1_val != ldkjd){
					return "1";					
				}													
			}
		}
		return "0";
		
	}	
	function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year + seperator1 + month + seperator1 + strDate;
        return currentdate;
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





