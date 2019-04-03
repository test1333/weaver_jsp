// GT_人力资源 1.02 加班流程

var s_emp  = "field8361_";	//加班人编号
var s_date = "field5860_";	//开始日期
var s_time = "field5861_";	//开始时间
var e_date = "field5862_";	//结束日期
var e_time = "field5863_";	//结束时间
var g_date = "field8195_";  //归属日期
var y_jbxss = "field5864_"; //小时数
var y_ygxss = "field8985_"; //员工填写小时数


for(var i =0;i<500;i++){
	// 目标存在
	if(jQuery("#"+s_emp+i).length>0){
		ismeth(i);
		isMax(i);
	}
}

function isMax(i){
	// jQuery("input[id='"+s_date+i+"']").bind("propertychange",function(){ 	
	jQuery("#"+s_date+i).bindPropertyChange(function () {
		var tmp_g_date  = "#" + g_date  + i;
		var tmp_s_date = "#" + s_date + i;
		var val1 = jQuery(tmp_s_date).val();
		var val2 = jQuery(tmp_g_date).val();
		var intDate = DateDiff(val1,val2);
		if(val1.length>0){
			if(intDate!=1&&intDate!=0){
				window.top.Dialog.alert("实际开始日期不可早于归属日期，并且不可晚于归属日期1天");
				jQuery(tmp_s_date).val("");
				jQuery(tmp_s_date+"span").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			}
		}
	});
	
//	jQuery("input[id='"+e_date+i+"']").bind("propertychange",function(){ 
	jQuery("#"+e_date+i).bindPropertyChange(function () {	
		var tmp_g_date  = "#" + g_date  + i;
		var tmp_e_date = "#" + e_date + i;
		var val1 = jQuery(tmp_e_date).val();
		var val2 = jQuery(tmp_g_date).val();
		var intDate = DateDiff(val1,val2);
		if(val1.length>0){
			if(intDate!=1&&intDate!=0){
				window.top.Dialog.alert("实际结束日期不可早于归属日期，并且不可晚于归属日期1天");
				jQuery(tmp_e_date).val("");
				jQuery(tmp_e_date+"span").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
			}
		}
	});
	
}

function ismeth(i){
//	alert();
//	alert("1");
//	var nowRow = parseInt($G("indexnum0").value) - 1;
	
	jQuery("input[id='"+y_jbxss+i+"']").attr("readonly",true);
	
//	jQuery("input[id='"+s_emp+i+"']").bind("propertychange",function(){ 	
	jQuery("#"+s_emp+i).bindPropertyChange(function () {	
		var tmp_s_emp  = "#" + s_emp  + i;
		var tmp_s_date = "#" + s_date + i;
		var tmp_s_time = "#" + s_time + i;
		var tmp_e_date = "#" + e_date + i;
		var tmp_e_time = "#" + e_time + i;
		var tmp_g_date = "#" + g_date + i;
		var tmp_y_jbxss = "#" + y_jbxss + i;
		var tmp_y_ygxss = "#" + y_ygxss + i;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss,tmp_y_ygxss);
	});
	
//	jQuery("input[id='"+s_date+i+"']").bind("propertychange",function(){ 	
	jQuery("#"+s_date+i).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp  + i;
		var tmp_s_date = "#" + s_date + i;
		var tmp_s_time = "#" + s_time + i;
		var tmp_e_date = "#" + e_date + i;
		var tmp_e_time = "#" + e_time + i;
		var tmp_g_date = "#" + g_date + i;
		var tmp_y_jbxss = "#" + y_jbxss + i;
		var tmp_y_ygxss = "#" + y_ygxss + i;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss,tmp_y_ygxss);
	});
	
//	jQuery("input[id='"+s_time+i+"']").bind("propertychange",function(){ 	
	jQuery("#"+s_time+i).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp  + i;
		var tmp_s_date = "#" + s_date + i;
		var tmp_s_time = "#" + s_time + i;
		var tmp_e_date = "#" + e_date + i;
		var tmp_e_time = "#" + e_time + i;
		var tmp_g_date = "#" + g_date + i;
		var tmp_y_jbxss = "#" + y_jbxss + i;
		var tmp_y_ygxss = "#" + y_ygxss + i;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss,tmp_y_ygxss);
	});
	
//	jQuery("input[id='"+e_date+i+"']").bind("propertychange",function(){ 	
	jQuery("#"+e_date+i).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp  + i;
		var tmp_s_date = "#" + s_date + i;
		var tmp_s_time = "#" + s_time + i;
		var tmp_e_date = "#" + e_date + i;
		var tmp_e_time = "#" + e_time + i;
		var tmp_g_date = "#" + g_date + i;
		var tmp_y_jbxss = "#" + y_jbxss + i;
		var tmp_y_ygxss = "#" + y_ygxss + i;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss,tmp_y_ygxss);
	});
	
//	jQuery("input[id='"+e_time+i+"']").bind("propertychange",function(){ 	
	jQuery("#"+e_time+i).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp  + i;
		var tmp_s_date = "#" + s_date + i;
		var tmp_s_time = "#" + s_time + i;
		var tmp_e_date = "#" + e_date + i;
		var tmp_e_time = "#" + e_time + i;
		var tmp_g_date = "#" + g_date + i;
		var tmp_y_jbxss = "#" + y_jbxss + i;
		var tmp_y_ygxss = "#" + y_ygxss + i;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss,tmp_y_ygxss);
	});
	
//	jQuery("input[id='"+g_date+i+"']").bind("propertychange",function(){ 	
	jQuery("#"+g_date+i).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp  + i;
		var tmp_s_date = "#" + s_date + i;
		var tmp_s_time = "#" + s_time + i;
		var tmp_e_date = "#" + e_date + i;
		var tmp_e_time = "#" + e_time + i;
		var tmp_g_date = "#" + g_date + i;
		var tmp_y_jbxss = "#" + y_jbxss + i;
		var tmp_y_ygxss = "#" + y_ygxss + i;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss,tmp_y_ygxss);
	});
}
	

function get_some_Times(s_emp,s_date,s_time,e_date,e_time,g_date,y_jbxss,y_ygxss){
	
	
	if(jQuery(s_emp).length>0&&jQuery(s_date).length>0&&jQuery(e_date).length>0&&jQuery(s_time).length>0&&jQuery(e_time).length>0&&jQuery(g_date).length>0){
		var emp_s_emp = jQuery(s_emp).val();
		var emp_s_date = jQuery(s_date).val();
		var emp_s_time = jQuery(s_time).val();
		var emp_e_date = jQuery(e_date).val();
 		var emp_e_time = jQuery(e_time).val();
 		var emp_g_date = jQuery(g_date).val();
		
		if(emp_s_emp.length>0&&emp_s_date.length>0&&emp_s_time.length>0&&emp_e_date.length>0&&emp_e_time.length>0&&emp_g_date.length>0){
			jQuery.post("/gvo/HRworkflow/getJiaBanInfo.jsp",{'yjqjksrq':emp_s_date,'yjqjjsrq':emp_e_date,'yjqjkssj':emp_s_time,'yjqjjssj':emp_e_time,'gsrq':emp_g_date,'qjr_code':emp_s_emp},function(data){
               // alert(data);
				data = data.replace(/\n/g,"").replace(/\r/g,"");
                eval('var obj ='+data);
                var xss = obj.xss;
              //  alert(xss);
                jQuery(y_jbxss).val(xss);
                //jQuery(y_jbxss+"span").text(xss);
				jQuery(y_jbxss+"span").html(xss);
				jQuery(y_ygxss).val(xss);
                jQuery(y_ygxss+"span").html(xss);
			});
		}
     }
}
function DateDiff(sDate1,sDate2)
{ 
    var arrDate,objDate1,objDate2,intDays;
    arrDate=sDate1.split("-");
    objDate1=new Date(arrDate[1]+'-'+arrDate[2]+'-'+arrDate[0]);
    arrDate=sDate2.split("-");
    objDate2=new Date(arrDate[1] + '-'+arrDate[2]+'-'+arrDate[0]);
    intDays=parseInt((objDate1-objDate2)/1000/60/60/24);
    return intDays;
}
