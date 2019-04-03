<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	
var sqrq="#field17679";//申请日期
var jkbz="#field17681";//借款币种
var jkr="#field18451";//借款人

var hkbz_dt1="#field17688_";//币种明细1
var dishkbz_dt1="#disfield17688_";//币种明细1
var	jkid_dt1="#field17702_";//借款id明细1	
var cnzfje_dt1="#field17689_";//出纳支付金额明细1	
var pzhm_dt1 = "#field17690_";//凭证号码
var tbyczrq_dt1="#field17691_";//特别延长至*日期 明细1
var jksm_dt1="#field17692_";//借款用途明细1	

var hkbz_dt2="#field17695_";//还款币种明细2
var dishkbz_dt2="#disfield17695_";//还款币种明细2	
var	jkid_dt2="#field17703_";//借款id明细2	
var cnzfje_dt2="#field17696_";//出纳支付金额明细2	
var pzhm_dt2 = "#field17697_";//凭证号码
var tbyczrq_dt2="#field17698_";//特别延长至*日期 明细2	
var jksm_dt2="#field17699_";//借款用途明细2	

var jkksrq="#field18452";//借款开始日期
var jkjsrq="#field18453";//借款结束日期
var lcdh="#field18454";//流程单号
var pzh="#field18455";//凭证号

jQuery(document).ready(function(){
   showhide();
   jQuery("button[name=addbutton0]").css('display','none');
   jQuery("button[name=addbutton1]").css('display','none');
    jQuery(jkbz).bind("change",function(){	//隐藏方法
      showhide();
	  deletedata();
	  doservice();
   });
	jQuery(jkr).bindPropertyChange(function(){
		 deletedata();
	     doservice();
	 });
	 jQuery(jkksrq).bindPropertyChange(function(){
		 deletedata();
	     doservice();
	 });
	 jQuery(jkjsrq).bindPropertyChange(function(){
		 deletedata();
	     doservice();
	 });
	 jQuery(lcdh).bindPropertyChange(function(){
		 deletedata();
	     doservice();
	 });
	 jQuery(pzh).bind("change",function(){
		 deletedata();
	     doservice();
	 });
	 setTimeout('getData()',500);
 });
 function getData(){
	var jkr_val = jQuery(jkr).val();
	 var jkbz_val=jQuery(jkbz).val();
	var nodesnum0 = jQuery("#nodesnum0").val();
	var nodesnum1 = jQuery("#nodesnum1").val();
    if(nodesnum0 ==0 && nodesnum1 ==0){
	  doservice();
    }
    
}
function deletedata(){
		var nodesnum0 = jQuery("#nodesnum0").val();
		var nodesnum1 = jQuery("#nodesnum1").val();
		if(nodesnum0 >0){
	       jQuery("[name = check_node_0]:checkbox").attr("checked", true);
	        adddelid(0,hkbz_dt1);
	        removeRow0(0);
	    }
		if(nodesnum1 >0){
	       jQuery("[name = check_node_1]:checkbox").attr("checked", true);
	        adddelid(1,hkbz_dt2);
	        removeRow0(1);
	    }
}
function doservice(){
	 var jkbz_val=jQuery(jkbz).val();
		//alert(jkbz_val);
	 var jkr_val = jQuery(jkr).val();
	//if(jkbz_val == "" || jkr_val==""){
	//	return;
	//}
	if(jkbz_val == "0"||jkbz_val == "2"){
	   getrepaymentrmb();
	}
	if(jkbz_val == "1"||jkbz_val == "2"){
	   getrepaymentwb();
	}
}
  function getrepaymentrmb(){
	 var jkr_val = jQuery(jkr).val();
	 var jkksrq_val = jQuery(jkksrq).val();
	 var jkjsrq_val = jQuery(jkjsrq).val();
	 var lcdh_val=jQuery(lcdh).val();
	 var pzh_val = jQuery(pzh).val();
	 if(jkr_val==""&&jkksrq_val==""&&jkjsrq_val==""&&lcdh_val==""&&pzh_val==""){
	   return;
	 }
 	 var jkrid=encodeURIComponent(jkr_val);
   	 var indexnum0=  jQuery("#indexnum0").val();
	 var xhr1 = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr1 = new XMLHttpRequest();
  	 }
  	 if (null != xhr1) {
		xhr1.open("GET","/seahonor/expenses/getborrowinfo-pzh.jsp?jkrid="+jkrid+"&bz1=0&jkksrq="+jkksrq_val+"&jkjsrq="+jkjsrq_val+"&lcdh="+lcdh_val+"&pzh="+pzh_val+"", false);
		xhr1.onreadystatechange = function () {
		if (xhr1.readyState == 4) {
		  if (xhr1.status == 200) {
			var text = xhr1.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum0);
			for(var i=indexnum0;i<length1;i++){
			 
			 var tmp_arr = text_arr[i-indexnum0].split("###");
			
			 addRow0(0);
			 jQuery(hkbz_dt1+i).val(tmp_arr[0]);
			 jQuery(dishkbz_dt1+i).val(tmp_arr[0]);
			 jQuery(cnzfje_dt1+i).val(tmp_arr[1]);
			 jQuery(cnzfje_dt1+i+"span").text(tmp_arr[1]);
			 jQuery(pzhm_dt1+i).val(tmp_arr[2]);
			 if(tmp_arr[2] != ""){
			 jQuery(pzhm_dt1+i+"span").html("");
			 }
			 jQuery(tbyczrq_dt1+i).val(tmp_arr[3]);
			 jQuery(tbyczrq_dt1+i+"span").text(tmp_arr[3]);
			 jQuery(jksm_dt1+i).val(tmp_arr[4]);
			 jQuery(jksm_dt1+i+"span").text(tmp_arr[4]);
			  jQuery(jkid_dt1+i).val(tmp_arr[5]);
			 jQuery(jkid_dt1+i+"span").text(tmp_arr[5]);
			 
		     }
	          }
		  }
		}
        xhr1.send(null);
     }
	 calSum(0);
 }
 function getrepaymentwb(jkr_val){
	  var jkr_val = jQuery(jkr).val();
	   var jkksrq_val = jQuery(jkksrq).val();
	 var jkjsrq_val = jQuery(jkjsrq).val();
     var lcdh_val=jQuery(lcdh).val();
     var pzh_val = jQuery(pzh).val();
	 if(jkr_val==""&&jkksrq_val==""&&jkjsrq_val==""&&lcdh_val==""&&pzh_val==""){
	   return;
	 }
 	 var jkrid=encodeURIComponent(jkr_val);
   	 var indexnum1=  jQuery("#indexnum1").val();
	 var xhr2 = null;
	 if (window.ActiveXObject) {//IE浏览器
		xhr2 = new ActiveXObject("Microsoft.XMLHTTP");
	 } else if (window.XMLHttpRequest) {
		xhr2 = new XMLHttpRequest();
  	 }
  	 if (null != xhr2) {
		xhr2.open("GET","/seahonor/expenses/getborrowinfo-pzh.jsp?jkrid="+jkrid+"&bz1=1&jkksrq="+jkksrq_val+"&jkjsrq="+jkjsrq_val+"&lcdh="+lcdh_val+"&pzh="+pzh_val+"", false);
		xhr2.onreadystatechange = function () {
		if (xhr2.readyState == 4) {
		  if (xhr2.status == 200) {
			var text = xhr2.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			//alert(text);
			var text_arr = text.split("@@@");
			var length1=Number(text_arr.length)-1+Number(indexnum1);
			for(var i=indexnum1;i<length1;i++){
			 
			 var tmp_arr = text_arr[i-indexnum1].split("###");
			
				  addRow1(1);
			 jQuery(hkbz_dt2+i).val(tmp_arr[0]);
			 jQuery(dishkbz_dt2+i).val(tmp_arr[0]);
			 jQuery(cnzfje_dt2+i).val(tmp_arr[1]);
			 jQuery(cnzfje_dt2+i+"span").text(tmp_arr[1]);
			 jQuery(pzhm_dt2+i).val(tmp_arr[2]);
			  if(tmp_arr[2] != ""){
			 jQuery(pzhm_dt2+i+"span").html("");
			  }
			 jQuery(tbyczrq_dt2+i).val(tmp_arr[3]);
			 jQuery(tbyczrq_dt2+i+"span").text(tmp_arr[3]);
			 jQuery(jksm_dt2+i).val(tmp_arr[4]);
			 jQuery(jksm_dt2+i+"span").text(tmp_arr[4]);
			 jQuery(jkid_dt2+i).val(tmp_arr[5]);
			 jQuery(jkid_dt2+i+"span").text(tmp_arr[5]);
			 
		     }
	          }
		  }
		}
        xhr2.send(null);
     }
	 calSum(1);
 }
 function showhide(){
    var jkbz_val=jQuery(jkbz).val();
    if(jkbz_val == ""){
      jQuery("#ycmx1").hide();	 
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
    }else if(jkbz_val == "0"){
      jQuery("#ycmx1").show();
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
    }else if(jkbz_val == "1"){
      jQuery("#ycmx1").hide();
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
    }else if(jkbz_val == "2"){
      jQuery("#ycmx1").show();
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
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
</script>







