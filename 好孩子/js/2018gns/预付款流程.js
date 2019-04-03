<!--script代码，如果需要引用js文件，请使用与HTML中相同的方式。-->
<script type="text/javascript" >
	var yfkxx="#field16405";//发票日期
	jQuery(document).ready(function(){	
		checkCustomize = function (){
			var yfkxx_val = jQuery(yfkxx).val();
			if(yfkxx_val != ""){
				var result = checkyfk(yfkxx_val);
				if(result=="0"){
					alert("该预付款不存在归档的入库单，请先走入库单");
					return false;
				}
			}
			return true;
		}
	
	})
	function  checkyfk(yfkxx){
		var result = "";
		jQuery.ajax({
				 type: "POST",
				 url: "/goodbaby/pz/checkyfk.jsp",
				 data: {'yfkxx':yfkxx},
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




