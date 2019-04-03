<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var lxkyje="#field10284";//立项可用金额
    var sfbg="#field8348";//是否变更--合同金额
    var htje="#field_lable8362";//合同金额
    var bgce1="#field10283";//变更差额
    var xzht="#field8308";//选择合同
    var jd_dt1="#field8339_";//明细1-阶段
    var bl_dt1="#field8340_";//明细1-比例
    var je_dt1="#field10368_";//明细1-金额
    var fkrq_dt1="#field10129_";//明细1-付款日期
    var sffk_dt1="#field10363_";//明细1-是否付款
    var ssht_dt1="#field10364_";//明细1-所属合同明细id
    var yfje_dt1 = "#field11348_";//明细1-已付金额明细
    var bghhsje="#field8365";//变更后核算为人民币金额
    var sfcg="#field8290";//是否超过5000W
       var sfyy="#field8302";//是否用印
    var gz="#field8303";//公章
    var htz="#field8304";//合同章
    var frz="#field8305";//法人章
    var frqz="#field8306";//法人签字
    
    var bhsj="#field8349"//变更时间
    var htksrq="#field8366";//合同开始日期
    var htjsrq="#field11162";//合同结束日期
     jQuery(document).ready(function(){
     jQuery(htje).attr("readonly", "readonly");
     var sfbg_val = jQuery(sfbg).val();
	dodetail1(sfbg_val);	 
      jQuery(bghhsje).bindPropertyChange(function () {
         var bghhsje_val= jQuery(bghhsje).val();
          if(Number(bghhsje_val)>50000000){
                jQuery(sfcg).val("0");
             }else{
                jQuery(sfcg).val("1");
             }
       })
        var sfyy_val=jQuery(sfyy).val();
         if(sfyy_val == "1"){
         	jQuery(gz).attr("disabled", "disabled");
             jQuery(htz).attr("disabled", "disabled");
            jQuery(frz).attr("disabled", "disabled");
            jQuery(frqz).attr("disabled", "disabled");
         }   
       jQuery(sfyy).bind("change",function(){
        var sfyy_val=jQuery(sfyy).val();
          if(sfyy_val == "1"){
        	jQuery("span").removeClass("jNiceChecked");
        	jQuery(gz).val("0");
        	jQuery(htz).val("0");
        	jQuery(frz).val("0");
        	jQuery(frqz).val("0");
        	jQuery(gz).attr("disabled", "disabled");
             jQuery(htz).attr("disabled", "disabled");
            jQuery(frz).attr("disabled", "disabled");
            jQuery(frqz).attr("disabled", "disabled");
          }else{
          	  	jQuery(gz).attr("disabled", "");
             jQuery(htz).attr("disabled", "");
            jQuery(frz).attr("disabled", "");
            jQuery(frqz).attr("disabled", "");
       }
       });
	jQuery(sfbg).bindPropertyChange(function (){ 
		var sfbg_val = jQuery(sfbg).val();
		dodetail1(sfbg_val);
      })
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
        	     var sfyy_val=jQuery(sfyy).val();
        	      if(sfyy_val == "0"){
        	        var gz_val=jQuery(gz).is(':checked') ;
        	        var htz_val=jQuery(htz).is(':checked') ;
        	        var frz_val=jQuery(frz).is(':checked') ;
        	        var frqz_val=jQuery(frqz).is(':checked') ;
        	          if(gz_val == false && htz_val== false && frz_val== false  && frqz_val== false  ){
			       Dialog.alert("用印名称，请至少勾选1项！");
			      return false;
			    }
   		
        	       }
        	       var bhsj_val=jQuery(bhsj).val();
        	      var htksrq_val=jQuery(htksrq).val();
        	      var htjsrq_val=jQuery(htjsrq).val();
        	     if(bhsj_val=="0"){
        	      if(htjsrq_val<htksrq_val){
        	      	   Dialog.alert("合同结束日期必须大于等于开始日期");
        	      	   return false;
        	     }
        	} 
        	       var indexnum0=  jQuery("#indexnum0").val();
        	       var countnum=0;
        	       for(var index=0;index <indexnum0;index++){
        	         	 if( jQuery(je_dt1+index).length>0){
        	         	 	 countnum = countnum+1;
        	         	 	var je_dt1_val=  jQuery(je_dt1+index).val();
        	         	    	var yfje_dt1_val=  jQuery(yfje_dt1+index).val();
        	         	    	if(je_dt1_val == ""){
        	         	    	je_dt1_val="0";		
        	         	      }
        	         	      if(yfje_dt1_val == ""){
        	         	    	yfje_dt1_val="0";		
        	         	      }
        	         	    	if(Number(je_dt1_val)<Number(yfje_dt1_val)){
        	         	    		Dialog.alert("第"+countnum+"行明细，金额小于已付款金额，请检查");
        	         	    		return false;
        	         	      }
        	         	}        	                 	        
        	       }
        	      var sfbg_val=jQuery(sfbg).val();
        		var lxkyje_val=jQuery(lxkyje).val();
        		var bgce_val=jQuery(bgce1).val();
        		if(sfbg_val == '0'){
        		    	if(lxkyje_val ==''){
                			lxkyje_val = '0';	
                	       }
                	   	if(bgce_val ==''){
                			bgce_val = '0';	
                	       }
                	      if(Number(bgce_val)>Number(lxkyje_val)){
          	      	  Dialog.alert("变更差额大于立项可用预算,请检查");
          	      	  return false;
          	           }
        	      }
        	      return true;
        }
     });
     function dodetail1(sfbg_val){
        if(sfbg_val=="0"){
        	jQuery("#butt0").show();
        }else{
       	jQuery("#butt0").hide();
        }
         var indexnum0=  jQuery("#indexnum0").val();
         for(var index=0;index <indexnum0;index++){
        	if( jQuery(je_dt1+index).length>0){
         	 	if(sfbg_val == "0"){
         	 	jQuery(je_dt1+index).removeAttr("readonly");
         	 	}else{
         	 	jQuery(je_dt1+index).attr("readonly", "readonly");
         	 	}	
            }
          }
     }
     function dodetail(xzht_val){
	     var indexnum1=  jQuery("#indexnum0").val();
	   var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
	xhr.open("GET","/gvo/ec/project/gethtdetail.jsp?hth="+xzht_val, false);
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
		  var sffk_dt1_val=tmp_arr[4];
		  jQuery(sffk_dt1+i).val(sffk_dt1_val);
		   jQuery(ssht_dt1+i).val(tmp_arr[5]);
		   jQuery(jd_dt1+i).val(tmp_arr[0]);
		   jQuery(bl_dt1+i).val(tmp_arr[1]);
		   jQuery(je_dt1+i).val(tmp_arr[2]);
		   jQuery(fkrq_dt1+i).val(tmp_arr[3]);
		     jQuery(fkrq_dt1+i+"span").text(tmp_arr[3]);
		     jQuery(yfje_dt1+i).val(tmp_arr[6]);
		      jQuery(yfje_dt1+i+"span").text(tmp_arr[6]);
		  if(sffk_dt1_val == '0'){
			  jQuery(fkrq_dt1+i+"browser").attr('disabled',true);
			  jQuery(jd_dt1+i).attr("readonly", "readonly");
			  jQuery(bl_dt1+i).attr("readonly", "readonly");
			  jQuery(je_dt1+i).attr("readonly", "readonly");
			  
	       }
	        jQuery(jd_dt1+i+"span").html("");
	        jQuery(bl_dt1+i+"span").html("");
	        jQuery(je_dt1+i+"span").html("");
	        jQuery(fkrq_dt1+i+"spanimg").html("");
	     }
          }
	  }
	 }
       xhr.send(null);
     }
     calSum(0);
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


