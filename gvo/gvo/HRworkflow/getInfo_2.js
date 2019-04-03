
var qjr_code = "#field5872";//人员工号

var yjqjksrq = "#field5882";//实际请假开始日期
var yjqjjsrq = "#field5884";//实际请假结束日期
var yjqjkssj = "#field5883";//实际请假开始时间
var yjqjjssj = "#field5885";//实际结束开始时间
var xjlxbm = "#field8202";//休假类型编码
var yjsjxss = "#field5886";//实际休假小时数


jQuery(document).ready(function(){
//	jQuery("input[id='"+yjsjxss+"']").attr("readonly",true);
	jQuery(yjsjxss).attr("readonly",true);
//	jQuery(yjqjksrq).bind("propertychange",function(){ 	
	jQuery(yjqjksrq).bindPropertyChange(function(){ 
		var qjr_code_1 = jQuery(qjr_code).val();
		var yjqjksrq1 = jQuery(yjqjksrq).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq).val();
		var yjqjkssj1 = jQuery(yjqjkssj).val();
		var yjqjjssj1 = jQuery(yjqjjssj).val();
		var xjlxbm1 = jQuery(xjlxbm).val();
		if(yjqjksrq1.length>0&&yjqjjsrq1.length>0&&yjqjkssj1.length>0&&yjqjjssj1.length>0&&xjlxbm1.length>0){
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp",{'yjqjksrq':yjqjksrq1,'yjqjjsrq':yjqjjsrq1,'yjqjkssj':yjqjkssj1,'yjqjjssj':yjqjjssj1,'xjlxbm':xjlxbm1,'qjr_code':qjr_code_1},function(data){
                   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss).val(xss);
//                   jQuery(yjsjxss+"span").html(xss);
			});
		}
	})
	
//	jQuery(yjqjkssj).bind("propertychange",function(){ 	
	jQuery(yjqjkssj).bindPropertyChange(function(){ 
		var qjr_code_1 = jQuery(qjr_code).val();
		var yjqjksrq1 = jQuery(yjqjksrq).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq).val();
		var yjqjkssj1 = jQuery(yjqjkssj).val();
		var yjqjjssj1 = jQuery(yjqjjssj).val();
		var xjlxbm1 = jQuery(xjlxbm).val();
		if(yjqjksrq1.length>0&&yjqjjsrq1.length>0&&yjqjkssj1.length>0&&yjqjjssj1.length>0&&xjlxbm1.length>0){
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp",{'yjqjksrq':yjqjksrq1,'yjqjjsrq':yjqjjsrq1,'yjqjkssj':yjqjkssj1,'yjqjjssj':yjqjjssj1,'xjlxbm':xjlxbm1,'qjr_code':qjr_code_1},function(data){
                   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss).val(xss);
//                   jQuery(yjsjxss+"span").html(xss);
			});
		}
	})
	
	
//	jQuery(yjqjjssj).bind("propertychange",function(){ 	
	jQuery(yjqjjssj).bindPropertyChange(function(){ 
		var qjr_code_1 = jQuery(qjr_code).val();
		var yjqjksrq1 = jQuery(yjqjksrq).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq).val();
		var yjqjkssj1 = jQuery(yjqjkssj).val();
		var yjqjjssj1 = jQuery(yjqjjssj).val();
		var xjlxbm1 = jQuery(xjlxbm).val();
		if(yjqjksrq1.length>0&&yjqjjsrq1.length>0&&yjqjkssj1.length>0&&yjqjjssj1.length>0&&xjlxbm1.length>0){
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp",{'yjqjksrq':yjqjksrq1,'yjqjjsrq':yjqjjsrq1,'yjqjkssj':yjqjkssj1,'yjqjjssj':yjqjjssj1,'xjlxbm':xjlxbm1,'qjr_code':qjr_code_1},function(data){
                   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss).val(xss);
//                   jQuery(yjsjxss+"span").html(xss);
			});
		}
	})
	
//	jQuery(yjqjjsrq).bind("propertychange",function(){ 	
	jQuery(yjqjjsrq).bindPropertyChange(function(){ 
		var qjr_code_1 = jQuery(qjr_code).val();
		var yjqjksrq1 = jQuery(yjqjksrq).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq).val();
		var yjqjkssj1 = jQuery(yjqjkssj).val();
		var yjqjjssj1 = jQuery(yjqjjssj).val();
		var xjlxbm1 = jQuery(xjlxbm).val();
		if(yjqjksrq1.length>0&&yjqjjsrq1.length>0&&yjqjkssj1.length>0&&yjqjjssj1.length>0&&xjlxbm1.length>0){
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp",{'yjqjksrq':yjqjksrq1,'yjqjjsrq':yjqjjsrq1,'yjqjkssj':yjqjkssj1,'yjqjjssj':yjqjjssj1,'xjlxbm':xjlxbm1,'qjr_code':qjr_code_1},function(data){
                   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss).val(xss);
//                   jQuery(yjsjxss+"span").html(xss);
			});
		}
	})
	
//	jQuery(xjlxbm).bind("propertychange",function(){ 
	jQuery(xjlxbm).bindPropertyChange(function(){ 
		var qjr_code_1 = jQuery(qjr_code).val();
		var yjqjksrq1 = jQuery(yjqjksrq).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq).val();
		var yjqjkssj1 = jQuery(yjqjkssj).val();
		var yjqjjssj1 = jQuery(yjqjjssj).val();
		var xjlxbm1 = jQuery(xjlxbm).val();
		if(yjqjksrq1.length>0&&yjqjjsrq1.length>0&&yjqjkssj1.length>0&&yjqjjssj1.length>0&&xjlxbm1.length>0){
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp",{'yjqjksrq':yjqjksrq1,'yjqjjsrq':yjqjjsrq1,'yjqjkssj':yjqjkssj1,'yjqjjssj':yjqjjssj1,'xjlxbm':xjlxbm1,'qjr_code':qjr_code_1},function(data){
//                   alert(data);
				   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss).val(xss);
//                   jQuery(yjsjxss+"span").html(xss);
			});
		}
	})
})