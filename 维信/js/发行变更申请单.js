<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var wjbh="#field8990";//文件编号
var bb="#field8991";//版本
jQuery(document).ready(function() { showhide();
jQuery(wjbh).bind('change',function () {
	var isexist=checkisexist();
	if(isexist == "1"){
		alert("文件编号已存在！");
	}
})
jQuery(bb).bind('change',function () {
	var isexist=checkisexist();
	if(isexist == "1"){
		alert("文件编号已存在！");
	}
})
 checkCustomize = function () {
		 var wjbh_val = jQuery(wjbh).val();
		 wjbh_val=trimStr(wjbh_val);
		 jQuery(wjbh).val(wjbh_val);
		 var bb_val = jQuery(bb).val();
		 bb_val = trimStr(bb_val);
		  jQuery(bb).val(bb_val);
		 var isexist=checkisexist();
	     
		 if(isexist == "1"){
				alert("文件编号已存在！");
				return false;
		}
		 
		 return true;
	 }
});
function checkisexist(){
	 var isexist="";
	     var wjbh_val = jQuery(wjbh).val();
		  var bb_val = jQuery(bb).val();
		 var rqid=document.getElementsByName("requestid")[0].value;
		 if(rqid == ""){
			 rqid = "-1";
		 }
		 wjbh_val=trimStr(wjbh_val);
		  bb_val = trimStr(bb_val);
		 if(wjbh_val !="" && bb_val !=""){
			 jQuery.ajax({
				 type: "POST",
				 url: "/weixin/checkwjbh.jsp",
				 data: {'wjbh':wjbh_val, 'rqid':rqid,'revision':bb_val},
				 dataType: "text",
				 async:false,//同步   true异步
				 success: function(data){
							data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							isexist=data;
				}
			});
			
		 }
		 return isexist;
	
}

var type1 ="#field9013";
var type ="#field9014";

   jQuery(type1).bind("change",function(){
    var type_val = jQuery(type).val();
    showhide();
    });
  jQuery(type).bind("change",function(){
    var type_val = jQuery(type).val();
    showhide();
    });
	
	


function showhide()
{

   var mxi1_val =    jQuery(type1).val();
   var mxi2_val =    jQuery(type).val();

   if(mxi1_val == "")
  {
        jQuery("#mx3").hide();  
  }
  else if(mxi1_val == "0")
  {
        jQuery("#mx3").show();  
  }  else if(mxi1_val == "1")
  {
        jQuery("#mx3").hide();  
  }

   if(mxi2_val == "")
  {
         jQuery("#mx4").hide();
          }
  else if(mxi2_val == "0")
  {
         jQuery("#mx4").show();  
  }  else if(mxi2_val == "1")
  {
         jQuery("#mx4").hide();
  }
}
   function trimStr(str){
	   return str.replace(/(^\s*)|(\s*$)/g,"");
	   }
</script>

























































