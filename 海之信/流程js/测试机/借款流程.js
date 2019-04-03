<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	
var sqrq="#field15659";//申请日期
var jkbz="#field15660";//借款币种
var jkr="#field15658";//借款人
var zzjebz="#field16354";//转账金额标准
var sftgmm="#field16355";//是否跳过密码
var dissftgmm="#disfield16355";//是否跳过密码
var bz_dt1="#field15938_";//币种明细1
var bz1_dt1="#disfield15938_";
var ybye_dt1="#field15669_";//原币金额 明细1
var yqje_dt1="#field15670_";//逾期金额 明细1
var tbyczrq_dt2="#field15675_";//特别延长至*日期 明细2
var jkje_dt2="#field15674_";//借款金额 明细2
var zffs_dt2="#field15677_";//支付方式 明细2
var diszffs_dt2="#disfield15677_";//dis支付方式 明细2
var tbyczrq_dt3="#field15685_";//特别延长至*日期 明细3
var jkje_dt3="#field15684_";//借款金额 明细3
var zffs_dt3="#field15687_";//支付方式 明细3
var diszffs_dt3="#disfield15687_";//dis支付方式 明细3
		
	
jQuery(document).ready(function(){
    showhide();
    jQuery(jkbz).bind("change",function(){
      showhide();
     });	
	jQuery("button[name=addbutton1]").live("click", function () {
	  var indexnum1 = jQuery("#indexnum1").val()-1;
	  getdate2(indexnum1);
	 });
	 
	 jQuery("button[name=addbutton2]").live("click", function () {
	   var indexnum2 = jQuery("#indexnum2").val()-1;
	   getdate3(indexnum2);
	 });
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
	 });
	 setTimeout('getData()',500);
	checkCustomize = function () {
	  	var flag="0";
	  	var zzjebz_val=jQuery(zzjebz).val();
	  	if(zzjebz_val == ""){
			zzjebz_val = "0";
		}
	  		var indexnum1=  jQuery("#indexnum1").val();
	    for(var i=0;i<indexnum1;i++){
		 	if(jQuery(jkje_dt2+i).length>0){		 	 	 
			var jkje_dt2_val=jQuery(jkje_dt2+i).val();		
		    if(jkje_dt2_val == ""){
				jkje_dt2_val = "0";
		    }
		    if(Number(jkje_dt2_val)>=Number(zzjebz_val)){
		      	jQuery(zffs_dt2+i).val("1");
		      	jQuery(diszffs_dt2+i).val("1");
		    }
		    var zffs_dt2_val =jQuery(zffs_dt2+i).val();
		    if(zffs_dt2_val=="0"){
		    	flag="1";
		    }
	     }
	    }
	    
	    var indexnum2=  jQuery("#indexnum2").val();
	    for(var i=0;i<indexnum2;i++){
		 	if(jQuery(jkje_dt3+i).length>0){		 	 	 
			var jkje_dt3_val=jQuery(jkje_dt3+i).val();		
		    if(jkje_dt3_val == ""){
				jkje_dt3_val = "0";
		    }
		    if(Number(jkje_dt3_val)>=Number(zzjebz_val)){
		      	jQuery(zffs_dt3+i).val("1");
		      	jQuery(diszffs_dt3+i).val("1");
		    }
		    var zffs_dt3_val =jQuery(zffs_dt3+i).val();
		    if(zffs_dt3_val=="0"){
		    	flag="1";
		    }
	     }
	    }
	    jQuery(sftgmm).val(flag);
	    jQuery(dissftgmm).val(flag);
	    return true;
    }
 });
 function bindchange2(index){
 	 jQuery(tbyczrq_dt2+index).bindPropertyChange(function(){
 	   var tbyczrq_dt2_val=jQuery(tbyczrq_dt2+index).val();
 	   	var sqrq_val=jQuery(sqrq).val();
	    var date1=addDate(sqrq_val,30);
	    if(tab(tbyczrq_dt2_val,date1)=="0"){
	       alert("特别延长至*日期只能选择大于申请30天的日期");
	       	jQuery(tbyczrq_dt2+index).val(date1);
			jQuery(tbyczrq_dt2+index+"span").text(date1);	
	    }
 	 })
 }
  function bindchange3(index){
 	 jQuery(tbyczrq_dt3+index).bindPropertyChange(function(){
 	   var tbyczrq_dt3_val=jQuery(tbyczrq_dt3+index).val();
 	   	var sqrq_val=jQuery(sqrq).val();
	    var date1=addDate(sqrq_val,30);
	    if(tab(tbyczrq_dt3_val,date1)=="0"){
	       alert("特别延长至*日期只能选择大于申请30天的日期");
	       	jQuery(tbyczrq_dt3+index).val(date1);
			jQuery(tbyczrq_dt3+index+"span").text(date1);	
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
function getData(){
	binddt2();
    binddt3();
	var jkr_val = jQuery(jkr).val();
	var nodesnum0 = jQuery("#nodesnum0").val();
    if(nodesnum0 ==0){
      dodetail(jkr_val);
    }
    doUrl();
    
}

function binddt2(){
 var indexnum1=  jQuery("#indexnum1").val();
 for(var i=0;i<indexnum1;i++){
 	 if(jQuery(jkje_dt2+i).length>0){
 	 	 bindjkjedt2(i);
 	 	 bindchange2(i);
     }
 }
}

function binddt3(){
 var indexnum2=  jQuery("#indexnum2").val();
 for(var i=0;i<indexnum2;i++){
 	 if(jQuery(jkje_dt3+i).length>0){
 	 	 bindjkjedt3(i);
 	 	 bindchange3(i);
     }
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

function showhide(){
    var jkbz_val=jQuery(jkbz).val();
    if(jkbz_val==""){
      jQuery("#ycmx1").hide();	 
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
    }else if(jkbz_val=="0"){
      jQuery("#ycmx1").show();
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
    }else if(jkbz_val=="1"){
      jQuery("#ycmx1").show();
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
    }else if(jkbz_val=="2"){
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
      jQuery("#ycmx1").hide();
      jQuery("#ycmx2").hide();
    }
} 
function bindjkjedt2(index){
	jQuery(jkje_dt2+index).bind("change",function(){
		var zzjebz_val=jQuery(zzjebz).val();
		var jkje_dt2_val=jQuery(jkje_dt2+index).val();
		if(zzjebz_val == ""){
			zzjebz_val = "0";
	    }
	    if(jkje_dt2_val == ""){
			jkje_dt2_val = "0";
	    }
	    if(Number(jkje_dt2_val)>=Number(zzjebz_val)){
	      	jQuery(zffs_dt2+index).val("1");
	      	jQuery(diszffs_dt2+index).val("1");
	      	jQuery(zffs_dt2+index+"span").html("");
	    }
		
	});
}	

function bindjkjedt3(index){
	jQuery(jkje_dt3+index).bind("change",function(){
		var zzjebz_val=jQuery(zzjebz).val();
		var jkje_dt3_val=jQuery(jkje_dt3+index).val();
		if(zzjebz_val == ""){
			zzjebz_val = "0";
	    }
	    if(jkje_dt3_val == ""){
			jkje_dt3_val = "0";
	    }
	    if(Number(jkje_dt3_val)>=Number(zzjebz_val)){
	      	jQuery(zffs_dt3+index).val("1");
	      	jQuery(diszffs_dt3+index).val("1");
	      	jQuery(zffs_dt3+index+"span").html("");
	    }
		
	});
}
function getdate2(index){
	bindjkjedt2(index);
	bindchange2(index);
	var sqrq_val=jQuery(sqrq).val();
	var date1=addDate(sqrq_val,30);
	jQuery(tbyczrq_dt2+index).val(date1);
	jQuery(tbyczrq_dt2+index+"span").text(date1);	
}

function getdate3(index){
	bindjkjedt3(index);
	bindchange3(index);
	var sqrq_val=jQuery(sqrq).val();
	var date1=addDate(sqrq_val,30);
	jQuery(tbyczrq_dt3+index).val(date1);
	jQuery(tbyczrq_dt3+index+"span").text(date1);	
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
