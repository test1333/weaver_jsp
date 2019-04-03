// AM_人事类 1.02 加班流程

var s_emp_tid  = "field8361_";	//加班人编号
var s_date_tid = "field5860_";	//开始日期
var s_time_tid = "field5861_";	//开始时间
var e_date_tid = "field5862_";	//结束日期
var e_time_tid = "field5863_";	//结束时间
var s_dt_tid = "dtl_id_0_"

setTimeout("deal_0()",2000);

function deal_0(){
	for(var index=0;index<100;index++){
		if(jQuery("#"+s_emp_tid+index).length > 0){
			deal_1(index);
		}else{
			index = 101;
		}
	}
}

function deal_1(nowRow){
		
	jQuery("#"+s_date_tid+nowRow).bindPropertyChange(function(){ 
		deal_2(nowRow);
	});
	
	jQuery("#"+s_time_tid+nowRow).bindPropertyChange(function(){ 
		deal_2(nowRow);
	});
	
	jQuery("#"+e_date_tid+nowRow).bindPropertyChange(function(){ 
		deal_2(nowRow);
	});
	
	jQuery("#"+e_time_tid+nowRow).bindPropertyChange(function(){ 
		deal_2(nowRow);
	});
}

function deal_2(nowRow){
	var change_val = "0";
	var tmp_s_emp  = "#" + s_emp_tid  + nowRow;
	var tmp_s_date = "#" + s_date_tid + nowRow;
	var tmp_s_time = "#" + s_time_tid + nowRow;
	var tmp_e_date = "#" + e_date_tid + nowRow;
	var tmp_e_time = "#" + e_time_tid + nowRow;
	var tmp_s_dt = "[name='"+s_dt_tid + nowRow+"']";
	change_val = deal_4(nowRow);

	if(change_val == "0"){
		change_val = deal_3(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_s_dt);
	}
	if(change_val == "1"){
		deal_5(nowRow);
	}
}

function deal_3(tmp_s_emp,tmp_s_date,tmp_s_time,tmp_e_date,tmp_e_time,tmp_s_dt){
	var tmp_val = "0";
	var emp_s_emp = jQuery(tmp_s_emp).val();
	var emp_s_date = jQuery(tmp_s_date).val();
	var emp_s_time = jQuery(tmp_s_time).val();
	var emp_e_date = jQuery(tmp_e_date).val();
 	var emp_e_time = jQuery(tmp_e_time).val();
 	
 	var s_idiid = jQuery(tmp_s_dt).val();;
 	
 //	alert("s_idiid = " + s_idiid);
 		 
 	var s_requestid = jQuery("#requestid").val();
//	alert("deal_3_1" + " ; emp_s_emp = " + emp_s_emp + " ; emp_s_date = " + emp_s_date + " ; emp_s_time = " 
//		+ emp_s_time +" ; emp_e_date = " +emp_e_date + " ; emp_e_time = " + emp_e_time +" ; s_requestid = " + s_requestid );
	if(emp_s_emp.length>0&&emp_s_date.length>0&&emp_s_time.length>0&&emp_e_date.length>0&&emp_e_time.length>0&&s_requestid.length>0){
			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器  
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}

			if (null != xhr) {
				var timestamp=new Date().getTime();
				var postStr = "ranTime="+timestamp+"&requestID="+s_requestid+"&dtID="+s_idiid+"&empcode="+emp_s_emp
					+"&s_date="+emp_s_date+"&e_date="+emp_e_date+"&s_time="+emp_s_time+"&e_time="+emp_e_time;
				xhr.open("GET","/gvo/hrm/getJiaBanInfo.jsp?"+postStr, false);
				
				xhr.onreadystatechange =	function () {
						
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						//		alert("text = " + text);
								if(text == '1'){tmp_val = "1";}
							}
						}
				}
			xhr.send(null);
		  }
	}
	return tmp_val;
}

function deal_4(index){
	var tmp_val = "0";
	var tmp_tmp = "0";
	var tmp_emp_now = jQuery("#"+s_emp_tid + index).val();
	var tmp_s_date_now = jQuery("#"+ s_date_tid + index).val();
	var tmp_s_time_now = jQuery("#"+ s_time_tid + index).val();
	var tmp_e_date_now = jQuery("#"+ e_date_tid + index).val();
	var tmp_e_time_now = jQuery("#"+ e_time_tid + index).val();
	
	var tmp_s_time_now_1 = tmp_s_date_now + " " + tmp_s_time_now;
	var tmp_e_time_now_1 = tmp_e_date_now + " " + tmp_e_time_now;
	
	if(tmp_s_date_now.length>0&&tmp_s_time_now.length>0&&tmp_e_date_now.length>0&&tmp_e_time_now.length>0){
		tmp_tmp = "1";
	}

	for(var i=0;i<=100;i++){
		
		if(i!=index&&jQuery("#"+s_emp_tid + i).length>0){
			var tmp_emp_i = jQuery("#"+s_emp_tid + i).val();
			if(tmp_emp_now == tmp_emp_i){
				var tmp_s_date_i = jQuery("#"+ s_date_tid + i).val();
				var tmp_s_time_i = jQuery("#"+ s_time_tid + i).val();
				var tmp_e_date_i = jQuery("#"+ e_date_tid + i).val();
				var tmp_e_time_i = jQuery("#"+ e_time_tid + i).val();
				
				var tmp_s_time_now_i = tmp_s_date_i + " " + tmp_s_time_i;
				var tmp_e_time_now_i = tmp_e_date_i + " " + tmp_e_time_i;
				
				if(tmp_tmp == "1"){
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

function deal_5(index){
	var tmp_s_emp  = "#" + s_emp  + index;
	var tmp_s_date = "#" + s_date + index;
	var tmp_s_time = "#" + s_time + index;
	var tmp_e_date = "#" + e_date + index;
	var tmp_e_time = "#" + e_time + index;
	
	window.top.Dialog.alert("重复性检查完毕，出现重复性时间，请重新填写时间内容！！");
	
	jQuery(tmp_s_date).val("");jQuery(tmp_s_date+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'/>");
	jQuery(tmp_s_time).val("");jQuery(tmp_s_time+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'/>");
	jQuery(tmp_e_date).val("");jQuery(tmp_e_date+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'/>");
	jQuery(tmp_e_time).val("");jQuery(tmp_e_time+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'/>");
}
