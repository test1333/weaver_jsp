<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var xzht="#field10495";//选择合同
    var sfyyjssplc="#field10468";//是否已有结算审批流程
    var lxkyje="#field10762";//立项可用金额
    var sjjsce="#field10471";//超合同结算金额
    var htje="#field10511";//合同金额
    var sfzzfk="#field10476";//是否最终付款
    var htbczfje="#field10525";//合同本次支付金额
    var htyzfje="#field10474";//合同已支付金额
    var jd_dt1="#field10533_";//明细1-阶段
    var bl_dt1="#field10534_";//明细1-比例
    var je_dt1="#field10546_";//明细1-金额
    var ljzfje_dt1="#field10543_";//明细1-累计支付金额
    var ljbxje_dt1="#field10541_";//明细1-累计报销金额
    var ssht_dt1="#field10548_";//明细1-所属合同明细id
    var bczfje_dt1="#field10544_";//明细1-本次支付金额
    var sjjsje="#field10475";//实际结算金额
    var jsje="#field10470";//结算金额
    var sfyys="#field13246";//是否有预算
	var fknd="#field13245";//付款年度
	var dqnd="#field13341";//当前年度
     jQuery(document).ready(function(){
     	 
     	 jQuery("button[name=addbutton0]").css('display','none');
          jQuery(sfyyjssplc).bind("change",function () {
         	 var sfyyjssplc_val = jQuery(sfyyjssplc).val();
         	 if(sfyyjssplc_val=="0"){
         	 	 jQuery(sfzzfk).val("0");
             }else{
                	 jQuery(sfzzfk).val("");
            }
          });
          jQuery(xzht).bindPropertyChange(function (){ 
          	  var xzht_val=jQuery(xzht).val();
          	  var nodesnum0 = jQuery("#nodesnum0").val();
          	  if(nodesnum0 >0){
          	jQuery("[name = check_node_0]:checkbox").attr("checked", true);
          	    adddelid(0,jd_dt1);
          	    removeRow0(0);
          }
             if(xzht_val !=''){
             	 dodetail(xzht_val);
             }
         });
         
        checkCustomize = function () {
        	  var sfyyjssplc_val=jQuery(sfyyjssplc).val();
        	  var lxkyje_val=jQuery(lxkyje).val();
               var htbczfje_val=jQuery(htbczfje).val();
        	  var htyzfje_val=jQuery(htyzfje).val();
               var htje_val= jQuery(htje).val();
               var sfyys_val=jQuery(sfyys).val();
			   var fknd_val = jQuery(fknd).val();
			    var dqnd_val = jQuery(dqnd).val();
               if(sfyys_val == "1"){
               	  Dialog.alert("该合同关联的项目是否有预算为否，无法提交");
        	  	  return false;
               }
			   if(fknd_val !="" && fknd_val > dqnd_val){
               	  Dialog.alert("付款年度不能大于当前年度，请检查");
        	  	  return false;
               }
               if(lxkyje_val ==''){
                  lxkyje_val = '0';	
               }
                if(htje_val ==''){
                	htje_val = '0';	
                }
        		if(htbczfje_val ==''){
                	    htbczfje_val = '0';	
                	}
                	if(htyzfje_val ==''){
                	    htyzfje_val = '0';	
                	}
        	  if(sfyyjssplc_val == '0'){      	  	 
        	  	  var sjjsce_val=jQuery(sjjsce).val();	  
                	    	if(sjjsce_val ==''){
                			sjjsce_val = '0';	
                	       }
        	  	  if(Number(sjjsce_val)>Number(lxkyje_val)){
        	  	  	  Dialog.alert("超合同结算金额大于项目可用金额，请提交立项变更流程");
        	  	  	  return false;
        	         }
        	         
        	         var sjjsje_val=jQuery(sjjsje).val();
        	         	if(sjjsje_val ==''){
                			sjjsje_val = '0';	
                	       }
        	          var jsje_val=jQuery(jsje).val();
        	          	if(jsje_val ==''){
                			jsje_val = '0';	
                	       }
        	        if(Number(sjjsje_val) != Number(jsje_val)){
        	  	  	  Dialog.alert("实际结算金额不等于结算金额，请检查");
        	  	  	  return false;
        	         }
        	   }
        	  
        	   if(Number(htje_val) !=0){
        	  var indexnum0=  jQuery("#indexnum0").val();
        	    for( var index=0;index<indexnum0;index++){
        	    	 if( jQuery(bczfje_dt1+index).length>0){
        	    	 	 var bczfje_dt1_val=jQuery(bczfje_dt1+index).val();
        	    	 	 var je_dt1_val=jQuery(je_dt1+index).val();
        	    	 	 var ljzfje_dt1_val=jQuery(ljzfje_dt1+index).val();
        	    	 	if(bczfje_dt1_val ==''){
                			bczfje_dt1_val = '0';	
                	       }
                	   	if(je_dt1_val ==''){
                			je_dt1_val = '0';	
                	       }
                	    	if(ljzfje_dt1_val ==''){
                			ljzfje_dt1_val = '0';	
                	       }
                	       if(Number(bczfje_dt1_val)+Number(ljzfje_dt1_val)>Number(je_dt1_val)){
                	   	   Dialog.alert("明细存在付款金额+累计支付金额 超过计划付款的金额的情况，请检查");
                	   	   return false;
                	   	}
        	    	 }
        	     }
        	}else{
        	
                	if(Number(htbczfje_val)+Number(htyzfje_val)>Number(lxkyje_val)){
                		Dialog.alert("本次支付金额+已支付金额大于立项可用金额，请检查");
                		return false;		
                   }
           }
           var sfzzfk_val=jQuery(sfzzfk).val();
           if(sfzzfk_val=='0'){
           	      if(sfyyjssplc_val !='0'){
            	if(Number(htbczfje_val)+Number(htyzfje_val)>Number(htje_val)){
                		Dialog.alert("本次支付金额+已支付金额大于合同金额，请关联结算流程");
                		return false;		
                   }
               }
           }
           
           return true;
        }
     });
     
     function dodetail(xzht_val){
	     var indexnum1=  jQuery("#indexnum0").val();
	   var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
	xhr.open("GET","/gvo/ec/project/getxmhtdetail.jsp?hth="+xzht_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		var text = xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum1);
		for(var i=indexnum1;i<length1;i++){
		  addRow0(0);
		  var tmp_arr = text_arr[i-indexnum1].split("###");
		  jQuery(jd_dt1+i).val(tmp_arr[0]);
		  jQuery(jd_dt1+i+"span").text(tmp_arr[0]);
		  jQuery(bl_dt1+i).val(tmp_arr[1]);
		  jQuery(bl_dt1+i+"span").text(tmp_arr[1]);
		  jQuery(je_dt1+i).val(tmp_arr[2]);
		  jQuery(je_dt1+i+"span").text(tmp_arr[2]);
		  jQuery(ljzfje_dt1+i).val(tmp_arr[3]);
		  jQuery(ljzfje_dt1+i+"span").text(tmp_arr[3]);
		   jQuery(ljbxje_dt1+i).val(tmp_arr[4]);
		  jQuery(ljbxje_dt1+i+"span").text(tmp_arr[4]);
		  jQuery(ssht_dt1+i).val(tmp_arr[5]);
	     }
          }
	  }
	 }
       xhr.send(null);
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
    }	}catch(e){}
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

