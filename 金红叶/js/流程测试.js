<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var msdh="#field18266";
var dh="#field12401";
jQuery(document).ready(function(){
	var msdh_val = jQuery(msdh).val();
	if(msdh_val != ""){
		var jmmsdh_val=getDecodeValue(msdh_val,"1");
		//jQuery(msdh).val(name_val);
		jQuery("#FCKiframe18266").contents().find("div").html(jmmsdh_val);
	}
	var dh_val = jQuery(dh).val();
	if(dh_val != ""){
		var jmdh_val=getDecodeValue(dh_val,"0");
		jQuery(dh+"span").text(jmdh_val);
	}		
	
})


function getDecodeValue(oldvalue,type){
	var value=encodeURIComponent(oldvalue);
	var name_val="";
	$.ajax({
             type: "POST",
             url: "/appdevjsp/HQ/DECODE/get-decode-value.jsp",
             data: {'oldvalue':oldvalue, 'type':type},
             dataType: "text",
			 async:false,//同步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						name_val=data;
                      }
         });
     return name_val;
}
    
</script>
