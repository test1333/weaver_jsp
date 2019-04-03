// AM_人事类 1.02 加班流程

var s_emp  = "field5854_";	//请假人
var s_date = "field5856_";	//开始日期
var s_time = "field5857_";	//开始时间
var e_date = "field5858_";	//结束日期
var e_time = "field5859_";	//结束时间

function test1(){
	
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
	jQuery("input[id='"+s_emp+nowRow+"']").bind("propertychange",function(){ 
		var change_val = "0";
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		change_val = checkSameRep(nowRow);
//		alert("s_emp change !! ret_val = " + ret_val);
		if(change_val == "0"){
			change_val = get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
		}
		
		if(change_val == "1"){
			checkSomeVal(nowRow);
		}
	});
	
	jQuery("input[id='"+s_date+nowRow+"']").bind("propertychange",function(){ 	
		var	change_val = "0";
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		change_val = checkSameRep(nowRow);
//		alert("s_emp change !! ret_val = " + ret_val);
		if(change_val == "0"){
			change_val = get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
		}
		
		if(change_val == "1"){
			checkSomeVal(nowRow);
		}
	});
	
	jQuery("input[id='"+s_time+nowRow+"']").bind("propertychange",function(){ 	
		var change_val = "0";
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		change_val = checkSameRep(nowRow);
//		alert("s_emp change !! ret_val = " + ret_val);
		if(change_val == "0"){
			change_val = get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
		}
		
		if(change_val == "1"){
			checkSomeVal(nowRow);
		}
	});
	
	jQuery("input[id='"+e_date+nowRow+"']").bind("propertychange",function(){ 	
		var change_val = "0";
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		change_val = checkSameRep(nowRow);
//		alert("s_emp change !! ret_val = " + ret_val);
		if(change_val == "0"){
			change_val = get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
		}
		
		if(change_val == "1"){
			checkSomeVal(nowRow);
		}
	});
	
	jQuery("input[id='"+e_time+nowRow+"']").bind("propertychange",function(){ 	
		var change_val = "0";
		var tmp_s_emp  = "#" + s_emp  + nowRow;
		var tmp_s_date = "#" + s_date + nowRow;
		var tmp_s_time = "#" + s_time + nowRow;
		var tmp_e_date = "#" + e_date + nowRow;
		var tmp_e_time = "#" + e_time + nowRow;
		
		change_val = checkSameRep(nowRow);
//		alert("s_emp change !! ret_val = " + ret_val);
		if(change_val == "0"){
			change_val = get_some_Times(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time);
		}
		
		if(change_val == "1"){
			checkSomeVal(nowRow);
		}
	});
}

function get_some_Times(s_emp,s_date,s_time,e_date,e_time){
	var tmp_val = "0";
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
							//	alert("text = " + text);
							//	alert(text);
								if(text == 'N'){
									tmp_val = "1";
								}
								//else{
								//	alert("重复性检查完毕，没有重复，可以继续填写申请！！ ");
						//}
							}
						}
					}
				xhr.send(null);
			}
		}
     }
     return tmp_val;
}

function checkSameRep(index){
	var tmp_val = "0";
	var tmp_tmp = "0";
	var tmp_emp_now = jQuery("#"+s_emp + index).val();
	var tmp_s_date_now = jQuery("#"+ s_date + index).val();
	var tmp_s_time_now = jQuery("#"+ s_time + index).val();
	var tmp_e_date_now = jQuery("#"+ e_date + index).val();
	var tmp_e_time_now = jQuery("#"+ e_time + index).val();
	
	var tmp_s_time_now_1 = tmp_s_date_now + " " + tmp_s_time_now;
	var tmp_e_time_now_1 = tmp_e_date_now + " " + tmp_e_time_now;
	
	if(tmp_s_date_now.length>0&&tmp_s_time_now.length>0&&tmp_e_date_now.length>0&&tmp_e_time_now.length>0){
		tmp_tmp = "1";
	}
//	alert("tmp_tmp = " + tmp_tmp );
	
	for(var i=0;i<=100;i++){
		
		if(i!=index&&jQuery("#"+s_emp + i).length>0){
			var tmp_emp_i = jQuery("#"+s_emp + i).val();
			if(tmp_emp_now == tmp_emp_i){
				var tmp_s_date_i = jQuery("#"+ s_date + i).val();
				var tmp_s_time_i = jQuery("#"+ s_time + i).val();
				var tmp_e_date_i = jQuery("#"+ e_date + i).val();
				var tmp_e_time_i = jQuery("#"+ e_time + i).val();
				
				var tmp_s_time_now_i = tmp_s_date_i + " " + tmp_s_time_i;
				var tmp_e_time_now_i = tmp_e_date_i + " " + tmp_e_time_i;
				
				if(tmp_tmp == "1"){
			//		alert(tmp_e_time_now_i + " : " + tmp_s_time_now_1 + " res = " + (tmp_e_time_now_i < tmp_s_time_now_1));
			//		alert(tmp_s_time_now_i + " : " + tmp_e_time_now_1 + " res = " + (tmp_s_time_now_i > tmp_e_time_now_1));
					if(tmp_e_time_now_i < tmp_s_time_now_1 || tmp_s_time_now_i > tmp_e_time_now_1){
						tmp_val = "0";
					}else{
						i==101;
						tmp_val = "1";
					}
				}
				
			}
		}else{
			i = 101;
		}
	}
	return tmp_val;
}

function checkSomeVal(index){
	var tmp_s_emp  = "#" + s_emp  + index;
	var tmp_s_date = "#" + s_date + index;
	var tmp_s_time = "#" + s_time + index;
	var tmp_e_date = "#" + e_date + index;
	var tmp_e_time = "#" + e_time + index;
	
	alert("重复性检查完毕，出现重复性时间，请重新填写时间内容！！");
	
	jQuery(tmp_s_date).val("");jQuery(tmp_s_date+"span").html("");
	jQuery(tmp_s_time).val("");jQuery(tmp_s_time+"span").html("");
	jQuery(tmp_e_date).val("");jQuery(tmp_e_date+"span").html("");
	jQuery(tmp_e_time).val("");jQuery(tmp_e_time+"span").html("");
}