<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
    var lxkyje="#field10284";//������ý��
    var sfbg="#field8348";//�Ƿ���--��ͬ���
    var htje="#field_lable8362";//��ͬ���
    var bgce1="#field10283";//������
    var xzht="#field8308";//ѡ���ͬ
    var jd_dt1="#field8339_";//��ϸ1-�׶�
    var bl_dt1="#field8340_";//��ϸ1-����
    var je_dt1="#field10368_";//��ϸ1-���
    var fkrq_dt1="#field10129_";//��ϸ1-��������
    var sffk_dt1="#field10363_";//��ϸ1-�Ƿ񸶿�
    var ssht_dt1="#field10364_";//��ϸ1-������ͬ��ϸid
    var yfje_dt1 = "#field11348_";//��ϸ1-�Ѹ������ϸ
    var bghhsje="#field8365";//��������Ϊ����ҽ��
    var sfcg="#field8290";//�Ƿ񳬹�5000W
       var sfyy="#field8302";//�Ƿ���ӡ
    var gz="#field8303";//����
    var htz="#field8304";//��ͬ��
    var frz="#field8305";//������
    var frqz="#field8306";//����ǩ��
    
    var bhsj="#field8349"//���ʱ��
    var htksrq="#field8366";//��ͬ��ʼ����
    var htjsrq="#field11162";//��ͬ��������
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
			       Dialog.alert("��ӡ���ƣ������ٹ�ѡ1�");
			      return false;
			    }
   		
        	       }
        	       var bhsj_val=jQuery(bhsj).val();
        	      var htksrq_val=jQuery(htksrq).val();
        	      var htjsrq_val=jQuery(htjsrq).val();
        	     if(bhsj_val=="0"){
        	      if(htjsrq_val<htksrq_val){
        	      	   Dialog.alert("��ͬ�������ڱ�����ڵ��ڿ�ʼ����");
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
        	         	    		Dialog.alert("��"+countnum+"����ϸ�����С���Ѹ��������");
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
          	      	  Dialog.alert("����������������Ԥ��,����");
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
	   if (window.ActiveXObject) {//IE�����
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
					//��¼��ɾ���ľɼ�¼ id��
					if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
						if($G("deldtlid"+groupid).value!=''){
							//����ϸ
							$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
						}else{
							//����ϸ
							$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
						}
					}
					//���ύ��Ŵ���ɾ����ɾ������
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
        alert('��ѡ����Ҫɾ��������');
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


