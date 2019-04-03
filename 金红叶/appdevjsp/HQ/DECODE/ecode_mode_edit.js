<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function() {
    var billid_def=jQuery("#billid").val();
	var formmodeid_def=jQuery("#formmodeid").val();
    $.ajax({
    async:"false",
        type: "POST",
        url: "/appdevjsp/HQ/DECODE/get-mode-field-info.jsp",
        data: {"formmodeid_def":formmodeid_def,"billid_def":billid_def},
        dataType: "Text",
        success: function(data){
            data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            //alert(data);
            var obj = eval("("+data+")");
            var status=obj["status"];
            var code=obj["code"];
            if(status=="success"){
                //alert("status:"+obj["status"]); 
                //alert("code:"+obj["code"]);
                $.each(code,function(i,value) {
                    //alert(code[i]);
                    //alert(i);
                    if(code[i]=="clob"){
                        var ue = UE.getEditor("field"+i);
						ue.ready(function() {
							var clob_val = ue.getContent();
							if(clob_val != ""){
								var tmp_val=getDecodeValue(clob_val,"1");
								ue.setContent(tmp_val);
							}
						});
                    }else{
                        var char_val = jQuery("#field"+i).val();
                        if(char_val != ""){
                            var tmp_val=getDecodeValue(char_val,"0");
                            jQuery("#field"+i).val(tmp_val.replace(/<br>/g,''));
                        }
                    }
                });
            }else{
                alert("Error:"+code);
            }
        }
    });
});
function dodata(){
	
	
}
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




















