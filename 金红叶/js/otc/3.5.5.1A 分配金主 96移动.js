<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var gj = "#field21228";
    var sj  = "#field21229";
    var gdsj = "#field21230";
    var type= "#field23540_";
    var jsl = "#field21232_";
	var jslrc = "#field24834";//浆数量容差
     jQuery(document).ready(function () {
            checkCustomize = function () {   
              var indexnum0 = jQuery("#nodenum0").val();
              var gj_val = jQuery(gj).val();
              var sj_val = jQuery(sj).val();
              var gdsj_val =  jQuery(gdsj).val(); 
			  var jslrc_val = jQuery(jslrc).val();
			  if(jslrc_val == ""){
				  jslrc_val = "1";
				  
			  }
              var tmp = 0;
              var tmp2 = 0;  
              var tmp3 = 0;          
               for(var i=0;i<indexnum0;i++){
				if(jQuery(type+i).length>0){
                    var type_val =jQuery(type+i).val(); 
                    var jsl_val = jQuery(jsl+i).val(); 
					if(jsl_val == ""){
						jsl_val = "0";
					}
                    if(type_val=="0"){
                         tmp = Number(tmp)+Number(jsl_val);
                    }
                    if(type_val=="1"){
                         tmp2 = Number(tmp2)+Number(jsl_val);
                    }
                    if(type_val=="2"){
                         tmp3 = Number(tmp3)+Number(jsl_val);
                    }
				}
               }
               if(Number(tmp)>(Number(gj_val)*(Number(jslrc_val)+1))){
				     jQuery.alert("干浆超出总量,请修改!", promptWrod);
                    // window.top.Dialog.alert("干浆超出总量,请修改!");
                     return false;
               }
               if(Number(tmp2)>(Number(sj_val)*(Number(jslrc_val)+1))){
				   jQuery.alert("湿浆超出总量,请修改!", promptWrod);
                     //window.top.Dialog.alert("湿浆超出总量,请修改!");
                     return false;
               }
               if(Number(tmp3)>(Number(gdsj_val)*(Number(jslrc_val)+1))){
				    jQuery.alert("管道湿浆超出总量,请修改!", promptWrod);
                     //window.top.Dialog.alert("管道湿浆超出总量,请修改!");
                     return false;
               }             
 
               return true;
            }
     })
</script>

















