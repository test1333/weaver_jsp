<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/opple/adore/js/cw.js"></script>
<script type="text/javascript">

jQuery(document).ready(function () {
    var seal = 'field8595' // 印章                                        
    var manager = 'field9682' // 管理员

	//alert("11111")
	
    // 获取印章管理员
    function getManager () {
		//alert("2222")
		// 请求目标地址sapClabs.jsp
		jQuery.ajax({
		type: "GET",
		cache: false,
		url: "/opple/daisy/sealApply.jsp?seal="+_C.v(seal),
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		success : function (data) {
			//alert('data=' + data)
			var obj = JSON.parse(data)
			var str = ''
			var ids = ''
			var name = ''
			for (var i = 0; i < obj.length; i++) {
				// Dialog.alert('i=' + i + 'id=' + obj[i].id)
				ids += str + obj[i].id
				name += str + obj[i].name
				jQuery('#' + manager + 'span').append('<span class=e8_showNameClass>' + _C.aHrm(obj[i].id, obj[i].name) + '</span>')
				str = ','
			}
			// Dialog.alert('names=' + names)
			jQuery('#' + manager).val(ids)
			jQuery('#' + manager + '_span').text(name)
		} 
	}); 

	}
    // 获取印章状态
    function getState () {
		//alert("11111")
        var result = true
        // 定义ajax参数
		jQuery.ajax({
		type: "GET",
		cache: false,
		url: "/opple/daisy/sealBorrow.jsp?seal="+_C.v(seal),
		//data: {"workflowid" : "12", "requestid" : "999"},
		//dataType: "json", 
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		success : function (data) {
			 // Dialog.alert('data=' + d.indexOf(0))
                if (data.indexOf('0') >= 0) {
                    Dialog.alert('此章已被占用,请联系印章管理员,谢谢!')
                    _C.v(seal, '')
                    _C.rs(seal, true)
                }
		} 
	}); 
	}

    // 启动_C.run2函数，目标字段:主表的[印章]
    _C.run2(seal, function () {
        // 一旦代码改变，那么将发送读取印章数据表
        _C.v(manager, '')
        getManager()
        // 检查印章状态
        getState()
    })
})


jQuery(document).ready(function() {
	
    var beginDate_id = '#field8588';
    var endDate_id = '#field8589';
	checkCustomize = function () {
                //alert("11111111");
		var bDate = jQuery(beginDate_id).val();
		var eDate = jQuery(endDate_id).val();
		var dqrq_val = getNowFormatDate();
		if(tab(bDate,dqrq_val)=="0"){
			alert('预计归还日期要大于等于当前日期，请重新选择！');
			return false;
		  }
		if(tab(eDate,bDate)=="0"){
			alert('预计归还日期必须大于预计借出日期，请重新选择！');
			return false;
		  }
                //alert("222 = " + bDate + " :  " + eDate);
 
		var dateArr_1 = bDate.split("-");
		var startDate = new Date();
		startDate.setFullYear(dateArr_1[0], dateArr_1[1]-1, dateArr_1[2]);
		var startTime = startDate.getTime();
//		  alert("123 = " + startTime);
		var dateArr_2 = eDate.split("-");
		var endDate = new Date();
		endDate.setFullYear(dateArr_2[0], dateArr_2[1]-1, dateArr_2[2]);
		var endTime = endDate.getTime();
        //        alert("124 = " + endTime);

		//alert("111 = " + (endTime-startTime) );
		var iDays = (endTime-startTime) /  1000  /  60  /  60  /24 ;
	
		if(iDays>7){
			alert('预计归还日期-预计借出日期不能超过7天，请重新选择！')
			jQuery(endDate).val("")
			jQuery(endDate).text("")
			return false;
		}
		return true;
	}
})

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































