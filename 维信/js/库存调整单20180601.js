<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  jQuery(document).ready(function(){
      var price = "#field8988_"
      checkCustomize = function () {
        var indexnum0=jQuery("#indexnum0").val();
        var nodesnum0 = jQuery("#nodesnum0").val();
        for(var index =0;index <indexnum0;index++){
              if(jQuery(price+index).length>0){
                 var price_val = jQuery(price+index).val();
                 if(price_val==""){
                    var num = Number(index)+1-(Number(indexnum0)-Number(nodesnum0));
                    window.top.Dialog.alert("第"+num+"行料号无成本单价,请确认!");
                    return false;
                 }
              }
        } 
         
         return true;
      }
  });
</script>







