
<script type="text/javascript">
     
  var zxfl ="#field10890_";//最小分类
  var lh ="#field10889_";//料号
  var lhold = "#field11541_";//料号old


	jQuery(document).ready(function () {
		  checkCustomize = function(){
       var indexnum0=  jQuery("#indexnum0").val();
       var zxfls='';
       var lhs='';
      var flag='';
      var flag1='';
       for(var index = 0;index<indexnum0;index++){
         var zxfl_val = jQuery(zxfl+index).val();
         var lh_val = jQuery(lh+index).val();
          var lhold_val = jQuery(lhold+index).val();
         if(zxfl_val == ''){
           alert("请先填写最小分类。")
           return false;
         }
         if(lh_val == ''){
          alert("请先填写料号。")
           return false;
         }	 
         if(lhold_val != '' && lh_val == lhold_val){

         }else{
         lhs=lhs+flag1+lh_val;
         flag1="%23%23%23";
         }
         zxfls = zxfls+flag+zxfl_val;
         flag="%23%23%23";
         
       }
       var text =getresult(zxfls,lhs);
         if(text != ''){
           alert(text);
           return false;
         }
       return true;
      }
	});

 function getresult(zxfls,lhs){
   var xhr = null;
   var text='';
   if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
   } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
   }
   if (null != xhr) {	   
	xhr.open("GET","/htkj/materiel/MaterielToKin.jsp?id="+zxfls+"&lhs="+lhs+"&checks=false", false);
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












