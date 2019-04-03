<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  var yhje = "#field11043_";   
  var cgje = "#field6910_";
var cgsl = "#field6907_";
var cgdj ="#field6911_";

  function yourFunction1(){

      for(var index =0;index <150;index ++){
          if(jQuery(cgje+index).length>0){
              bindchange(index );
          }else{
            index  = 151;
          }
      }
  }

  function bindchange(index){
         jQuery(cgsl+index).bindPropertyChange(function () {
            var cgsl_val= jQuery(cgsl+index).val();
           var cgdj_val= jQuery(cgdj+index).val();
            jQuery(yhje+index).val(Number(cgsl_val)*Number(cgdj_val));
       })
     
    }


  jQuery(document).ready(function() {
  setTimeout('yourFunction1()',2000); 
   checkCustomize = function() {
      for(var index =0;index <150;index ++){
          if(jQuery(cgje+index).length>0){
               var cgje_val_1= jQuery(cgje+index).val();
            var yhje_val_1 =jQuery(yhje+index).val();
            if(Number(yhje_val_1) > Number(cgje_val_1)){
               alert("优惠金额应该小于等于采购金额。")
                return false;
            }           

          }else{
            index  = 151;
          }
      }
     return true;

   }
  });
   

</script>



