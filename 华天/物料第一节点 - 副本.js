
<script type="text/javascript">
     
  var zxfl ="#field10890_";//最小分类
  var lh ="#field10889_";//料号
  var pm = "#field10892_";
  var gg = "#field10893_";
  var xh = "#field10894_";


	jQuery(document).ready(function () {
		  checkCustomize = function(){
       var indexnum0=  jQuery("#indexnum0").val();
       var zxfls='';
       var lhs='';
       var checks='';
      var flag='';
       for(var index = 0;index<indexnum0;index++){
         var zxfl_val = jQuery(zxfl+index).val();
         var pm_val = jQuery(pm+index).val();
         var gg_val = jQuery(gg+index).val();
         var xh_val = jQuery(xh+index).val();
   
         if(zxfl_val == ''){
           alert("请先填写最小分类。")
           return false;
         }
         if(pm_val == ''){
           alert("请先填写品名。")
           return false;
         }
         if(gg_val == ''){
           alert("请先填写规格。")
           return false;
         }
         if(xh_val == ''){
           alert("请先填写型号。")
           return false;
         }
        checks=checks+flag+pm_val+'%23%23'+gg_val+'%23%23'+xh_val;

         zxfls = zxfls+flag+zxfl_val;
         flag="%23%23%23";
         
       }
       var text =getresult(zxfls,'false',checks);
         if(text != ''){
           alert(text);
           return false;
         }
       return true;
      }
	});

 function getresult(zxfls,lhs,checks){
   var xhr = null;
   var text='';
   if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
   } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
   }
   if (null != xhr) {	   
	xhr.open("GET","/htkj/materiel/MaterielToKin.jsp?id="+zxfls+"&lhs="+lhs+"&checks="+checks, false);
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














