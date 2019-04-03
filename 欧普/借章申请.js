<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/opple/adore/js/cw.js"></script>
<script type="text/javascript">
jQuery(document).ready(function () {
    var beginDate = 'field8588'
    var endDate = 'field8589'
	
    var days = -7
    var mDays = Math.abs(days)
    var bDate = document.getElementById(beginDate + 'browser')
    bDate.onclick = function () {
        onshowShawBDate(beginDate, endDate)
    }

   var eDate = document.getElementById(endDate + 'browser')
    eDate.onclick = function () {
        onshowShawEDate(beginDate, endDate)
    }
	
	jQuery("#"+beginDate).bindPropertyChange(function () {
		var beginDate_val=jQuery("#"+beginDate).val();
		var endDate_val=jQuery("#"+endDate).val();
		if(beginDate_val != "" && endDate_val != ""){
		  if(tab(endDate_val,beginDate_val)=="0"){
			  window.top.Dialog.alert("预计借出时间与规还时间必须在7天内");
			  jQuery("#"+endDate).val("");
			  jQuery("#"+endDate+"span").text("");
		  }else{
			  if(tab(addDate(beginDate_val,7),endDate_val)=="0"){
				 window.top.Dialog.alert("预计借出时间与规还时间必须在7天内");
				  jQuery("#"+endDate).val("");  
				  jQuery("#"+endDate+"span").text("");
				  
			  }
			  
		  }
			
		}
		
	});
    
    function onshowShawBDate (beginDate, endDate) {
        // alert(endDate);
        WdatePicker({
            lang: languageStr,
            minDate: '%y-%M-#{%d}',
            // minDate: '%y-%M-#{%d}',
            // maxDate: '#F{$dp.$D(' + endDate + ',{d:-7});}',
            maxDate: '9999-12-31',
            el: beginDate + 'span',
            onpicked: function (dp) {
                var returnvalue = dp.cal.getDateStr()
                $dp.$(beginDate).value = returnvalue
            },
            oncleared: function (dp) {
                $dp.$(beginDate).value = ''
            }
        })
    }

    function onshowShawEDate (beginDate, endDate) {
        WdatePicker({
            lang: languageStr,
            minDate: '#F{$dp.$(\'field8588\').value||\'%y-%M-#{%d}\'}',
            maxDate: '#F{$dp.$D(\'field8588\',{d:' + mDays + '})||\'9999-12-31\';}',
            el: endDate + 'span',
            onpicked: function (dp) {
                var returnvalue = dp.cal.getDateStr()
                $dp.$(endDate).value = returnvalue
            },
            oncleared: function (dp) {
                $dp.$(endDate).value = ''
            }
        })
    }
})
function addDate(date,days){
    var d=new Date(date);
    d.setDate(d.getDate()+days);
    var m=d.getMonth()+1;
    return d.getFullYear()+'-'+m+'-'+d.getDate();
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


jQuery(document).ready(function () {
    var seal = 'field8595' // 印章
    var manager = 'field9682' // 管理员

    // 获取印章管理员
    function getManager () {
        // 定义ajax参数
        var a = {
            // 请求目标地址sapClabs.jsp
            url: '/opple/adore/js/sealApply.jsp' +
            '?seal=' + _C.v(seal),
            type: 'post',
            // 定义请求完成时的回调函数
            success: function (d) {
                // Dialog.alert('data=' + d)
                var obj = JSON.parse(d)
                var str = ''
                var ids = ''
                for (var i = 0; i < obj.length; i++) {
                    // Dialog.alert('i=' + i + 'id=' + obj[i].id)
                    ids += str + obj[i].id
                    jQuery('#' + manager + 'span').append('<span class=e8_showNameClass>' + _C.aHrm(obj[i].id, obj[i].name) + '</span>')
                    str = ','
                }
                // Dialog.alert('names=' + names)
                jQuery('#' + manager).val(ids)
            }
        }
        // top.Dialog.alert(a.url);
        // 发送请求
        jQuery.ajax(a)
    }

    // 获取印章状态
    function getState () {
        var result = true
        // 定义ajax参数
        var a = {
            // 请求目标地址sapClabs.jsp
            url: '/opple/adore/js/sealBorrow.jsp' +
            '?seal=' + _C.v(seal),
            type: 'post',
            // 定义请求完成时的回调函数
            success: function (d) {
                // Dialog.alert('data=' + d)
                // Dialog.alert('data=' + d.indexOf(0))
                if (d.indexOf('0') >= 0) {
                    Dialog.alert('此章已被占用,请联系印章管理员,谢谢!')
                    _C.v(seal, '')
                    _C.rs(seal, true)
                }
            }
        }
        // top.Dialog.alert(a.url);
        // 发送请求
        jQuery.ajax(a)
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
</script>

















