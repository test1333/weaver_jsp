
var qjr_code = "#field5872";//人员工号
var nyyxxss = "#field5931";
var nyyxxss1 = "#field5932";
var nywxxss = "#field5933";

var txjyxxss = "#field5936";
var txjyxxss1 = "#field5937";
var txjwxxss = "#field5938";

var yjqjksrq = "#field5877";//预计请假开始日期
var yjqjjsrq = "#field5879";//预计请假结束日期
var yjqjkssj = "#field5878";//预计请假开始时间
var yjqjjssj = "#field5880";//预计结束开始时间
var xjlxbm = "#field8202";//休假类型编码
var yjsjxss = "#field5881";//预计休假小时数

// var njyy_id = "#field17059";
var njjy_id = "#field17585"; //年假上年顺延时数
var njgq_id = "#field17586";  //年假过期时数

// var txyy_id = "#field17060";
var txjy_id = "#field17588";  //调休假上年结转时数
var txgq_id = "#field17587";  //调休假过期时数



var yjsjxss_1 = "field5881";//预计休假小时数
	jQuery(qjr_code).bind("change",function(){ 	
//	jQuery(qjr_code).bindPropertyChange(function () {
		var qjr_code_1 = jQuery(qjr_code).val();
		if(qjr_code_1.length>0){
			jQuery.post("/gvo/HRworkflow/getInfo.jsp",{"qjr_code":qjr_code_1},function(data){
                   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var totalValue1 = obj.totalValue1;
                   var totalValue2 = obj.totalValue2;
                   var userValue1 = obj.userValue1;
                   var userValue2 = obj.userValue2;
                   var labelVale1 = obj.labelVale1;
                   var labelVale2 = obj.labelVale2;


                   var forwardVaule1 = obj.forwardVaule1;
                   var expiedValue1 = obj.expiedValue1;
                   var forwardVaule2 = obj.forwardVaule2;
                   var expiedValue2 = obj.expiedValue2;
 
                   jQuery(nyyxxss).val(totalValue1);
                   jQuery(nyyxxss+"span").text(totalValue1);
                   jQuery(nyyxxss1).val(userValue1);
                   jQuery(nyyxxss1+"span").text(userValue1);
                 //  jQuery(nywxxss).val(labelVale1);
                 //  jQuery(nywxxss+"span").text(labelVale1);
                   
                   jQuery(txjyxxss).val(totalValue2);
                   jQuery(txjyxxss+"span").text(totalValue2);
                   jQuery(txjyxxss1).val(userValue2);
                   jQuery(txjyxxss1+"span").text(userValue2);
                  // jQuery(txjwxxss).val(labelVale2);
                  // jQuery(txjwxxss+"span").text(labelVale2);

                 //  alter(njjy_id);
                   jQuery(njjy_id).val(forwardVaule1);
                   jQuery(njjy_id+"span").text(forwardVaule1);
                   jQuery(njgq_id).val(expiedValue1);
                   jQuery(njgq_id+"span").text(expiedValue1);
                   jQuery(txjy_id).val(forwardVaule2);
                   jQuery(txjy_id+"span").text(forwardVaule2);
                   jQuery(txgq_id).val(expiedValue2);
                   jQuery(txgq_id+"span").text(expiedValue2);
                    
			});
		}
	})
//document.getElementById(yjsjxss_1).readOnly = true;

//jQuery(document).ready(function(){

//	jQuery(yjqjksrq).bindPropertyChange(function () {
//	jQuery(qjr_code).bind("change",function(){ 	
	jQuery(yjqjksrq).bind("propertychange",function(){ 	
		alert("2");
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
                 //  jQuery(yjsjxss+"span").text(xss);
               document.getElementById(yjsjxss_1).readOnly = true;
			});
		}
	})
//	jQuery(yjqjkssj).bindPropertyChange(function () {
	jQuery(yjqjkssj).bind("propertychange",function(){ 	
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
                   //jQuery(yjsjxss+"span").text(xss);
                 document.getElementById(yjsjxss_1).readOnly = true;
			});
		}
	})
	
//	jQuery(yjqjjssj).bindPropertyChange(function () {
	jQuery(yjqjjssj).bind("propertychange",function(){ 	
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
                   //jQuery(yjsjxss+"span").text(xss);
                  document.getElementById(yjsjxss_1).readOnly = true;
			});
		}
	})
	
//	jQuery(yjqjjsrq).bindPropertyChange(function () {
	jQuery(yjqjjsrq).bind("propertychange",function(){ 	
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
                  // jQuery(yjsjxss+"span").text(xss);
                  document.getElementById(yjsjxss_1).readOnly = true;
			});
		}
	})
	
//	jQuery(xjlxbm).bindPropertyChange(function () {
	jQuery(xjlxbm).bind("propertychange",function(){ 
		var qjr_code_1 = jQuery(qjr_code).val();
		var yjqjksrq1 = jQuery(yjqjksrq).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq).val();
		var yjqjkssj1 = jQuery(yjqjkssj).val();
		var yjqjjssj1 = jQuery(yjqjjssj).val();
		var xjlxbm1 = jQuery(xjlxbm).val();
//		alert(yjqjksrq1);
//		alert(yjqjjsrq1);
//		alert(yjqjkssj1);
//		alert(yjqjjssj1);
//		alert(xjlxbm1);
		if(yjqjksrq1.length>0&&yjqjjsrq1.length>0&&yjqjkssj1.length>0&&yjqjjssj1.length>0&&xjlxbm1.length>0){
//			alert("进入");
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp",{'yjqjksrq':yjqjksrq1,'yjqjjsrq':yjqjjsrq1,'yjqjkssj':yjqjkssj1,'yjqjjssj':yjqjjssj1,'xjlxbm':xjlxbm1,'qjr_code':qjr_code_1},function(data){
//                   alert(data);
				   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss).val(xss);
                  // jQuery(yjsjxss+"span").text(xss);
                 document.getElementById(yjsjxss_1).readOnly = true;
			});
		}
	})
//})