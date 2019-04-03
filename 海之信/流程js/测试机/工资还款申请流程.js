<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">

var jkyqrs="#field18606";//借款逾期人数
var jkrxm_dt1="#field18776_";//借款人姓名
var ryid_dt1="#field18846_";

var jkrxm_dt2="#field18615_";//借款人姓名
var jkyqje_dt2="#field18616_";//借款逾期金额
var jkdqr_dt2="#field18618_";//借款日期
var yqts_dt2="#field18619_";//逾期天数
var yy_dt2="#field18620_";//原因
var jkid_dt2="#field18774_";//借款id

var jkrxm_dt3="#field18623_";//借款人姓名
var jkyqbz_dt3="#field18624_";//借款逾期币种
var disjkyqbz_dt3="#disfield18624_";//借款逾期币种
var jkyqje_dt3="#field18625_";//借款逾期金额
var jkdqr_dt3="#field18628_";//借款日期
var yqts_dt3="#field18629_";//逾期天数
var yy_dt3="#field18630_";//原因
var jkid_dt3="#field18775_";//借款id
jQuery(document).ready(function(){
getData();
	 doUrl();
 setTimeout('getUrl()',1000);
 jQuery(jkyqrs).bindPropertyChange(function(){
		getUrl();
	 });
});
function getUrl(){
	var jkyqrs_val=jQuery(jkyqrs).val();
	 jQuery(jkyqrs+"span").text("");
	 jQuery(jkyqrs+"span").html("<a href=\"javascript:showInfoyq()\">"+jkyqrs_val+"</a>");
}
 function getData(){
	var nodesnum0 = jQuery("#nodesnum0").val();
	var nodesnum1 = jQuery("#nodesnum1").val();
	var nodesnum2 = jQuery("#nodesnum2").val();
    if(nodesnum0 ==0 && nodesnum1 ==0&& nodesnum2 ==0){
	  doservice();
    }
    
}
function doservice(){
	getrepaymentrmb();
	getrepaymentwb();
	getpeople();
	duUrl();
}
function doUrl(){
	var indexnum0=  jQuery("#indexnum0").val();
	for(var index=0;index<indexnum0;index++){
	  if(jQuery(jkrxm_dt1+index).length>0){
         var jkrxm_dt1_val=jQuery(jkrxm_dt1+index).val();
		 var ryid_dt1_val=jQuery(ryid_dt1+index).val();
		 jQuery(jkrxm_dt1+index+"span").text("");
	    jQuery(jkrxm_dt1+index+"span").html("<a href=\"javascript:showInfogr('"+ryid_dt1_val+"')\">"+jkrxm_dt1_val+"</a>");
      }	  
	}
}
function showInfogr(jkrid) {
		var title = "个人借款明细";
		var url = "/seahonor/expenses/person-borrow-info-gr-gzhk.jsp?jkrid="+jkrid;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.maxiumnable = true;
		diag_vote.Width = 800;
		diag_vote.Height = 400;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
		
}  
function showInfoyq() {
		var title = "逾期列表";
		var url = "/seahonor/expenses/person-borrow-info-yq-gzhk.jsp";
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.maxiumnable = true;
		diag_vote.Width = 1000;
		diag_vote.Height = 500;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
		
}  
 function getpeople(){
   	 var indexnum0=  jQuery("#indexnum0").val();
	 var xhr = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
  	 }
  	 if (null != xhr) {
		xhr.open("GET","/seahonor/expenses/getborrowinfo-gshk-dt1.jsp", false);
		xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
		  if (xhr.status == 200) {
			var text = xhr.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum0);
			for(var i=indexnum0;i<length1;i++){
			 
			 var tmp_arr = text_arr[i-indexnum0].split("###");
			
			 addRow0(0);
			 jQuery(jkrxm_dt1+i).val(tmp_arr[1]);
			 jQuery(jkrxm_dt1+i+"span").text(tmp_arr[1]);
			 jQuery(ryid_dt1+i).val(tmp_arr[0]);
			 jQuery(ryid_dt1+i+"span").text(tmp_arr[0]);
			 
		     }
	          }
		  }
		}
        xhr.send(null);
     }
	 calSum(0);
 }
  function getrepaymentrmb(){
   	 var indexnum1=  jQuery("#indexnum1").val();
	 var xhr1 = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr1 = new XMLHttpRequest();
  	 }
  	 if (null != xhr1) {
		xhr1.open("GET","/seahonor/expenses/getborrowinfo-gshk.jsp?bz=0", false);
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
			 jQuery(jkrxm_dt2+i).val(tmp_arr[1]);
			 jQuery(jkrxm_dt2+i+"span").text(tmp_arr[2]);
			 jQuery(jkyqje_dt2+i).val(tmp_arr[4]);
			 jQuery(jkyqje_dt2+i+"span").text(tmp_arr[4]);
			 jQuery(jkdqr_dt2+i).val(tmp_arr[5]);
			 jQuery(jkdqr_dt2+i+"span").text(tmp_arr[5]);
			 jQuery(yqts_dt2+i).val(tmp_arr[6]);
			 jQuery(yqts_dt2+i+"span").text(tmp_arr[6]);
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
 function getrepaymentwb(){
   	 var indexnum2=  jQuery("#indexnum2").val();
	 var xhr2 = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr2 = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr2 = new XMLHttpRequest();
  	 }
  	 if (null != xhr2) {
		xhr2.open("GET","/seahonor/expenses/getborrowinfo-gshk.jsp?bz=1", false);
		xhr2.onreadystatechange = function () {
		if (xhr2.readyState == 4) {
		  if (xhr2.status == 200) {
			var text = xhr2.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum2);
			for(var i=indexnum2;i<length1;i++){
			 
			 var tmp_arr = text_arr[i-indexnum2].split("###");
			
		     addRow2(2);
			jQuery(jkrxm_dt3+i).val(tmp_arr[1]);
			 jQuery(jkrxm_dt3+i+"span").text(tmp_arr[2]);
			 jQuery(jkyqbz_dt3+i).val(tmp_arr[3]);
			 jQuery(disjkyqbz_dt3+i).val(tmp_arr[3]);
			 jQuery(jkyqje_dt3+i).val(tmp_arr[4]);
			 jQuery(jkyqje_dt3+i+"span").text(tmp_arr[4]);
			 jQuery(jkdqr_dt3+i).val(tmp_arr[5]);
			 jQuery(jkdqr_dt3+i+"span").text(tmp_arr[5]);
			 jQuery(yqts_dt3+i).val(tmp_arr[6]);
			 jQuery(yqts_dt3+i+"span").text(tmp_arr[6]);
			  jQuery(jkid_dt3+i).val(tmp_arr[0]);
			 jQuery(jkid_dt3+i+"span").text(tmp_arr[0]);
			 
		     }
	          }
		  }
		}
        xhr2.send(null);
     }
	 calSum(2);
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
</script>




