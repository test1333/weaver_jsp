<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var jkr="#field18471";//借款人
var bz_dt1="#field18514_";//币种明细1
var bz1_dt1="#disfield18514_";
var ybye_dt1="#field18515_";//原币金额 明细1
var yqje_dt1="#field18516_";//逾期金额 明细1
var kh="#field18785";//卡号
var jklcdh="#field18784";//借款流程单号
var yjkye_dt2="#field18518_";//原借款余额 明细2
var jkye_dt2="#field18519_";//借款余额 明细2
var jkid_dt2="#field18770_";//借款id 明细2
jQuery(document).ready(function(){
	jQuery(jkr).bindPropertyChange(function(){
	    var jkr_val = jQuery(jkr).val();
	    //alert(jkr_val);
	   	var nodesnum0 = jQuery("#nodesnum0").val();
	    if(nodesnum0 >0){
	       jQuery("[name = check_node_0]:checkbox").attr("checked", true);
	        adddelid(0,bz_dt1);
	        removeRow0(0);
	    }
	    if(jkr_val !=""){
	      dodetail(jkr_val);
	      doUrl();	
	    }	    
		
		 deletedata();
	     doservice();
	 });
	 jQuery(jklcdh).bindPropertyChange(function(){
		 deletedata();
	     doservice();
	 });
	 jQuery(kh).bindPropertyChange(function(){
		 deletedata();
	     doservice();
	 });
})
function getborrowrmb(){
	 var kh_val=jQuery(kh).val();
	 var jkr_val=jQuery(jkr).val();
	var jklcdh_val=jQuery(jklcdh).val();
	 if(kh_val==""||jkr_val==""||jklcdh_val==""){
	   return;
	 }
   	 var indexnum1=  jQuery("#indexnum1").val();
	 var xhr1 = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr1 = new XMLHttpRequest();
  	 }
  	 if (null != xhr1) {
		xhr1.open("GET","/seahonor/expenses/getborrowinfo-gwkcx.jsp?gwkid="+kh_val+"&jkrid="+jkr_val+"&jklcdh="+jklcdh_val, false);
		xhr1.onreadystatechange = function () {
		if (xhr1.readyState == 4) {
		  if (xhr1.status == 200) {
			var text = xhr1.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum1);
			for(var i=indexnum1;i<length1;i++){
			 
			 var tmp_arr = text_arr[i-indexnum1].split("###");
			
			 addRow1(1);
			jQuery(yjkye_dt2+i).val(tmp_arr[1]);
			 jQuery(yjkye_dt2+i+"span").text(tmp_arr[1]);
			 jQuery(jkye_dt2+i).val(tmp_arr[2]);
			 jQuery(jkye_dt2+i+"span").text(tmp_arr[2]);
			 jQuery(jkid_dt2+i).val(tmp_arr[0]);
			 jQuery(jkid_dt2+i+"span").text(tmp_arr[0]);
			 
		     }
	          }
		  }
		}
        xhr1.send(null);
     }
	 calSum(1);
 }
function doservice(){
	var kh_val=jQuery(kh).val();
	var jkr_val=jQuery(jkr).val();
	var jklcdh_val=jQuery(jklcdh).val();
	if(kh_val != ""||jkr_val !=""||jklcdh_val !=""){
	   getborrowrmb();
	}
}
function deletedata(){
		var nodesnum1 = jQuery("#nodesnum1").val();
		if(nodesnum1 >0){
	       jQuery("[name = check_node_1]:checkbox").attr("checked", true);
	        adddelid(1,yjkye_dt2);
	        removeRow0(1);
	    }
		
}
function dodetail(jkr_val){
 	 var jkrid=encodeURIComponent(jkr_val);
   	 var indexnum1=  jQuery("#indexnum0").val();
	 var xhr = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
  	 }
  	 if (null != xhr) {
		xhr.open("GET","/seahonor/expenses/getPersonalBorrow.jsp?jkrid="+jkrid, false);
		xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
		  if (xhr.status == 200) {
			var text = xhr.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum1);
			for(var i=indexnum1;i<length1;i++){
			  addRow0(0);
			 var tmp_arr = text_arr[i-indexnum1].split("###");
			 jQuery(bz_dt1+i).val(tmp_arr[0]);
			 jQuery(bz1_dt1+i).val(tmp_arr[0]);
			 jQuery(ybye_dt1+i).val(tmp_arr[1]);
			 jQuery(ybye_dt1+i+"span").text(tmp_arr[1]);
			 jQuery(yqje_dt1+i).val(tmp_arr[3]);
			 jQuery(yqje_dt1+i+"span").text(tmp_arr[3]);
			 
		     }
	          }
		  }
		}
        xhr.send(null);
     }
 }
 function doUrl(){
  	var indexnum0=  jQuery("#indexnum0").val();
  	for(var i=0;i<indexnum0;i++){
  	   if(jQuery(bz_dt1+i).length>0){
  	   	   var jkr_val=jQuery(jkr).val();
  	       var ybye_val=jQuery(ybye_dt1+i).val();
  	       var bz_val=jQuery(bz_dt1+i).val();
  	       var typex="";
  	       var url="";
  	       if(Number(ybye_val) !=0){
	  	       ybye_val=Number(ybye_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
	  	       typex="1,"+jkr_val+","+bz_val;
	  	       url="<a href=\"javascript:showInfo(\'"+typex+"\')\">"+ybye_val+"</a>";
	  	       jQuery(ybye_dt1+i+"span").html(url);
  	       }
  	        var yqje_val=jQuery(yqje_dt1+i).val();
  	        if(Number(yqje_val) !=0){
  	        	yqje_val=Number(yqje_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
  	        	typex="2,"+jkr_val+","+bz_val;
  	        	url="<a href=\"javascript:showInfo(\'"+typex+"\')\">"+yqje_val+"</a>";
  	        	jQuery(yqje_dt1+i+"span").html(url);
  	        }
  	       
  	      
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
