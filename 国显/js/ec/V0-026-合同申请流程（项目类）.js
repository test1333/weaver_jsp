<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
     var hswrmbje="#field8050";//����Ϊ����ҽ��
    var lxkyje="#field10223";//������ý��
       var sfcg ="#field8165";//�Ƿ񳬹�5000W
    var xzht="#field8223";//ѡ���ͬ��Ƭ
    var jd_dt1="#field8161_";//��ϸ1-�׶�
    var bl_dt1="#field8162_";//��ϸ1-����
    var je_dt1="#field11181_";//��ϸ1-���
    var fkrq_dt1="#field9794_";//��ϸ1-��������
     var sfyy="#field8063";//�Ƿ���ӡ
    var gz="#field8064";//����
    var htz="#field8065";//��ͬ��
    var frz="#field8066";//������
    var frqz="#field8067";//����ǩ��
    var htksrq="#field8052";//��ͬ��ʼ����
    var htjsrq="#field8053";//��ͬ��������
     jQuery(document).ready(function(){
       jQuery(hswrmbje).bindPropertyChange(function () {
         var hswrmbje_val= jQuery(hswrmbje).val();
          if(Number(hswrmbje_val)>50000000){
                jQuery(sfcg).val("0");
            //  alert("1");
             }else{
                jQuery(sfcg).val("1");
             }
       });
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
        	        var htksrq_val=jQuery(htksrq).val();
        	      var htjsrq_val=jQuery(htjsrq).val();
        	      if(htjsrq_val<htksrq_val){
        	      	   Dialog.alert("��ͬ�������ڱ�����ڵ��ڿ�ʼ����");
        	      	   return false;
        	     }
          	  	var hswrmbje_val=jQuery(hswrmbje).val();
          	      var lxkyje_val=jQuery(lxkyje).val();
          	      	if(hswrmbje_val ==''){
                			hswrmbje_val = '0';	
                	       }
                	   	if(lxkyje_val ==''){
                			lxkyje_val = '0';	
                	       }
          	      if(Number(hswrmbje_val)>Number(lxkyje_val)){
          	      	  Dialog.alert("��ͬ����������Ŀ��������ý��,����");
          	      	  return false;
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
		   jQuery(jd_dt1+i).val(tmp_arr[0]);
		   jQuery(bl_dt1+i).val(tmp_arr[1]);
		   jQuery(je_dt1+i).val(tmp_arr[2]);
		   jQuery(fkrq_dt1+i).val(tmp_arr[3]);
	          jQuery(fkrq_dt1+i+"span").text(tmp_arr[3]);
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
