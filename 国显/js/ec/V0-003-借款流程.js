<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var grjkje="#field9987";//个人借款金额
	var sqje="#field5974";//申请金额
	var jked="#field11492";//借款额度
     var disjked="#disfield11492";//借款额度
     jQuery(document).ready(function(){
        checkCustomize = function(){
     	 var grjkje_val=jQuery(grjkje).val();
     	 var sqje_val=jQuery(sqje).val();
     	 if(Number(sqje_val)>Number(grjkje_val)){
     	    jQuery(jked).val("1");
     	    jQuery(disjked).val("1");
     	 }else{
     	  jQuery(jked).val("0");
     	  jQuery(disjked).val("0");
            }		
     	 return true;		
        }
     	 
   });
</script>
