
jQuery(document).ready(function() {
    var requestid_def=jQuery("[name='requestid']").val();
    //主表解密
    $.ajax({
        async:false,
        type: "POST",
        url: "/appdevjsp/HQ/DECODE/get-field-info-mobile.jsp?requestid_def="+requestid_def,
        dataType: "text",
        success: function(data){
            data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            //alert(data);
            var obj = eval("("+data+")");
            var status=obj["status"];
            var code=obj["code"];
            if(status=="success"){
                $.each(code,function(i,value) {
                    if(code[i]=="clob"){
                        var clob_val = jQuery("#field"+i).val();
                            if(clob_val != ""){
                                var tmp_val=getDecodeValue(clob_val,"1");
                                jQuery("#field"+i+"_span").html(tmp_val);
                            }
                    }else{
                        var char_val = jQuery("#field"+i).val();
                        if(char_val != ""){
                            var tmp_val=getDecodeValue(char_val,"0");
                            jQuery("#field"+i+"_span").html(tmp_val);
                        }
                    }
                });
            }else{
                if(code != '2002'){
                alert("Error:"+code);
                }
            }
        }
    });

    //明细解密
        $.ajax({
        async:"false",
        type: "POST",
        url: "/appdevjsp/HQ/DECODE/get-field-info-dt.jsp?requestid_def="+requestid_def,
        dataType: "Text",
        success: function(data){
            data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            //alert(data);
            var obj = eval("("+data+")");
            var status=obj["status"];
            var code=obj["code"];
            if(status=="success"){
                $.each(code,function(i,value) {
                    var field_id = i;
                    var dt = code[i];
                    var nodenum = jQuery("#nodenum"+dt).val();
                    for(var index = 0;index < nodenum;index ++){
                        var field_val = jQuery("#isshow"+dt+"_"+index+"_"+field_id).text();
                        field_val=field_val.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        var dt_val=getDecodeValue(field_val,"0");
                        jQuery("#isshow"+dt+"_"+index+"_"+field_id).html(dt_val);
                    }               
                });
            }else{
                if(code != '2002'){
                    alert("Error_D:"+code);
                }
            }
        }
    }); 
});

function getDecodeValue(oldvalue,type){
    var value=encodeURIComponent(oldvalue);
    var name_val="";
    $.ajax({
             async:false,
             type: "POST",
             url: "/appdevjsp/HQ/DECODE/get-decode-value.jsp?oldvalue="+value+"&type="+type,
             dataType: "text",
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        name_val=data;
                      }
         });
     return name_val;
}























































































