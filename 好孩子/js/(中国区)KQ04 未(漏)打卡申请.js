<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
var sqrq="#field8753";//申请日期
	var degzr="#field10999";//第二工作日
	var syrq="#field11000";//上月日期
	
	var xbkrq_dt1="#field8759_";//需补卡日期
jQuery(document).ready(function () {
    var applyType = 'field8762' // 未打卡类型
    var afterWorkTime = 'field8761' // 下班时间
    // 启动_C.run2函数，目标字段:明细表1的[未打卡类型]
    _C.run2(applyType, function (p) {
        var applyTypeVal = _C.v(applyType + p.r)
        var obj = document.getElementById(afterWorkTime + p.r)
        var field = '#' + afterWorkTime + p.r
        // alert('初始化值：' + p.v.o + '|已有值：' + p.v.n)
        // 页面初始化加载：有值
        if (p.v.o === undefined && p.v.n !== '') {
            if (p.v.n === '0') {
                jQuery(field + ' option[value=\'1\']').remove() // 删除Select中Value='1'的Option
                jQuery(field + ' option[value=\'2\']').remove() // 删除Select中Value='2'的Option
            } else {
                jQuery(field + ' option[value=\'0\']').remove() // 删除Select中Value='0'的Option
            }
        } else {
            if (applyTypeVal === '1' || applyTypeVal === '2') {
                jQuery(field).empty()
                jQuery(field).append("<option value=''></option>") // 为Select追加一个Option(下拉项)
                jQuery(field).append("<option value='1'>16:30</option>") // 为Select追加一个Option(下拉项)
                jQuery(field).append("<option value='2'>17:30</option>") // 为Select追加一个Option(下拉项)
                // 去掉必填红色感叹号
                // _C.rs(afterWorkTime + p.r, false)
            } else if (applyTypeVal === '0') {
                jQuery(field).empty()
                jQuery(field).append("<option value=''></option>") // 为Select追加一个Option(下拉项)
                jQuery(field).append("<option value='0'>空</option>") // 为Select追加一个Option(下拉项)
                // _C.rs(afterWorkTime + p.r, false)
            } else {
                jQuery(field).empty()
                jQuery(field).append("<option value=''></option>") // 为Select追加一个Option(下拉项)
            }
        }
    })
	checkCustomize = function () {
		
		var sqrq_val=jQuery(sqrq).val();
		var degzr_val=jQuery(degzr).val();
		var syrq_val=jQuery(syrq).val();
		var flag="0";
		if(tab(sqrq_val,degzr_val)=="0"){
			flag = "1";
		}
        if(!checkissamemonth2(sqrq_val.substring(0,7),syrq_val.substring(0,7),flag)){
			if(flag !="1"){
				window.top.Dialog.alert("需补卡日期必须与申请日期相同月，请检查");
			   return false;					
			}else{
				window.top.Dialog.alert("需补卡日期必须与申请日期相同月或上个月，请检查");
			   return false;	
				
			}
			
		}
		


		return true;
	}
})

function checkissamemonth2(sqrqstr,syrqstr,flag){
	var indexnum0= jQuery("#indexnum0").val();
	 for(var index=0;index <indexnum0;index++){
	      if(jQuery(xbkrq_dt1+index).length>0){
	         var xbkrq_dt1_val=jQuery(xbkrq_dt1+index).val();
			 if(xbkrq_dt1_val !="" ){
				if(flag !="1"){
					if(xbkrq_dt1_val.substring(0,7) !=sqrqstr){
					   return false;
					}	
				}else{
					if(xbkrq_dt1_val.substring(0,7) !=sqrqstr && xbkrq_dt1_val.substring(0,7) != syrqstr){
					   return false;
					}
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












