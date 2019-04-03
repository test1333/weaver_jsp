<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
//分单节点
    var bqhhje = "#field18565";     // 本期还款金额
	var bqtkje = "#field18564";     // 本期退卡金额
	var hkhz = "#field18754";     // 明细1还款汇总
	var tkhz = "#field18755";     // 明细2退卡汇总
	var kh="#field18560";//卡号

	var hkfs = "#field18572_";		//还款方式  明细1
	var fkyhzh = "#field18576_";		//付款银行账户  明细1
	var fkgs = "#field18578_";    //付款公司
	var hkje = "#field18574_";	 //还卡金额

	var tkje_dt2 ="#field18581_";	//退卡金额	
	var tkrq_dt2 ="#field18582_";	//退卡日期
	var tkyy_dt2 ="#field18583_";	//退卡原因
	var lcdh_dt2 ="#field18761_";	//流程单号				
	
	var sjky_dt3="#field18587_";//数据来源
	var dissjky_dt3="#disfield18587_";//数据来源
	var bz_dt3="#field18588_";//币种
	var disbz_dt3="#disfield18588_";//币种
	var je_dt3="#field18589_";//金额
	var sjskrq_dt3="#field18590_";//实际刷卡日
	var xfsx_dt3="#field18591_";//消费事项
	var lcdh_dt3="#field18762_";//流程单号
	jQuery(document).ready(function(){
		jQuery(kh).bindPropertyChange(function(){
			 deletedata();
			 doservice();
			 Returnborrow();
		 });
		 
		 jQuery(bqhhje).bindPropertyChange(function(){
			  var bqhhje_val = jQuery(bqhhje).val().replace(/,/gi,'');
			 var nodesnum0 = jQuery("#nodesnum0").val();
			 if(nodesnum0==1){
				var maxnum = jQuery("#indexnum0").val()-1;
				jQuery(hkje+maxnum).val(Number(bqhhje_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
       	        jQuery(hkje+maxnum+"span").html("");  
				calSum(0);
			  }
			 if(nodesnum0==0){
				addRow0(0);
				var maxnum = jQuery("#indexnum0").val()-1;
				jQuery(hkje+maxnum).val(Number(bqhhje_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
       	        jQuery(hkje+maxnum+"span").html("");
				calSum(0);
			 }
			  
				 
			 
		 });
		  jQuery(hkhz).bindPropertyChange(function () {
			var hkmxhz_val = jQuery(hkhz).val().replace(/,/gi,'');
			if(Number(hkmxhz_val) !=Number('0')){
			
				var bqhhje_val = jQuery(bqhhje).val().replace(/,/gi,'');
				if(Number(hkmxhz_val)<Number(bqhhje_val)){
				addRow0(0);
				var maxnum = jQuery("#indexnum0").val()-1;
					var xhkje = Number(bqhhje_val)-Number(hkmxhz_val);
					jQuery(hkje+maxnum).val(Number(xhkje).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
					jQuery(hkje+maxnum+"span").html("");
					calSum(0);
				}
			}
       })
		 
		checkCustomize = function () {
			var bqhhje_val = jQuery(bqhhje).val();
			var bqtkje_val = jQuery(bqtkje).val();
			var hkhz_val = jQuery(hkhz).val();
			var tkhz_val = jQuery(tkhz).val();
	
			if(hkhz_val != bqhhje_val){
				alert("友情提示：本期还款金额不符，请检查后提交");
				return false;
			}
			return true;
		}
	});
    function adddt1(){
		var hkmxhz_val = jQuery(hkhz).val().replace(/,/gi,'');
        var bqhhje_val = jQuery(bqhhje).val().replace(/,/gi,'');
        if(Number(hkmxhz_val)<Number(bqhhje_val)){
        	addRow0(0);
        	var maxnum = jQuery(indexnum0).val()-1;
       	var xhkje = Number(bqhhje_val)-Number(hkmxhz_val);
        	jQuery(hkje+maxnum).val(comdify(xhkje.toFixed(2)));
       	jQuery(hkje+maxnum+"span").html("");
        }
	}
   

    function comdify(n){
　　    var re=/\d{1,3}(?=(\d{3})+$)/g;
　　    var n1=n.replace(/^(\d+)((\.\d+)?)$/,function(s,s1,s2){return s1.replace(re,"$&,")+s2;});
　　    return n1;
	}

	function Returnborrow(){
		var kh_val=jQuery(kh).val();
		var indexnum1=  jQuery("#indexnum1").val();
		if(kh_val == ""){
		return;	
		}
		
		var xhr1 = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr1 = new XMLHttpRequest();
		}
		if (null != xhr1) {
			xhr1.open("GET","/seahonor/expenses/getborrowinfo-gwkhk.jsp?type=0&gwkid="+kh_val, false);
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
							//alert(tmp_arr);						
							addRow1(1);
							jQuery(tkje_dt2+i).val(tmp_arr[0]);
							jQuery(tkje_dt2+i+"span").text(tmp_arr[0]);
							jQuery(tkrq_dt2+i).val(tmp_arr[1]);
							jQuery(tkrq_dt2+i+"span").text(tmp_arr[1]);
							jQuery(tkyy_dt2+i).val(tmp_arr[2]);
							jQuery(tkyy_dt2+i+"span").text(tmp_arr[2]);
							jQuery(lcdh_dt2+i).val(tmp_arr[3]);
							jQuery(lcdh_dt2+i+"span").text(tmp_arr[4]);
							 
						}
					}
				}
			}
			xhr1.send(null);
		}
		 calSum(1);
	 }

	function getborrowrmb(){
		var kh_val=jQuery(kh).val();
		var indexnum2=  jQuery("#indexnum2").val();
		var xhr1 = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr1 = new XMLHttpRequest();
		}
		if (null != xhr1) {
			xhr1.open("GET","/seahonor/expenses/getborrowinfo-gwkhk.jsp?type=1&gwkid="+kh_val, false);
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
							
							addRow2(2);
							jQuery(sjky_dt3+i).val(tmp_arr[0]);
							jQuery(dissjky_dt3+i).val(tmp_arr[0]);
							jQuery(disbz_dt3+i).val(tmp_arr[1]);
							jQuery(dissjky_dt3+i).val(tmp_arr[1]);
							jQuery(je_dt3+i).val(tmp_arr[2]);
							jQuery(je_dt3+i+"span").text(tmp_arr[2]);
							jQuery(sjskrq_dt3+i).val(tmp_arr[3]);
							jQuery(sjskrq_dt3+i+"span").text(tmp_arr[3]);
							jQuery(xfsx_dt3+i).val(tmp_arr[4]);
							jQuery(xfsx_dt3+i+"span").text(tmp_arr[4]);
							jQuery(lcdh_dt3+i).val(tmp_arr[5]);
							jQuery(lcdh_dt3+i+"span").text(tmp_arr[6]);
							 
						}
					}
				}
			}
			xhr1.send(null);
		}
		 calSum(2);
	 }
	function doservice(){
		var kh_val=jQuery(kh).val();
		if(kh_val != ""){
		   getborrowrmb();
		}
	}
	function deletedata(){
		// var nodesnum0 = jQuery("#nodesnum0").val();
		//if(nodesnum0 >0){
		//	jQuery("[name = check_node_0]:checkbox").attr("checked", true);
		//	adddelid(0,hkje);
		//	removeRow0(0);
		//}	
		var nodesnum0 = jQuery("#nodesnum0").val();
		var nodesnum1 = jQuery("#nodesnum1").val();
		if(nodesnum0 >0){
	       jQuery("[name = check_node_0]:checkbox").attr("checked", true);
	        adddelid(0,hkje);
	        removeRow0(0);
	    }
		if(nodesnum1 >0){
	       jQuery("[name = check_node_1]:checkbox").attr("checked", true);
	        adddelid(1,tkje_dt2);
	        removeRow0(1);
	    }
		var nodesnum2 = jQuery("#nodesnum2").val();
		if(nodesnum2 >0){
			jQuery("[name = check_node_2]:checkbox").attr("checked", true);
			adddelid(2,sjky_dt3);
			removeRow0(2);
		}
       
       		
	}
	function getData(){
		var indexnum0 = jQuery("#indexnum0").val();
		for(var index=0;index < indexnum0;index++){
			var hkfs_fid = hkfs + index;
			var fkyhzh_fid = fkyhzh + index;
			
			var fkgs_fid = fkgs + index;
			if(jQuery(hkfs_fid).length > 0){
				var hkfs_val = jQuery(hkfs_fid).val();
				if(hkfs_val == "0"){
					
					jQuery(fkyhzh_fid).val("");
					jQuery(fkyhzh_fid+"_readonlytext").text("");
					jQuery(fkgs_fid).val("");
					jQuery(fkgs_fid+"span").text("");
				}
			}
		}
		

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
function _isdel(){
    return true;
} 
</script>























