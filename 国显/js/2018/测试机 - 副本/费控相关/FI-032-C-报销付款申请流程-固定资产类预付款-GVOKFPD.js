<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
   var sfhtkz = "#field52730";  //是否合同控制
   var bcfue = "#field52846";
   var htwfe = "#field52844";
   var bcfkecny = "#field52847";
   var bcyfke_dt1 = "#field49663_";//本次预付款额
   jQuery(document).ready(function(){
        checkCustomize = function () {
          var bcfue_val = jQuery(bcfue).val();
          var htwfe_val = jQuery(htwfe).val();
		  if(bcfue_val == ""){
			bcfue_val = "0";  		  
		  }
		  
		  if(htwfe_val == ""){
			htwfe_val = "0";  		  
		  }
           if(jQuery(sfhtkz).val()=="0"){
              if(Number(bcfue_val)>Number(htwfe_val)){
                  window.top.Dialog.alert("提交失败：本次付款金额超出合同未付金额！")
                  return false;
               }
           }
		   
		  var indexnum0 = jQuery('#indexnum0').val();
		  for(var index =0;index <indexnum0;index++){
			 if(jQuery(bcyfke_dt1+index).length>0){ 
				var bcfkecny_val =jQuery(bcfkecny).val();
				jQuery(bcyfke_dt1+index).val(bcfkecny_val);
			 }
			  
			  
		  }
          return true;
        }
   })
</script>













