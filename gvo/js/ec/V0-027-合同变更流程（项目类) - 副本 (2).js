<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
    var lxkyje="#field10284";//������ý��
    var sfbg="#field8348";//�Ƿ���--��ͬ���
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
     jQuery(document).ready(function(){
      jQuery(bghhsje).bindPropertyChange(function () {
         var bghhsje_val= jQuery(bghhsje).val();
          if(Number(bghhsje_val)>50000000){
                jQuery(sfcg).val("0");
             }else{
                jQuery(sfcg).val("1");
             }
       })

          jQuery(xzht).bindPropertyChange(function (){ 
          	  var xzht_val=jQuery(xzht).val();
          	  var nodesnum0 = jQuery("#nodesnum0").val();
          	  if(nodesnum0 >0){
          	jQuery("[name = check_node_0]:checkbox").attr("checked", true);
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
			       alert("��ӡ���ƣ������ٹ�ѡ1�");
			      return false;
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
          	      	  alert("����������������Ԥ��,����");
          	      	  return false;
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


