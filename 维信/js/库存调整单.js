<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  jQuery(document).ready(function(){
      var price = "#field8988_"
      checkCustomize = function () {
		var result = "";
		var flag = "";
		var num=0;
        var indexnum0=jQuery("#indexnum0").val();
        var nodesnum0 = jQuery("#nodesnum0").val();
        for(var index =0;index <indexnum0;index++){
              if(jQuery(price+index).length>0){
				 num = num +1;
                 var price_val = jQuery(price+index).val();
                 if(price_val==""){
                    result=result+flag+num;
					flag=",";
                 }
              }
        } 
        if(result != ""){
			result="第"+result+"行料号无成本单价,是否继续提交？";
			if(confirm(result)){
            }else{
                return false;
            }

		}
         return true;
      }
  });
</script>







