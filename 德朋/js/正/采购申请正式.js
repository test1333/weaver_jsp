<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var gys_dt1 = "#field6345_";
var gys_dt2="#field8534_";
var je_dt1="#field6340_";
var hjje_dt2="#field8535_";
var gysname_dt1="#field8533_"
var ysqj_dt1="#field6522_";
var dqrq="#field8611";
var sqlx_dt1="#field6520_";
var cdzt_dt1="#field6521_";
jQuery(document).ready(function(){
		var indexnum11 = jQuery("#indexnum1").val();
	      for (var index0= 0; index0 < indexnum11; index0++) {   
	      	   if (jQuery(hjje_dt2 + index0).length > 0) {
	      	    jQuery(hjje_dt2 + index0).attr("readonly", "readonly");
	                }	 	 
	    }
	checkCustomize = function(){ 
			candelete();
		emptyhjje();
		var indexnum0 = jQuery("#indexnum0").val();
		var checkval1='';
		var cdzt_old='-1';
		var sqlx_old='-1';
		 for (var index0= 0; index0 < indexnum0; index0++) {   
		 	   if (jQuery(ysqj_dt1 + index0).length > 0) {
		 	   	    var cdzt_dt1_val = jQuery(cdzt_dt1 + index0).val();
		 	   	    var sqlx_dt1_val = jQuery(sqlx_dt1 + index0).val();
		 	   	     if(sqlx_old == '-1'){
		 	         sqlx_old=sqlx_dt1_val;
		 	         }else{
		 	           	 if(sqlx_old != sqlx_dt1_val){
		 	           	 	 alert("存在申请类型不一致，请修改。");
		 	           	 	 return false;
		 	              }
		 	        }
		 	   	   if(cdzt_old == '-1'){
		 	         cdzt_old=cdzt_dt1_val;
		 	         }else{
		 	           	 if(cdzt_old != cdzt_dt1_val){
		 	           	 	 alert("存在承担主体不一致，请修改。");
		 	           	 	 return false;
		 	              }
		 	        }
		 	   	   var gys_dt1_val = jQuery(gys_dt1 + index0).val();
		 	   	    var je_dt1_val = jQuery(je_dt1 + index0).val();
		 	   	   if(je_dt1_val=='') je_dt1_val=0;
		 	   	   if(gys_dt1_val !=''){
		 	     	addje(gys_dt1_val,je_dt1_val);
			 	    
		 	   	}
		 	   
		 	   	   var ysqj_dt1_val = jQuery(ysqj_dt1 + index0).val();
		 	   	   if(ysqj_dt1_val ==''){
		 	   		continue;
		 	   		}
		 	   	 if(checkval1 ==''){
		 	  	    checkval1 = ysqj_dt1_val;
		 	  	  }else{
		 	  	   if(ysqj_dt1_val != checkval1){
		 	  	     alert("预算期间不一致，请查看");
		 	  	     return false;
		 	  	   }	  	  
		 	    	}
		 	   	   
		 	   	   
		 	   }
		 }
		 	var dqrq_val=jQuery(dqrq).val();
		 	var dqrq_str=dqrq_val.substring(0,7);
			for (var index0= 0; index0 < indexnum0; index0++) {   
		      	if (jQuery(gys_dt1 + index0).length > 0) {
		      	       var ysqj_dt1_val = jQuery(ysqj_dt1 + index0).val().substring(0,7);
		      	       if(ysqj_dt1_val !=dqrq_str){
		      
		      	         jQuery(ysqj_dt1 + index0).val(dqrq_val);
		      	         jQuery(ysqj_dt1 + index0+"span").html(dqrq_val);
		      	      }
		      	}
		      }
  if(confirm("是否确定完供应商金额并继续提交？")){
	              return true;
	          }else{
	               return false;
	          }
	}	
});	

function candelete(){
	var flag=0;
 	var indexnum1 = jQuery("#indexnum1").val();
 	if(indexnum1 <=0){
	return;
	}else{
     	var indexnum0 = jQuery("#indexnum0").val();
     	for (var index0= 0; index0 < indexnum0; index0++) {   
		 	   if (jQuery(gys_dt1 + index0).length > 0) {
		 	   	   var gys_dt1_val = jQuery(gys_dt1 + index0).val();
		 	   	   if(gys_dt1_val != ''){
		 	   	    flag=isExists(gys_dt1_val);
		 	   	   if(flag == 'E'){
		 	   	     break;
		 	   	   }
		 	   	}
		 	   }
		 }
		 if(flag !='E'){
		 for (var index1= 0; index1< indexnum1; index1++) {   
		 	   if (jQuery(gys_dt2 + index1).length > 0) {
		 	   	   var gys_dt2_val = jQuery(gys_dt2 + index1).val();
		 	   	     if(gys_dt2_val != ''){
		 	   	    flag=isExists2(gys_dt2_val);
		 	   	   if(flag == 'E'){
		 	   	     break;
		 	   	   }
		 	   	   }
		 	   }
		 }	
		}
		 
	}
	
	if(flag == 'E'){
     jQuery("[name = check_node_1]:checkbox").attr("checked", true);
	deleteRow1(1);
	}
	
}

function isExists(gys_dt1_val){
 	var indexnum1 = jQuery("#indexnum1").val();
 		for (var index1= 0; index1 < indexnum1; index1++) {   
		 	   if (jQuery(gys_dt2 + index1).length > 0) {
		 	   	   var gys_dt2_val=jQuery(gys_dt2 + index1).val();
		 	   	   if(gys_dt2_val == gys_dt1_val){
		 	   	   	   return index1;
		 	   		}
		 	   }
		 }	
		 return 'E';
 	
}

function isExists2(gys_dt2_val){
 	var indexnum1 = jQuery("#indexnum1").val();
 		for (var index1= 0; index1 < indexnum1; index1++) {   
		 	   if (jQuery(gys_dt1 + index1).length > 0) {
		 	   	   var gys_dt1_val=jQuery(gys_dt1 + index1).val();
		 	   	   if(gys_dt2_val == gys_dt1_val){
		 	   	   	   return index1;
		 	   		}
		 	   }
		 }	
		 return 'E';
 	
}

function emptyhjje(){
	var indexnum1 = jQuery("#indexnum1").val();
 		for (var index1= 0; index1 < indexnum1; index1++) {   
		 	   if (jQuery(hjje_dt2 + index1).length > 0) {
		 	   	   jQuery(hjje_dt2+index1).val("0");
		  }
		 }	
}
function addje(gys_dt1_val,je_dt1_val){
	var flag=isExists(gys_dt1_val);
	if(flag == 'E'){
	  var indexnum2 = jQuery("#indexnum1").val();
	       addRow1(1);
	   
	  var xhr = null;
        if (window.ActiveXObject) {//IE浏览器
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            xhr = new XMLHttpRequest();
        }
        if (null != xhr) {
            xhr.open("GET", "/dp/purchase/getgysname.jsp?id=" + gys_dt1_val, false);
            xhr.onreadystatechange = function () {

                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        var text = xhr.responseText;
                        text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        	     jQuery(gysname_dt1+indexnum2).val(text);
                        	    	jQuery(gysname_dt1+indexnum2+ "span").text(text);
                         jQuery(gys_dt2+indexnum2).val(gys_dt1_val);
	    		 	 jQuery(hjje_dt2+indexnum2).val(je_dt1_val);
	    		 	 	   jQuery(hjje_dt2 + indexnum2).attr("readonly", "readonly");
                      
                        
                    }
                }
            }
            xhr.send(null);
        }
	}else{
	   var hjje_dt2_val= jQuery(hjje_dt2+flag).val();
	   jQuery(hjje_dt2+flag).val(accAdd(hjje_dt2_val,je_dt1_val));
	}
}
function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
} 

</script>

