<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  var yjyxqs_dt1="#field24271_";//运价有限期始
  var yjyxqz_dt1="#field24272_";//运价有限期止
  jQuery(document).ready(function () {
	checkCustomize = function () {
		var dqrq = getNowFormatDate();
		var indexnum0 = jQuery("#indexnum0").val();
		for(var index = 0;index < indexnum0;index++){
				if(jQuery(yjyxqs_dt1+index).length>0){
					var yjyxqs_dt1_val=jQuery(yjyxqs_dt1+index).val();
					var yjyxqz_dt1_val=jQuery(yjyxqz_dt1+index).val();	
					if(yjyxqs_dt1_val !=""){
						if(tab(yjyxqs_dt1_val,dqrq) == "0"){
							alert("运价有效期始不能小于今天");
							return false;
						}
						if(yjyxqz_dt1_val != ""){
							if(tab(yjyxqz_dt1_val,yjyxqs_dt1_val) == "0"){
							alert("运价有效期止不能小于运价有效期始");
							return false;
						}
						}
					}
				}
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
</script>

