<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
    var xzht="#field10495";//ѡ���ͬ
    var sfyyjssplc="#field10468";//�Ƿ����н�����������
    var lxkyje="#field10762";//������ý��
    var sjjsce="#field10471";//����ͬ������
    var htje="#field10511";//��ͬ���
    var sfzzfk="#field10476";//�Ƿ����ո���
    var htbczfje="#field10525";//��ͬ����֧�����
    var htyzfje="#field10474";//��ͬ��֧�����
    var jd_dt1="#field10533_";//��ϸ1-�׶�
    var bl_dt1="#field10534_";//��ϸ1-����
    var je_dt1="#field10546_";//��ϸ1-���
    var ljzfje_dt1="#field10543_";//��ϸ1-�ۼ�֧�����
    var ljbxje_dt1="#field10541_";//��ϸ1-�ۼƱ������
    var ssht_dt1="#field10548_";//��ϸ1-������ͬ��ϸid
    var bczfje_dt1="#field10544_";//��ϸ1-����֧�����
    var sjjsje="#field10475";//ʵ�ʽ�����
    var jsje="#field10470";//������
    var sfyys="#field13246";//�Ƿ���Ԥ��
	var fknd="#field13245";//�������
	var dqnd="#field13341";//��ǰ���
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
               	  Dialog.alert("�ú�ͬ��������Ŀ�Ƿ���Ԥ��Ϊ���޷��ύ");
        	  	  return false;
               }
			   if(fknd_val !="" && fknd_val > dqnd_val){
               	  Dialog.alert("������Ȳ��ܴ��ڵ�ǰ��ȣ�����");
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
        	  	  	  Dialog.alert("����ͬ�����������Ŀ���ý����ύ����������");
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
        	  	  	  Dialog.alert("ʵ�ʽ�������ڽ��������");
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
                	   	   Dialog.alert("��ϸ���ڸ�����+�ۼ�֧����� �����ƻ�����Ľ������������");
                	   	   return false;
                	   	}
        	    	 }
        	     }
        	}else{
        	
                	if(Number(htbczfje_val)+Number(htyzfje_val)>Number(lxkyje_val)){
                		Dialog.alert("����֧�����+��֧��������������ý�����");
                		return false;		
                   }
           }
           var sfzzfk_val=jQuery(sfzzfk).val();
           if(sfzzfk_val=='0'){
           	      if(sfyyjssplc_val !='0'){
            	if(Number(htbczfje_val)+Number(htyzfje_val)>Number(htje_val)){
                		Dialog.alert("����֧�����+��֧�������ں�ͬ���������������");
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
	   if (window.ActiveXObject) {//IE�����
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

