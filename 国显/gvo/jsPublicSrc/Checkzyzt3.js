var zymc = "#field11994";// 资源名称
var tmp_bookid = jQuery("#tmp_bookid").val();
//alert("tmp_bookid = " + tmp_bookid);
	if(tmp_bookid.length>0){

		jQuery.post("/gvo/jsPublicSrc/getSrcInfo.jsp",{'id':tmp_bookid},function(data){

			data = data.replace(/\n/g,"").replace(/\r/g,"");
            eval('var obj ='+data);
            var srcID = obj.srcID;
            var srcName = obj.srcName;
            jQuery(zymc).val(srcID);
            jQuery(zymc+"span").html(srcName);
	    });
	}

jQuery(document).ready(function() {

	var yjjyksrq = "#field11951";// 预计借用开始日期
	var yjjyjsrq = "#field11953";// 预计借用开始日期
    var yjjykssj = "#field11952";// 预计借用开始时间
    var yjjyjssj = "#field11954";// 预计借用开始时间

	checkCustomize = function() {
		var yjjyksrq_val = jQuery(yjjyksrq).val();
        var yjjykssj_val = jQuery(yjjykssj).val();
        var yjjyjssj_val = jQuery(yjjyjssj).val();
        var zymc_val = jQuery(zymc).val();
        jQuery(yjjyjsrq+"span").text(yjjyksrq_val);
        alert("yjjyksrq_val="yjjyksrq_val);
		var result = true;
		var z_num = 0;
		if (zymc_val.length > 0&&yjjyksrq_val.length > 0 && yjjykssj_val.length > 0 && yjjyjssj_val.length>0) {
	       $.ajaxSettings.async = false;//同步传值
	       jQuery.post("/gvo/jsPublicSrc/getTimeInfo.jsp", {
		               'yjjyksrq' : yjjyksrq_val,
		               'yjjyjsrq' : yjjyksrq_val,
		               'yjjykssj' : yjjykssj_val,
		               'yjjyjssj' : yjjyjssj_val,
		               'zymc' : zymc_val
	       }, function(data) {
		              //alert(data);
		              data = data.replace(/\n/g, "").replace(/\r/g, "");
		              eval('var obj =' + data);
		              z_num = obj.x_num;
	          });
        }
		//alert("z_num="+z_num);
		if (Number(z_num) > 0) {
			result = false;
			window.top.Dialog.alert("该试验器材被占用，暂不可借用！");
		}
		return false;
	}

});
