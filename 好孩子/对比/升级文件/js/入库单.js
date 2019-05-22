<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cgdl = "#field14817";
jQuery(document).ready(function(){
	
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















