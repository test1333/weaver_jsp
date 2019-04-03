// GT_人力资源 1.02 加班流程

var s_emp_s  = "field8361_";	//加班人编号
var s_date_s = "field5856_";	//开始日期
var s_time_s = "field5857_";	//开始时间
var e_date_s = "field5858_";	//结束日期
var e_time_s = "field5859_";	//结束时间
var g_date_s = "field8195_";  //归属日期
var y_jbxss_s = "field5868_"; //小时数

function getInfo(){
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
//	jQuery("input[id='"+s_emp_s+nowRow+"']").bind("propertychange",function(){ 	
	jQuery("#"+s_emp_s+nowRow).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp_s  + nowRow;
		var tmp_s_date = "#" + s_date_s + nowRow;
		var tmp_s_time = "#" + s_time_s + nowRow;
		var tmp_e_date = "#" + e_date_s + nowRow;
		var tmp_e_time = "#" + e_time_s + nowRow;
		var tmp_g_date = "#" + g_date_s + nowRow;
		var tmp_y_jbxss = "#" + y_jbxss_s + nowRow;
		
		get_some_Times_s(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss);
	});
	
//	jQuery("input[id='"+s_date_s+nowRow+"']").bind("propertychange",function(){ 
	jQuery("#"+s_date_s+nowRow).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp_s  + nowRow;
		var tmp_s_date = "#" + s_date_s + nowRow;
		var tmp_s_time = "#" + s_time_s + nowRow;
		var tmp_e_date = "#" + e_date_s + nowRow;
		var tmp_e_time = "#" + e_time_s + nowRow;
		var tmp_g_date = "#" + g_date_s + nowRow;
		var tmp_y_jbxss = "#" + y_jbxss_s + nowRow;
		
		get_some_Times_s(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss);
	});
	
//	jQuery("input[id='"+s_time_s+nowRow+"']").bind("propertychange",function(){ 	
	jQuery("#"+s_time_s+nowRow).bindPropertyChange(function () {
		var tmp_s_emp  = "#" + s_emp_s  + nowRow;
		var tmp_s_date = "#" + s_date_s + nowRow;
		var tmp_s_time = "#" + s_time_s + nowRow;
		var tmp_e_date = "#" + e_date_s + nowRow;
		var tmp_e_time = "#" + e_time_s + nowRow;
		var tmp_g_date = "#" + g_date_s + nowRow;
		var tmp_y_jbxss = "#" + y_jbxss_s + nowRow;
		
		get_some_Times_s(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss);
	});
	
//	jQuery("input[id='"+e_date_s+nowRow+"']").bind("propertychange",function(){ 	
	jQuery("#"+e_date_s+nowRow).bindPropertyChange(function () {	
		var tmp_s_emp  = "#" + s_emp_s  + nowRow;
		var tmp_s_date = "#" + s_date_s + nowRow;
		var tmp_s_time = "#" + s_time_s + nowRow;
		var tmp_e_date = "#" + e_date_s + nowRow;
		var tmp_e_time = "#" + e_time_s + nowRow;
		var tmp_g_date = "#" + g_date_s + nowRow;
		var tmp_y_jbxss = "#" + y_jbxss_s + nowRow;
		
		get_some_Times_s(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss);
	});
	
//	jQuery("input[id='"+e_time_s+nowRow+"']").bind("propertychange",function(){ 
	jQuery("#"+e_time_s+nowRow).bindPropertyChange(function () {	
		var tmp_s_emp  = "#" + s_emp_s  + nowRow;
		var tmp_s_date = "#" + s_date_s + nowRow;
		var tmp_s_time = "#" + s_time_s + nowRow;
		var tmp_e_date = "#" + e_date_s + nowRow;
		var tmp_e_time = "#" + e_time_s + nowRow;
		var tmp_g_date = "#" + g_date_s + nowRow;
		var tmp_y_jbxss = "#" + y_jbxss_s + nowRow;
		
		get_some_Times_s(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss);
	});
	
//	jQuery("input[id='"+g_date_s+nowRow+"']").bind("propertychange",function(){ 
	jQuery("#"+g_date_s+nowRow).bindPropertyChange(function () {	
		
		var tmp_s_emp  = "#" + s_emp_s  + nowRow;
		var tmp_s_date = "#" + s_date_s + nowRow;
		var tmp_s_time = "#" + s_time_s + nowRow;
		var tmp_e_date = "#" + e_date_s + nowRow;
		var tmp_e_time = "#" + e_time_s + nowRow;
		var tmp_g_date = "#" + g_date_s + nowRow;
		var tmp_y_jbxss = "#" + y_jbxss_s + nowRow;
		
		get_some_Times_s(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_g_date,tmp_y_jbxss);
	});
}
	

function get_some_Times_s(s_emp,s_date,s_time,e_date,e_time,g_date,y_jbxss){
	if(jQuery(s_emp).length>0&&jQuery(s_date).length>0&&jQuery(e_date).length>0&&jQuery(s_time).length>0&&jQuery(e_time).length>0&&jQuery(g_date).length>0){
		var emp_s_emp = jQuery(s_emp).val();
		var emp_s_date = jQuery(s_date).val();
		var emp_s_time = jQuery(s_time).val();
		var emp_e_date = jQuery(e_date).val();
 		var emp_e_time = jQuery(e_time).val();
 		var emp_g_date = jQuery(g_date).val();
		
		if(emp_s_emp.length>0&&emp_s_date.length>0&&emp_s_time.length>0&&emp_e_date.length>0&&emp_e_time.length>0&&emp_g_date.length>0){
			jQuery.post("/gvo/HRworkflow/getJiaBanInfo.jsp",{'yjqjksrq':emp_s_date,'yjqjjsrq':emp_e_date,'yjqjkssj':emp_s_time,'yjqjjssj':emp_e_time,'gsrq':emp_g_date,'qjr_code':emp_s_emp},function(data){
  //              alert(data);
				data = data.replace(/\n/g,"").replace(/\r/g,"");
                eval('var obj ='+data);
                var xss = obj.xss;
                jQuery(y_jbxss).val(xss);
                jQuery(y_jbxss+"span").html(xss);
			});
		}
     }
}
