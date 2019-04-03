<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	
var sqrq="#field16777";//申请日期
var jkbz="#field16778";//借款币种
var jkr="#field16776";//借款人
var hkbz_dt2="#field16794_";//币种明细2
var dishkbz_dt2="#disfield16794_";//币种明细2
var	jkid_dt2="#field17225_";//借款id明细2	
var cnzfje_dt2="#field16795_";//出纳支付金额明细2	
var yjkdqr_dt2="#field16822_";//原借款到期日 明细2
var tbyczrq_dt2="#field16805_";//特别延长至*日期 明细2
var jksm_dt2="#field16806_";//借款用途明细2	
var hkbz_dt3="#field16813_";//还款币种明细3
var dishkbz_dt3="#disfield16813_";//还款币种明细3	
var	jkid_dt3="#field17226_";//借款id明细3	
var cnzfje_dt3="#field16796_";//出纳支付金额明细3	
var yjkdqr_dt3="#field16824_";//原借款到期日 明细3
var tbyczrq_dt3="#field16815_";//特别延长至*日期 明细3	
var jksm_dt3="#field16816_";//借款用途明细3	
jQuery(document).ready(function(){
   //alert("11");
	 jQuery(jkbz).bindPropertyChange(function(){
		  var jkbz_val=jQuery(jkbz).val();
		   var jkr_val = jQuery(jkr).val();
		   var nodesnum1 = jQuery("#nodesnum1").val();
		var nodesnum2 = jQuery("#nodesnum2").val();
		  if(nodesnum1 >0){
	       jQuery("[name = check_node_1]:checkbox").attr("checked", true);
	        adddelid(1,hkbz_dt2);
	        removeRow0(1);
	    }
		if(nodesnum2 >0){
	       jQuery("[name = check_node_2]:checkbox").attr("checked", true);
	        adddelid(2,hkbz_dt3);
	        removeRow0(2);
	    }
		   if(jkbz_val !=""){
			if(jkbz_val == "0"||jkbz_val == "1"){
			getrepaymentrmb(jkr_val);
			}
			if(jkbz_val == "0"||jkbz_val == "2"){
			getrepaymentwb(jkr_val);
			}
	    }	   
	 })
	 jQuery(jkr).bindPropertyChange(function(){
		 var jkbz_val=jQuery(jkbz).val();
	    var jkr_val = jQuery(jkr).val();
		var nodesnum1 = jQuery("#nodesnum1").val();
		var nodesnum2 = jQuery("#nodesnum2").val();
	    
		if(nodesnum1 >0){
	       jQuery("[name = check_node_1]:checkbox").attr("checked", true);
	        adddelid(1,hkbz_dt2);
	        removeRow0(1);
	    }
		if(nodesnum2 >0){
	       jQuery("[name = check_node_2]:checkbox").attr("checked", true);
	        adddelid(2,hkbz_dt3);
	        removeRow0(2);
	    }
	    if(jkr_val !=""){
			if(jkbz_val == "0"||jkbz_val == "1"){
				
			getrepaymentrmb(jkr_val);
			
			}
			if(jkbz_val == "0"||jkbz_val == "2"){
			getrepaymentwb(jkr_val);
			}
	    }	    
	 });
	 setTimeout('getData()',500);
	
 });
 function getrepaymentrmb(jkr_val){
 	 var jkrid=encodeURIComponent(jkr_val);
   	 var indexnum2=  jQuery("#indexnum1").val();
	 var xhr1 = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr1 = new XMLHttpRequest();
  	 }
  	 if (null != xhr1) {
		xhr1.open("GET","/seahonor/expenses/get-borrow-change.jsp?jkrid="+jkrid+"&bz1=0", false);
		xhr1.onreadystatechange = function () {
		if (xhr1.readyState == 4) {
		  if (xhr1.status == 200) {
			var text = xhr1.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum2);
			for(var i=indexnum2;i<length1;i++){
			 
			 var tmp_arr = text_arr[i-indexnum2].split("###");
			
				  addRow1(1);
				jQuery(jkid_dt2+i).val(tmp_arr[0]);
			 jQuery(jkid_dt2+i+"span").text(tmp_arr[0]);
			jQuery(hkbz_dt2+i).val(tmp_arr[1]);
			jQuery(dishkbz_dt2+i).val(tmp_arr[1]);
			jQuery(cnzfje_dt2+i).val(tmp_arr[3]);
			jQuery(cnzfje_dt2+i+"span").text(tmp_arr[3]);
			jQuery(yjkdqr_dt2+i).val(tmp_arr[4]);
			jQuery(yjkdqr_dt2+i+"span").text(tmp_arr[4]);
			jQuery(jksm_dt2+i).val(tmp_arr[5]);
			 
		     }
	          }
		  }
		}
        xhr1.send(null);
     }
	 calSum(1);
	 bindchangedate("2");
 }
 function getrepaymentwb(jkr_val){
 	 var jkrid=encodeURIComponent(jkr_val);
   	 var indexnum3=  jQuery("#indexnum2").val();
	 var xhr2 = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr2 = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr2 = new XMLHttpRequest();
  	 }
  	 if (null != xhr2) {
		xhr2.open("GET","/seahonor/expenses/get-borrow-change.jsp?jkrid="+jkrid+"&bz1=1", false);
		xhr2.onreadystatechange = function () {
		if (xhr2.readyState == 4) {
		  if (xhr2.status == 200) {
			var text = xhr2.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum3);
			for(var i=indexnum3;i<length1;i++){
			 
			 var tmp_arr = text_arr[i-indexnum3].split("###");
			
				  addRow2(2);
				jQuery(jkid_dt3+i).val(tmp_arr[0]);
			 jQuery(jkid_dt3+i+"span").text(tmp_arr[0]);
			 jQuery(hkbz_dt3+i).val(tmp_arr[1]);
			jQuery(dishkbz_dt3+i).val(tmp_arr[1]);
			jQuery(cnzfje_dt3+i).val(tmp_arr[3]);
			jQuery(cnzfje_dt3+i+"span").text(tmp_arr[3]);
			jQuery(yjkdqr_dt3+i).val(tmp_arr[4]);
			jQuery(yjkdqr_dt3+i+"span").text(tmp_arr[4]);
			jQuery(jksm_dt3+i).val(tmp_arr[5]);
			 
			 
		     }
	          }
		  }
		}
        xhr2.send(null);
     }
	 calSum(2);
	 bindchangedate("3");
 }
 function bindchangedate(type){
	 if(type=="2"){
		var indexnum1=  jQuery("#indexnum1").val();
		for(var index=0;index<indexnum1;index++){
			if(jQuery(tbyczrq_dt2+index).length>0){
				bindchange2(index);
			}
		}
	 }
	 if(type=="3"){
		var indexnum2=  jQuery("#indexnum2").val();
		for(var index=0;index<indexnum2;index++){
			if(jQuery(tbyczrq_dt3+index).length>0){
				bindchange3(index);
			}
		}
	 }
 }
 function bindchange2(index){
 	 jQuery(tbyczrq_dt2+index).bindPropertyChange(function(){
 	   var tbyczrq_dt2_val=jQuery(tbyczrq_dt2+index).val();
 	   	var yjkdqr_dt2_val=jQuery(yjkdqr_dt2+index).val();
		if(tbyczrq_dt2_val !=""){
	    if(tab(tbyczrq_dt2_val,yjkdqr_dt2_val)=="0"){
	       alert("特别延长至*日期只能选择大于原借款到期日的日期");
	       	jQuery(tbyczrq_dt2+index).val("");
			jQuery(tbyczrq_dt2+index+"span").text("");	
	    }
		}
 	 })
 }
  function bindchange3(index){
 	 jQuery(tbyczrq_dt3+index).bindPropertyChange(function(){
 	   var tbyczrq_dt3_val=jQuery(tbyczrq_dt3+index).val();
 	   	var yjkdqr_dt3_val=jQuery(yjkdqr_dt3+index).val();
		if(tbyczrq_dt3_val !=""){
	    if(tab(tbyczrq_dt3_val,yjkdqr_dt3_val)=="0"){
	       alert("特别延长至*日期只能选择大于原借款到期日的日期");
	       	jQuery(tbyczrq_dt3+index).val("");
			jQuery(tbyczrq_dt3+index+"span").text("");	
	    }
		}
 	 })
 }
  function tab(date1,date2){
    var oDate1 = new Date(date1.replace(/-/g, "/"));
    var oDate2 = new Date(date2.replace(/-/g, "/"));
    if(oDate1.getTime() < oDate2.getTime()){
        return "0";
    } else {
        return "1";
    }
}
 
function getData(){
	var jkr_val = jQuery(jkr).val();
	 var jkbz_val=jQuery(jkbz).val();
	  if(jkbz_val == "0"||jkbz_val == "1"){
		var nodesnum1 = jQuery("#nodesnum1").val();
		 if(nodesnum1 ==0){
	      getrepaymentrmb(jkr_val);
		  bindchangedate(2);
		 }
	  }
	  if(jkbz_val == "0"||jkbz_val == "2"){
		  var nodesnum2 = jQuery("#nodesnum2").val();
		 if(nodesnum2 ==0){
		getrepaymentwb(jkr_val);
		bindchangedate(3);
		 }
	 }
    
    
}





function adddelid(dtid,fieldidqf){
	var ids_dt1="";
  	var flag1="";
    var indexnum0=  jQuery("#indexnum"+dtid).val();
    for(var index=0;index <indexnum0;index++){
      if(jQuery(fieldidqf+index).length>0){
        var pp=document.getElementsByName('dtl_id_'+dtid+'_'+index)[0].value;
        ids_dt1=ids_dt1+flag1+pp;
        flag1=",";
      }
    }
    var deldtlid0_val=jQuery("#deldtlid"+dtid).val();
    if(deldtlid0_val !=""){
       deldtlid0_val=deldtlid0_val+","+ids_dt1;          
    }else{
       deldtlid0_val=ids_dt1;
    }
    jQuery("#deldtlid"+dtid).val(deldtlid0_val);	
}
function removeRow0(groupid,isfromsap){
	try{
      var flag = false;
      var ids = document.getElementsByName("check_node_"+groupid);
      for(i=0; i<ids.length; i++) {
		if(ids[i].checked==true) {
			flag = true;
			break;
		}
 	  }
	  if(isfromsap){flag=true;}
      if(flag) {
		if(isfromsap || _isdel()){
			var oTable=document.getElementById("oTable"+groupid)
			var len = document.forms[0].elements.length;
			var curindex=parseInt($G("nodesnum"+groupid).value);
			var i=0;
			var rowsum1 = 0;
			var objname = "check_node_"+groupid;
			for(i=len-1; i >= 0;i--) {
				if (document.forms[0].elements[i].name==objname){
					rowsum1 += 1;
				}
			}
			rowsum1=rowsum1+2;
			for(i=len-1; i>=0; i--) {
				if(document.forms[0].elements[i].name==objname){
					if(document.forms[0].elements[i].checked==true){
						var nodecheckObj;
						var delid;
						try{
						  if(jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").length>0){					          	 
	         			    delid = jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").eq(0).val(); 
	         			  }
						}catch(e){}
						//记录被删除的旧记录 id串
						if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
							if($G("deldtlid"+groupid).value!=''){
								//老明细
								$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
							}else{
								//新明细
								$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
							}
						}
						//从提交序号串中删除被删除的行
						var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
						$G("submitdtlid"+groupid).value="";
						var k;
						for(k=0; k<submitdtlidArray.length; k++){
							if(submitdtlidArray[k]!=delid){
								if($G("submitdtlid"+groupid).value==''){
									$G("submitdtlid"+groupid).value = submitdtlidArray[k];
								}else{
									$G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
								}
							}
						}
						oTable.deleteRow(rowsum1);
						curindex--;
					}
					rowsum1--;
				}
			}
			$G("nodesnum"+groupid).value=curindex;
			calSum(groupid);
       }
   	 }else{
	        alert('请选择需要删除的数据');
			return;
	 }	
	}catch(e){}
		try{
			var indexNum = jQuery("span[name='detailIndexSpan0']").length;
			for(var k=1; k<=indexNum; k++){
				jQuery("span[name='detailIndexSpan0']").get(k-1).innerHTML = k;
			}
		}catch(e){}
	}
	
function _isdel(){
    return true;
} 

function addDate(date,days){ 
    var d=new Date(date); 
    d.setDate(d.getDate()+days); 
    var m=d.getMonth()+1; 
    return d.getFullYear()+'-'+m+'-'+d.getDate(); 
}
 
function showInfo(typex) {

		var title = "";
		var url = "/seahonor/expenses/forward.jsp?typex="+typex;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 500;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
	
		diag_vote.show();
		
}   
</script>
