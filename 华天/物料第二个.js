
<script type="text/javascript">
     
  var zxfl ="#field10890_";//��С����
  var lh ="#field10889_";//�Ϻ�
  var lhold = "#field11541_";//�Ϻ�old
  var dm="#field10891_";//��ˮ��


	jQuery(document).ready(function () {
		  checkCustomize = function(){
       var indexnum0=  jQuery("#indexnum0").val();
       var zxfls='';
       var lhs='';
      var flag='';
      var flag1='';
      var lsms="";
       for(var index = 0;index<indexnum0;index++){
         var zxfl_val = jQuery(zxfl+index).val();
         var lh_val = jQuery(lh+index).val();
          var lhold_val = jQuery(lhold+index).val();
          var dm_val = jQuery(dm+index).val();
         if(zxfl_val == ''){
           alert("������д��С���ࡣ")
           return false;
         }
         if(lh_val == ''){
          alert("������д�Ϻš�")
           return false;
         }	 
         if(dm_val == ''){
          alert("������д��ˮ�롣")
           return false;
         }	 
         var lsm_val=zxfl_val+"."+dm_val;
         if(lhold_val != '' && lh_val == lhold_val){
         }else{
         lsms=lsms+flag1+lsm_val;
         lhs=lhs+flag1+lh_val;
         flag1="%23%23%23";
         }
         zxfls = zxfls+flag+zxfl_val;
         flag="%23%23%23";
         
       }
       var text =getresult(zxfls,lhs,lsms);
         if(text != ''){
           alert(text);
           return false;
         }
       return true;
      }
	});

 function getresult(zxfls,lhs,lsms){
   var xhr = null;
   var text='';
   if (window.ActiveXObject) {//IE�����
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
   } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
   }
   if (null != xhr) {	   
	xhr.open("GET","/htkj/materiel/MaterielToKin.jsp?id="+zxfls+"&lhs="+lhs+"&checks=false"+"&lsms="+lsms, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		 text= xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
	   }
      }
     }
	 xhr.send(null);
   }
   return text;
 }




</script>
















