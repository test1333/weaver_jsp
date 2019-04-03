<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var gj = "#field25116";
    var sj  = "#field25117";
    var gdsj = "#field25118";
    var type= "#field26300_";
    var jsl = "#field25127_";
     jQuery(document).ready(function () {
            checkCustomize = function () {   
              var indexnum0 = jQuery("#indexnum0").val();
              var gj_val = jQuery(gj).val();
              var sj_val = jQuery(sj).val();
              var gdsj_val =  jQuery(gdsj).val(); 
              var tmp = 0;
              var tmp2 = 0;  
              var tmp3 = 0;          
               for(var i=0;i<indexnum0;i++){
                    var type_val =jQuery(type+i).val(); 
                    var jsl_val = jQuery(jsl+i).val(); 
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
               
               if(Number(tmp)>Number(gj_val)*1.01){
                     window.top.Dialog.alert("干浆超出总量,请修改!");
                     return false;
               }
               if(Number(tmp2)>Number(sj_val)*1.01){
                     window.top.Dialog.alert("湿浆超出总量,请修改!");
                     return false;
               }
               if(Number(tmp3)>Number(gdsj_val)*1.01){
                     window.top.Dialog.alert("管道湿浆超出总量,请修改!");
                     return false;
               }             
 
               return true;
            }
     })
</script>
















