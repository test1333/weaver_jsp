<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var cgjd="#field11002";//�ɹ�����
	var htbczfje="#field9973";//��ͬ����֧�����
	var ddje="#field11324";//�������
	var ddyzfje="#field11325";//������֧�����
	var fkspzje="#field11327";//���������н��
	var htlx = "#field9963";//��ͬ����
	var xmkyys = "#field13185";//��Ŀ����Ԥ��
     jQuery(document).ready(function(){
     	 checkCustomize = function () {
     	 	 var htbczfje_val=jQuery(htbczfje).val();
     	 	 var ddje_val=jQuery(ddje).val();
     	 	 var ddyzfje_val=jQuery(ddyzfje).val();
     	 	 var fkspzje_val=jQuery(fkspzje).val();
     	 	 var cgjd_val=jQuery(cgjd).val();
			  var htlx_val=jQuery(htlx).val();
     	 	 var xmkyys_val=jQuery(xmkyys).val();
	     	 if(ddyzfje_val==""){
	     	 	 ddyzfje_val="0";	 
	     	 }
	     	 if(fkspzje_val==""){
	     	 	 fkspzje_val="0";	 
	     	 }
	     	 if(xmkyys_val==""){
	     	 	 xmkyys_val="0";	 
	     	 }
	     	 
	     	 if(htlx_val == "1" && htbczfje_val !=""){
	     	    if(Number(htbczfje_val)>Number(xmkyys_val)){
	     	    	 Dialog.alert("����֧����������Ŀ����Ԥ�㣬����");
	     	 	 	 return false;
	     	    }
	         }
     	 	 if(cgjd_val !=''){
	     	 	 if(ddje_val==""){
	     	 	    ddje_val="0";	 
	     	       }
	     	 	 if(htbczfje_val !=""){
	     	 	 	 var allmoney=accAdd(htbczfje_val,ddyzfje_val);
	     	 	 	 allmoney=accAdd(allmoney,fkspzje_val);
	     	 	 	 if(Number(allmoney)>Number(ddje_val)){
	     	 	 	   	 Dialog.alert("����֧�������ڶ�����֧��������");
	     	 	 	   	 return false;
	     	 	       }
	     	       }
     	   }
     	       return true;
              }
     });
  function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
  } 
</script>


