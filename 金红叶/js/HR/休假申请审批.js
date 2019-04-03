<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var qjlxdm_dt1="#field20041_";//请假类型代码
var sfyjt_dt1="field21133_";//请假类型代码
jQuery(document).ready(function(){
	 var indexnum0 = jQuery("#indexnum0").val();
	 for(var index=0;index<indexnum0;index++){
 	 	if (jQuery(qjlxdm_dt1 + index).length > 0) {
			var qjlxdm_dt1_val=jQuery(qjlxdm_dt1 + index).val();
			if(qjlxdm_dt1_val=='1130'||qjlxdm_dt1_val=='1140'){
				addcheck(sfyjt_dt1,index);
			}
		}
	 }
	
	
})
function addcheck(fieldid,index){
	var fieldid_val = jQuery("#"+fieldid+index).val();
	var checkid=fieldid+index;
	if(fieldid_val==''){
     	jQuery("#"+fieldid+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
    }
     	 
    var needcheck = document.all("needcheck");
    if(needcheck.value.indexOf(","+checkid)<0){
        if(needcheck.value!='') needcheck.value+=",";
        needcheck.value+=checkid;
       
    }
     
}
</script>
