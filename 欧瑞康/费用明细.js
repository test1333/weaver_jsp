<script type="text/javascript">
 var zdfysqd="#field7947";
 var zdf = "#field6228_";
 jQuery(document).ready(function () {
    checkCustomize = function(){
         var indexnum0= jQuery("#indexnum0").val();
         var zdfysqd_val = jQuery(zdfysqd).val();
         for(var index=0;index<indexnum0;index++){
             if(jQuery(zdf+index).length>0){
                 var zdf_val = jQuery(zdf+index).val();
                 if(zdf_val !='' && zdfysqd_val==''){
                     alert("请填写招待费用申请单。");
                     return false;
                 }
             }
         }
         return true;
    }
 });

</script>