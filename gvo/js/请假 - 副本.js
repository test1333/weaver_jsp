<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var qjr_code = "#field27310_";//人员工号
var nyyxxss = "#field30602_"; //年假本年新增小时
var nyyxxss1 = "#field30600_"; //年假本年已休小时
var nywxxss = "#field30598_"; //年假本年未休小时
	

var txjyxxss = "#field30603_"; //调休假本年应休小时
var txjyxxss1 = "#field30601_"; //调休假本年已休小时
var txjwxxss = "#field30599_"; //调休假本年未休小时

var yjqjksrq = "#field27313_";//预计请假开始日期
var yjqjjsrq = "#field27317_";//预计请假结束日期
var yjqjkssj = "#field27314_";//预计请假开始时间
var yjqjjssj = "#field27318_";//预计结束开始时间
var xjlxbm = "#field27312_";//休假类型编码
var yjsjxss = "#field27321_";//预计休假小时数

// var njyy_id = "#field17059";
var njjy_id = "#field30604_"; //年假上年顺延时数
var njgq_id = "#field30606_";  //年假过期时数

// var txyy_id = "#field17060";
var txjy_id = "#field30605_";  //调休假上年结转时数
var txgq_id = "#field30607_";  //调休假过期时数


var yjsjxss_1 = "field27321_";//预计休假小时数
var s_emp = "#field27311_";	//请假人
var s_date= "#field27313_";	//开始日期
var s_time= "#field27314_";	//开始时间
var e_date= "#field27317_";	//结束日期
var e_time= "#field27318_";	//结束时间
var hoiTYPE  = "#field27312_";     // 请假类型
var njwgdxss="#field30608_";//年假未归档小时数
var txwgdxss="#field30609_";//调休未归档小时数
	 jQuery("button[name=addbutton0]").live("click", function () {
         var indexnum = jQuery("#indexnum0").val();
         gethistoryinfo(indexnum-1);
         bindchange(indexnum-1);
    });
jQuery(document).ready(function(){
	var qjlx = "#field27312_";// 请假类型
	var yjqjxss = "#field27321_";//预计请假小时数
	var njwxxsh = "#field30598_";//年假剩余小时数
	var tsjwxxsh = "#field30599_";//调休剩余休小时数
	var gzxz = "#field31504_";//工作性质等于A或B
	setTimeout('initbind()', 1000);

       checkCustomize = function(){ 
      //调用字段联动方法防止数据为空也进行了提交
                  if(!checkdatainput()){
                    return false;
                 }
       	var indexnum1 = jQuery("#indexnum0").val();
      for (var index2= 0; index2 < indexnum1; index2++) {   
         if (jQuery(qjr_code + index2).length > 0) {
		var qjlx_val = jQuery(qjlx+index2).val();
		var yjqjxss_val = jQuery(yjqjxss+index2).val();
		var njwxxsh_val = jQuery(njwxxsh+index2).val();
		var tsjwxxsh_val = jQuery(tsjwxxsh+index2).val();
		var gzxz_val = jQuery(gzxz+index2).val();
		var result = true; 
		//alert(111111);
        if (Number(yjqjxss_val)<=0) {
					window.top.Dialog.alert("预计请假小时数要大于0！");
					result = false;
					break;
				}
					//alert(qjlx_val);
		if(qjlx_val == "L_001" || qjlx_val == "L_002"
						|| qjlx_val == "L_003" || qjlx_val == "L_005"
						|| qjlx_val == "L_007" || qjlx_val == "L_012"
						|| gzxz_val == "A" || gzxz_val == "B"){
			if(qjlx_val == "L_002"){
				//alert("1");
				//alert(yjqjxss_val);
				//alert(tsjwxxsh_val);
				if(Number(yjqjxss_val)>Number(tsjwxxsh_val)){
					window.top.Dialog.alert("当前请假小时数大于剩余调休假");
					result = false;
					break;
				}else if(Number(yjqjxss_val)<1){
					window.top.Dialog.alert("当前调休假请假小时数小于1小时");
					result = false;
					break;
				}
			}
			if(qjlx_val == "L_001"){
				if(Number(yjqjxss_val)>Number(njwxxsh_val)){
					window.top.Dialog.alert("当前请假小时数大于剩余年假");
					result = false;
					break;
				}else if(Number(yjqjxss_val)<3.5){
					window.top.Dialog.alert("当前请假小时数小于3.5小时");
					result = false;
					break;
				}
			}
			// L_003事假
			if (qjlx_val == "L_003") {
				if (Number(yjqjxss_val) > 120) {
					 //alert("当前请假小时数超出规定！");
					 result = true;
				}else if(Number(yjqjxss_val)<1){
					window.top.Dialog.alert("当前事假请假小时数小于1小时")			;
					result = false;
					break;
			    }
			}		
		}
		var qjr_code_val=jQuery(qjr_code + index2).val();
		var s_emp_val= jQuery(s_emp+index2).val();
		var s_date_val=jQuery(s_date+index2).val();
		var s_time_val=jQuery(s_time+index2).val();
		var e_date_val=jQuery(e_date+index2).val();
		var e_time_val=jQuery(e_time+index2).val();
		var s_begin_val=s_date_val+' '+s_time_val;
		var s_end_val=e_date_val+' '+e_time_val;
		if(s_emp_val !=''){
		  if(!checktimeinner(index2+1,s_emp_val,s_begin_val,s_end_val)){

		  	  alert("工号为"+qjr_code_val+"的员工预计开始时间为\""+s_begin_val+"\"的记录存在请假时间冲突，请检查");
		  	  return false;
		  }	  
		}	
		
		}
	}
		return result;
	}		
		
});
//防止字段联动没联动出来数据也进行了提交
function checkdatainput(){
    try {
         if(!!!jQuery("#field27298").val()||!!!jQuery("#field27297").val()||!!!jQuery("#field27304").val()){
               alert("申请人所在部门或者所在单位或者岗位无数据,请重新填写申请人！");
               return false;
           }
            
        } catch (error) {
            if(window.console)console.log(error);
            return true;
        }
        return true;

}

function checktimeinner(startindex,qjr,begin,end){
    var indexnum0 = jQuery("#indexnum0").val();
     for (var index2= startindex; index2 < indexnum0; index2++) {   
         if (jQuery(qjr_code + index2).length > 0) {
         	 var s_emp_val= jQuery(s_emp+index2).val();
         	 var s_date_val=jQuery(s_date+index2).val();
		var s_time_val=jQuery(s_time+index2).val();
		var e_date_val=jQuery(e_date+index2).val();
		var e_time_val=jQuery(e_time+index2).val();
		var s_begin_val=s_date_val+' '+s_time_val;
		var s_end_val=e_date_val+' '+e_time_val;
         	 	if(qjr ==s_emp_val ){
         	 		if(s_begin_val <end && s_end_val >begin){
         	 		  return false;	
         	 		}	
         	      }else{
         	      continue;
         	      }
         }
    }
    return true;
}	
function gethistoryinfo(index){
    jQuery(qjr_code+index).bindPropertyChange(function(){ 
             
		var qjr_code_1 = jQuery(qjr_code+index).val();
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
                   var njwgdxss_val = jQuery(njwgdxss+index).val()
                   var nywxxss_val=Number(totalValue1)-Number(userValue1)+Number(forwardVaule1)-Number(expiedValue1)-Number(njwgdxss_val);
              
 			 var txwgdxss_val = jQuery(txwgdxss+index).val()
                   var txjwxxss_val=Number(totalValue2)-Number(userValue2)+Number(forwardVaule2)-Number(expiedValue2)-Number(txwgdxss_val);
         
                    jQuery(nywxxss+index).val(nywxxss_val.toFixed(1));
                   jQuery(nywxxss+index+"span").text(nywxxss_val.toFixed(1));
                    jQuery(txjwxxss+index).val(txjwxxss_val.toFixed(1));
                   jQuery(txjwxxss+index+"span").text(txjwxxss_val.toFixed(1));
                   
                   jQuery(nyyxxss+index).val(totalValue1);
                   jQuery(nyyxxss+index+"span").text(totalValue1);
                   jQuery(nyyxxss1+index).val(userValue1);
                   jQuery(nyyxxss1+index+"span").text(userValue1);
                 //  jQuery(nywxxss).val(labelVale1);
                 //  jQuery(nywxxss+"span").text(labelVale1);
                   
                   jQuery(txjyxxss+index).val(totalValue2);
                   jQuery(txjyxxss+index+"span").text(totalValue2);
                   jQuery(txjyxxss1+index).val(userValue2);
                   jQuery(txjyxxss1+index+"span").text(userValue2);
                  // jQuery(txjwxxss).val(labelVale2);
                  // jQuery(txjwxxss+"span").text(labelVale2);
                  
                 //  alter(njjy_id);
                   jQuery(njjy_id+index).val(forwardVaule1);
                   jQuery(njjy_id+index+"span").text(forwardVaule1);
                   jQuery(njgq_id+index).val(expiedValue1);
                   jQuery(njgq_id+index+"span").text(expiedValue1);
                   jQuery(txjy_id+index).val(forwardVaule2);
                   jQuery(txjy_id+index+"span").text(forwardVaule2);
                   jQuery(txgq_id+index).val(expiedValue2);
                   jQuery(txgq_id+index+"span").text(expiedValue2);
                    
			});
		}
	})
}
function bindchange(index){
	jQuery(yjqjksrq+index).bindPropertyChange(function(){ 
		getyjsjxss(index)
	})
	jQuery(yjqjkssj+index).bindPropertyChange(function(){ 
		getyjsjxss(index)
	})
	jQuery(yjqjjssj+index).bindPropertyChange(function(){ 
		getyjsjxss(index)
	})
	jQuery(yjqjjsrq+index).bindPropertyChange(function(){ 
		getyjsjxss(index)
	})
	jQuery(xjlxbm+index).bindPropertyChange(function(){ 
		getyjsjxss(index)
	})
	jQuery(njwgdxss+index).bindPropertyChange(function(){ 
	  var njwgdxss_val = jQuery(njwgdxss+index).val()
	    var totalValue1 = jQuery(nyyxxss+index).val();	  
	   var  userValue1= jQuery(nyyxxss1+index).val();
	     var  forwardVaule1=  jQuery(njjy_id+index).val();
	      var  expiedValue1= jQuery(njgq_id+index).val();
                   var nywxxss_val=Number(totalValue1)-Number(userValue1)+Number(forwardVaule1)-Number(expiedValue1)-Number(njwgdxss_val);
                jQuery(nywxxss+index).val(nywxxss_val.toFixed(1));
                   jQuery(nywxxss+index+"span").text(nywxxss_val.toFixed(1));
                   
 		
	})
	jQuery(txwgdxss+index).bindPropertyChange(function(){ 
			 var txwgdxss_val = jQuery(txwgdxss+index).val()
			  var totalValue2 = jQuery(txjyxxss+index).val();	  
	   var  userValue2= jQuery(txjyxxss1+index).val();
	     var  forwardVaule2=  jQuery(txjy_id+index).val();
	      var  expiedValue2= jQuery(txgq_id+index).val();
                   var txjwxxss_val=Number(totalValue2)-Number(userValue2)+Number(forwardVaule2)-Number(expiedValue2)-Number(txwgdxss_val);
          jQuery(txjwxxss+index).val(txjwxxss_val.toFixed(1));
                   jQuery(txjwxxss+index+"span").text(txjwxxss_val.toFixed(1));
                   
          
	})
	jQuery(s_emp+index).bindPropertyChange(function(){
			var vl = jQuery(hoiTYPE+index).val();
if(vl != 'L_014') get_some_Times(s_emp+index,s_date+index,s_time+index,e_date+index,e_time+index);
});


jQuery(s_date+index).bindPropertyChange(function(){
			var vl = jQuery(hoiTYPE+index).val();
if(vl != 'L_014') get_some_Times(s_emp+index,s_date+index,s_time+index,e_date+index,e_time+index);
});

jQuery(e_date+index).bindPropertyChange(function(){
			var vl = jQuery(hoiTYPE+index).val();
if(vl != 'L_014') get_some_Times(s_emp+index,s_date+index,s_time+index,e_date+index,e_time+index);
});

jQuery(s_time+index).bindPropertyChange(function(){
				var vl = jQuery(hoiTYPE+index).val();
if(vl != 'L_014') get_some_Times(s_emp+index,s_date+index,s_time+index,e_date+index,e_time+index);
});


jQuery(e_time+index).bindPropertyChange(function(){
				var vl = jQuery(hoiTYPE+index).val();
if(vl != 'L_014') get_some_Times(s_emp+index,s_date+index,s_time+index,e_date+index,e_time+index);
});

jQuery(hoiTYPE+index).bindPropertyChange(function(){
			var vl = jQuery(hoiTYPE+index).val();
if(vl != 'L_014') get_some_Times(s_emp+index,s_date+index,s_time+index,e_date+index,e_time+index);
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
                   data = data.replace(/\n/g,"").replace(/\r/g,"");
                   eval('var obj ='+data);
                   var xss = obj.xss;
                   jQuery(yjsjxss+index).val(xss);
                 //  jQuery(yjsjxss+"span").text(xss);
               document.getElementById(yjsjxss_1+index).readOnly = true;
			});
		}
}

function initbind(){
	var indexnum0 = jQuery("#indexnum0").val();
       	  for (var index1= 0; index1 < indexnum0; index1++) {
           		 if (jQuery(qjr_code + index1).length > 0) {
           		 	 gethistoryinfo(index1);
           		 	 bindchange(index1);
        		}
        	}	
}


//jQuery(s_emp).bind("propertychange",function()



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
									window.top.Dialog.alert("重复性检查完毕，没有重复，可以继续填写申请！！");
								}
							}
						}
					}
				xhr.send(null);
			}
				
			
		}
     }
}
</script>



































