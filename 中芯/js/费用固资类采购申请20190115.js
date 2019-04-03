<script type="text/javascript">
var num_main="#field7042";//主表加个字段记录当前的序号
var oaid_dt2="#field7043_";//明细序号字段
jQuery(document).ready(function(){
	    jQuery("button[name=addbutton1]").live("click", function () {
 	   var indexnum00 = jQuery("#indexnum1").val();
 	    var num_main_val = jQuery(num_main).val();
 	     if(num_main_val==""){
 	       num_main_val=1;	 
 	     }else{
 	     	 num_main_val=Number(num_main_val)+1;
 	    }
 	      var index00= indexnum00-1;
 	      jQuery(oaid_dt2+index00).val(num_main_val);
 	     jQuery(num_main).val(num_main_val);
 });	
	   	   
})
</script>













