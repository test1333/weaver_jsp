 <!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var cf_dt1 = "#field13685_";//餐费
	var ccjt_dt1 = "#field13686_";//出差津贴
    jQuery(document).ready(function () {
		jQuery("button[name=addbutton0]").live("click", function () {
			 var indexnum0 = jQuery("#indexnum0").val();
			 binddt(indexnum0-1);
		});
		setTimeout('binddetail()',1000);
		

		
	});
	function binddetail(){
		 var indexnum1 = jQuery("#indexnum0").val();
		 for(var index = 0;index < indexnum1;index++){
            if(jQuery(cf_dt1+index).length>0){
               binddt(index);
                
            }
        }
		
	}
	function binddt(index){
		jQuery(cf_dt1+index).bind("change", function () {
			var cf_dt1_val = jQuery(cf_dt1+index).val();
			if(cf_dt1_val != ""){
				jQuery(ccjt_dt1+index).val("");				
			}
			calSum(0);
            
        });
		jQuery(ccjt_dt1+index).bind("change", function () {
			var ccjt_dt1_val = jQuery(ccjt_dt1+index).val();
			if(ccjt_dt1_val != ""){
				jQuery(cf_dt1+index).val("");				
			}
			calSum(0);
            
        });
		
	}
	
</script>
