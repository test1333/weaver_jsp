<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var bjrq="#field10651";//报价日期
var bjksrq="#field10642";//报价开始日期
var bjjsrq="#field10644";//借款人
    jQuery(document).ready(function(){
		 checkCustomize = function(){ 
		    var bjrq_val=jQuery(bjrq).val();
			var bjksrq_val=jQuery(bjksrq).val();
			var bjjsrq_val=jQuery(bjjsrq).val();
			
			if(tab(bjrq_val,bjksrq_val) == "0"){
				window.top.Dialog.alert("报价日期小于报价开始日期，请检查");
				return false;
			}
			if(tab(bjjsrq_val,bjrq_val) == "0"){
				window.top.Dialog.alert("报价日期大于报价截止日期，请检查");
				return false;
			}
			return true;
		 }
	});
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
