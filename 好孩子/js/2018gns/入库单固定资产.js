<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src = "/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
var cgdl = "#field16241";
jQuery(document).ready(function(){
	var dj = "#field14075_";
	var shsl = "#field14069_";
	var je = "#field13911_";	
	var indexnums = jQuery("#indexnum0").val();
	for(var i=0;i<indexnums;i++){
		if(jQuery(dj+i).length>0){
			var dj_val = jQuery(dj+i).val();			
			var shsl_val = jQuery(shsl+i).val();
			var jesum = Math.round(Number(dj_val)*Number(shsl_val)*100)/100;
			//alert(jesum);
			jQuery(je+i).val(jesum);
			jQuery(je+i+"span").text(jesum);
		}
	}	
	checkCustomize = function (){
		var cgdl_val = jQuery(cgdl).val();
		if(cgdl_val == "3"){
			var rqid_val=document.getElementsByName("requestid")[0].value;  
			var result = checkhtrkd(rqid_val);
			if(result=="1"){
				alert("该流程为投资验收流程，需将验收前的入库流程入库后，再提交");
				return false;
			}
		}
		return true;
	}
})
function  checkhtrkd(rqid){
	var result = "";
   jQuery.ajax({
             type: "POST",
             url: "/goodbaby/pz/checktzrktj.jsp",
             data: {'rqid':rqid},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        result=data;
                      }
         });
	
	return result;
	
}
</script>














