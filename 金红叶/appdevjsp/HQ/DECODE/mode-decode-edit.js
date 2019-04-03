jQuery(document).ready(function() {
    setTimeout('do_data_main()',100);
    setTimeout('do_data_dt()',100);
})

//主表解密
function do_data_main(){
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
                $.each(code,function(i,value) {
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
                            jQuery("#field"+i).val(tmp_val.replace(/<br\>/g,"\n"));
                        }
                    }
                });
            }else{
                alert("Error:"+code);
            }
        }
    });
}

//明细解密
function do_data_dt(){
    var billid_def=jQuery("#billid").val();
    var formmodeid_def=jQuery("#formmodeid").val();
    $.ajax({
    async:"false",
        type: "POST",
        url: "/appdevjsp/HQ/DECODE/get-mode-field-info-dt.jsp",
        data: {"formmodeid_def":formmodeid_def},
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
                    var indexnum = jQuery("#indexnum"+dt).val();
                    for(var index = 0;index < indexnum;index ++){
                        var field_val = jQuery("#field"+field_id+"_"+index).val();
                        if(field_val != ""){
                            var dt_val=getDecodeValue(field_val,"0");
                            if(jQuery("#field"+field_id+"_"+index).attr("style") == "display: none;" || jQuery("#field"+field_id+"_"+index).attr("style") == undefined || jQuery("#field"+field_id+"_"+index).attr("style") == "display:none"){
                                jQuery("#field"+field_id+"_"+index+"span").html(dt_val);
                            }else{
                                jQuery("#field"+field_id+"_"+index).val(dt_val.replace(/<br\>/g,"\n"));
                            }
                        }
                     }               
                });
            }else{
                if(code != '2002'){
                    alert("Error_D:"+code);
                }
            }
        }
    });
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

