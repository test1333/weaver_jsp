<script type="text/javascript">
var qjr_code = "#field27310_";//人员工号

var yjqjksrq = "#field27315_";//实际请假开始日期
var yjqjjsrq = "#field27319_";//实际请假结束日期
var yjqjkssj = "#field27316_";//实际请假开始时间
var yjqjjssj = "#field27320_";//实际结束开始时间
var xjlxbm = "#field27312_";//休假类型编码
var yjsjxss = "#field27322_";//实际休假小时数
var qjlx = "#field27312_";// 请假类型
var yjqjxss = "#field27321_";//预计请假小时数
var njwxxsh = "#field30598_";//年假未休小时数
var tsjwxxsh = "#field30599_";//调休假未休小时数
var sjqjxss = "#field27322_";//实际请假小时数	
var gzxz = "#field31504_";//工作性质等于A或B
var jb = "#field27312_";//请假类型
var qjxs = "#field27322_";//实际请假小时
var fjsc = "field27308";//有效证明文件
var fjsc1 = "field_27308";//有效证明文件
var kqsp = "#field33628";//是否考勤审批
var s_emp = "#field27311_";	//请假人

jQuery(document).ready(function(){
	var indexnum0 = jQuery("#indexnum0").val();
       	  for (var index1= 0; index1 < indexnum0; index1++) {
           		 if (jQuery(qjr_code + index1).length > 0) {
           			jQuery(yjsjxss+index1).attr("readonly",true);
           		 	 bindchange(index1);
        		}
        	}
        		checkdata();
				checkdata1();
     checkCustomize = function(){ 
     var needcheck = document.all("needcheck");
       if(needcheck.value.indexOf(fjsc)>=0){
	       var fjsc_val= jQuery("#"+fjsc).val();
	       if(fjsc_val =="" || fjsc_val =="null"){
		       jQuery("#"+fjsc).val("");
		        jQuery(".progressBarStatus").each(function(){
				if($(this).html().indexOf("Pending")>=0){
				   jQuery("#"+fjsc).val("null");	
			      }
			})
       	 } 
       }
       var indexnum1 = jQuery("#indexnum0").val();
      for (var index2= 0; index2 < indexnum1; index2++) {   
         if (jQuery(qjr_code + index2).length > 0) {
         	 	var qjr_code_val=jQuery(qjr_code + index2).val();
		var qjlx_val = jQuery(qjlx+index2).val();
		var yjqjxss_val = jQuery(yjqjxss+index2).val();
		var njwxxsh_val = jQuery(njwxxsh+index2).val();
		var tsjwxxsh_val = jQuery(tsjwxxsh+index2).val();
		var sjqjxss_val = jQuery(sjqjxss+index2).val();
		var gzxz_val = jQuery(gzxz+index2).val();
		var result = true; 
//		alert(tszt_val);
        if (Number(sjqjxss_val)<=0) {
					window.top.Dialog.alert("实际请假小时数要大于0！");
					result = false;
					break;
				}
		if(qjlx_val == "L_001" || qjlx_val == "L_002"
						|| qjlx_val == "L_003" || qjlx_val == "L_005"
						|| qjlx_val == "L_007" || qjlx_val == "L_012"
						|| gzxz_val == "A" || gzxz_val == "B"){
			if(qjlx_val == "L_002"){
				if(Number(sjqjxss_val)>Number(tsjwxxsh_val)){
					window.top.Dialog.alert("当前请假小时数大于剩余调休假");
					result = false;
						break;
				}else if(Number(sjqjxss_val)<1){
					window.top.Dialog.alert("当前调休假请假小时数小于1小时");
					result = false;
						break;
				}
				var context=checkcfdata(index2+1,sjqjxss,sjqjxss_val,tsjwxxsh_val,qjr_code_val,qjlx_val);
				if(context == "1"){
						window.top.Dialog.alert("当前请假小时数大于剩余调休假");
						result = false;
						break;
			        }
			}
			if(qjlx_val == "L_001"){
				if(Number(sjqjxss_val)>Number(njwxxsh_val)){
					window.top.Dialog.alert("当前请假小时数大于剩余年假");
					result = false;
						break;
				}else if(Number(sjqjxss_val)<3.5){
					window.top.Dialog.alert("当前请假小时数小于3.5小时");
					result = false;
						break;
				}
				var context=checkcfdata(index2+1,sjqjxss,sjqjxss_val,njwxxsh_val,qjr_code_val,qjlx_val);
				if(context == "1"){
						window.top.Dialog.alert("当前请假小时数大于剩余年假");
						result = false;
						break;
			        }
			}
			// L_003事假
			if (qjlx_val == "L_003") {
				if (Number(sjqjxss_val) > 120) {
					 //alert("当前请假小时数超出规定！");
					 result = true;
				}else if(Number(sjqjxss_val)<1){
					window.top.Dialog.alert("当前事假请假小时数小于1小时")			;
					result = false;
						break;
			    }
			}
			
			
		}
	
		var s_emp_val= jQuery(s_emp+index2).val();
		var s_date_val=jQuery(yjqjksrq+index2).val();
		var s_time_val=jQuery(yjqjkssj+index2).val();
		var e_date_val=jQuery(yjqjjsrq+index2).val();
		var e_time_val=jQuery(yjqjjssj+index2).val();
		var s_begin_val=s_date_val+' '+s_time_val;
		var s_end_val=e_date_val+' '+e_time_val;
		if(s_emp_val !=''){
		  if(!checktimeinner(index2+1,s_emp_val,s_begin_val,s_end_val)){

		  	  alert("工号为"+qjr_code_val+"的员工实际开始时间为\""+s_begin_val+"\"的记录存在请假时间冲突，请检查");
		  	  return false;
		  }	  
		}	
	}
}
		return result;
	}	

})
function checkcfdata(startindex,checkfield,checkval,ckeckallval,workcode,qjlx1){
	 if(checkval == ''){
     	  checkval = "0"; 	 
       }
      if(ckeckallval == ''){
     	ckeckallval = "0"; 	 
    	}
	 var indexnum0 = jQuery("#indexnum0").val();
	 var values=checkval;
     for (var index2= startindex; index2 < indexnum0; index2++) {   
        if (jQuery(qjr_code + index2).length > 0) {
     	 var checkfield_val= jQuery(checkfield+index2).val();
     	 if(checkfield_val == ''){
     	  checkfield_val = "0"; 	 
     	}
     	 var qjr_code_val=jQuery(qjr_code + index2).val();
     	 var qjlx_val = jQuery(qjlx+index2).val();
     	if(qjr_code_val == workcode && qjlx_val==qjlx1){    		
     	 	values=accAdd(values,checkfield_val);
     	}
       } 
     }
     if(Number(values)>Number(ckeckallval)){
     	 return "1";
    }
    return "0";
}
function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
} 	
	function checktimeinner(startindex,qjr,begin,end){
    var indexnum0 = jQuery("#indexnum0").val();
     for (var index2= startindex; index2 < indexnum0; index2++) {   
         if (jQuery(qjr_code + index2).length > 0) {
         	var s_emp_val= jQuery(s_emp+index2).val();
		var s_date_val=jQuery(yjqjksrq+index2).val();
		var s_time_val=jQuery(yjqjkssj+index2).val();
		var e_date_val=jQuery(yjqjjsrq+index2).val();
		var e_time_val=jQuery(yjqjjssj+index2).val();
		var s_begin_val=s_date_val+' '+s_time_val;
		var s_end_val=e_date_val+' '+e_time_val;
         	 	if(qjr ==s_emp_val ){
         	 		if(s_begin_val < end && s_end_val > begin){
         	 		  return false;	
         	 		}	
         	      }else{
         	      continue;
         	      }
         }
    }
    return true;
}	
function bindchange(index){
	jQuery(yjqjksrq+index).bindPropertyChange(function(){ 
		getyjsjxss(index);
	})
	jQuery(yjqjkssj+index).bindPropertyChange(function(){ 
		getyjsjxss(index);
	})
	jQuery(yjqjjssj+index).bindPropertyChange(function(){ 
		getyjsjxss(index);
	})
	jQuery(yjqjjsrq+index).bindPropertyChange(function(){ 
		getyjsjxss(index);
	})
	jQuery(xjlxbm+index).bindPropertyChange(function(){ 
		getyjsjxss(index);
	})
	 jQuery(qjxs+index).bindPropertyChange(function(){
		checkdata();
	});	

    jQuery(jb+index).bindPropertyChange(function(){
		checkdata();
	});	
	jQuery(qjxs+index).bindPropertyChange(function(){
		checkdata1();
	});	

    jQuery(jb+index).bindPropertyChange(function(){
		checkdata1();
	});	
}
function getyjsjxss(index){
		var qjr_code_1 = jQuery(qjr_code+index).val();
		var yjqjksrq1 = jQuery(yjqjksrq+index).val();
		var yjqjjsrq1 = jQuery(yjqjjsrq+index).val();
		var yjqjkssj1 = jQuery(yjqjkssj+index).val();
		var yjqjjssj1 = jQuery(yjqjjssj+index).val();
		var xjlxbm1 = jQuery(xjlxbm+index).val();
		if(yjqjksrq1.length>0&&yjqjjsrq1.length>0&&yjqjkssj1.length>0&&yjqjjssj1.length>0&&xjlxbm1.length>0){
			jQuery.post("/gvo/HRworkflow/getTimeInfo.jsp",{'yjqjksrq':yjqjksrq1,'yjqjjsrq':yjqjjsrq1,'yjqjkssj':yjqjkssj1,'yjqjjssj':yjqjjssj1,'xjlxbm':xjlxbm1,'qjr_code':qjr_code_1},function(data){
//                   alert(data);
				   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss+index).val(xss);
//                   jQuery(yjsjxss+"span").html(xss);
			});
		}
}
function checkdata()
	{
	var indexnum1 = jQuery("#indexnum0").val();
      for (var index2= 0; index2 < indexnum1; index2++) {   
         if (jQuery(qjr_code + index2).length > 0) {
		var jb_val = jQuery(jb+index2).val();//病假 L_004
		var qjxs_val = jQuery(qjxs+index2).val();
		var needcheck = document.all("needcheck");
		//alert(jb_val);
		
		if((jb_val == "L_004" && Number(qjxs_val) > 8) || jb_val == "L_005" || jb_val == "L_006" || jb_val == "L_007" || jb_val == "L_008" || jb_val == "L_015" || jb_val == "L_012")
		{
		    if(jQuery("#"+fjsc).length>0)
		    {
		      var fjsc_val= jQuery("#"+fjsc).val(); 
		          if(fjsc_val =="" || fjsc_val =="null"){	 
		        document.all(fjsc1+"span").innerHTML = "(必填)";
		    }
			    if(needcheck.value.indexOf(fjsc)<0)
		        { 
			        if(needcheck.value!='')
				        needcheck.value += ",";
                        needcheck.value += fjsc;				   
		        }	
		        return;
            }
		}
        else{
		    if(needcheck.value.indexOf(fjsc)>=0)
		    {  //如果非必填项，则加入必填项判断
				needcheck.value=needcheck.value.replace(","+fjsc,"");  //可编辑				
		        document.all(fjsc1+"span").innerHTML = "";// 值清空
		        jQuery("#"+fjsc).val("");
			}
		}		
}
}
	}
	
function checkdata1()
	{
	var indexnum1 = jQuery("#indexnum0").val();
      for (var index2= 0; index2 < indexnum1; index2++) {   
         if (jQuery(qjr_code + index2).length > 0) {
		var jb_val = jQuery(jb+index2).val();//病假 L_004
		var qjxs_val = jQuery(qjxs+index2).val();
		var needcheck = document.all("needcheck");
		//alert(jb_val);
		if(Number(qjxs_val) > 40 ||  (jb_val == "L_004" && Number(qjxs_val) > 8) || jb_val == "L_005" || jb_val == "L_006" || jb_val == "L_007" || jb_val == "L_008" || jb_val == "L_015" || jb_val == "L_012" || jb_val == "L_019")
		{
		   jQuery(kqsp).val("是");
           index2=indexnum1;
		}
		else{
			jQuery(kqsp).val("否");	
		}
}
}
	}
</script>



