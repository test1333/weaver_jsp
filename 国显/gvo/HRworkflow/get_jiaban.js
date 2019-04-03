// GT_人力资源 1.02 加班流程

var s_emp  = "field5854_";	//加班人
var s_date = "field5856_";	//开始日期
var s_time = "field5857_";	//开始时间
var e_date = "field5858_";	//结束日期
var e_time = "field5859_";	//结束时间

function test1(){
	
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
	jQuery("input[id='"+s_emp+nowRow+"']").bind("propertychange",function(){ 	
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
	});
	
	jQuery("input[id='"+s_date+nowRow+"']").bind("propertychange",function(){ 	
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
	});
	
	jQuery("input[id='"+s_time+nowRow+"']").bind("propertychange",function(){ 	
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
	});
	
	jQuery("input[id='"+e_date+nowRow+"']").bind("propertychange",function(){ 	
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
	});
	
	jQuery("input[id='"+e_time+nowRow+"']").bind("propertychange",function(){ 	
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
	});
}

function get_some_Times(s_emp,s_date,s_time,e_date,e_time){
	
	
	if(jQuery(s_emp).length>0&&jQuery(s_date).length>0&&jQuery(e_date).length>0&&jQuery(s_time).length>0&&jQuery(e_time).length>0){
		var emp_s_emp = jQuery(s_emp).val();
		var emp_s_date = jQuery(s_date).val();
		var emp_s_time = jQuery(s_time).val();
		var emp_e_date = jQuery(e_date).val();
 		var emp_e_time = jQuery(e_time).val();
		
		if(emp_s_emp.length>0&&emp_s_date.length>0&&emp_s_time.length>0&&emp_e_date.length>0&&emp_e_time.length>0){
			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器  
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}
			if (null != xhr) {
				var timestamp=new Date().getTime();
				var postStr = "ranTime="+timestamp+"&emp_id="+emp_s_emp+"&start_day="+emp_s_date+"&start_time="+emp_s_time+"&end_day="+emp_e_date+"&end_time="+emp_e_time;
			//	alert("12233 = " + postStr );
				xhr.open("GET","/gvo/hrm/Gvo_LB_1.jsp?"+postStr, false);
				
				xhr.onreadystatechange =	function () {
						
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								
							//	alert(text);
								if(text == 'N'){
									window.top.Dialog.alert("重复性检查完毕，出现重复性时间，请重新填写时间内容！！");
									
									jQuery(s_date).val("");jQuery(s_date+"span").html("");
									jQuery(s_time).val("");jQuery(s_time+"span").html("");
									jQuery(e_date).val("");jQuery(e_date+"span").html("");
									jQuery(e_time).val("");jQuery(e_time+"span").html("");
									
								}else{
									window.top.Dialog.alert("重复性检查完毕，没有重复，可以继续填写申请！！ ");
								}
							}
						}
					}
				xhr.send(null);
			}
				
			
		}
     }
}
