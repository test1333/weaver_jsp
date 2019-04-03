<script type="text/javascript">
var num_main="#field6636";//主表加个字段记录当前的序号
var oaid_dt1="#field6637_";//明细序号字段

jQuery(document).ready(function(){
 jQuery("button[name=addbutton0]").live("click", function () {
 	   var indexnum00 = jQuery("#indexnum0").val();
 	    var num_main_val = jQuery(num_main).val();
 	     if(num_main_val==""){
 	       num_main_val=1;	 
 	     }else{
 	     	 num_main_val=Number(num_main_val)+1;
 	    }
 	      var index00= indexnum00-1;
 	      jQuery(oaid_dt1+index00).val(num_main_val);
 	     jQuery(num_main).val(num_main_val);
 });
 checkCustomize = function () {
	 var indexnum0=jQuery("#indexnum0").val(); 
     for( var index=0;index<indexnum0;index++){
           if(jQuery(oaid_dt1+index).length>0){
			   var oaid_dt1_val = jQuery(oaid_dt1+index).val();
			   if(oaid_dt1_val == ""){
				    Dialog.alert("明细中行项目存在空值，请检查");
                  return false; 
			   }
		   }
	 }
	return true;
 }
})

</script>



