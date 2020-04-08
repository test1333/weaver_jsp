 <!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var cf_dt1 = "#field13251_";//餐费
	var ccjt_dt1 = "#field13252_";//出差津贴
	
    jQuery(document).ready(function () {
		jQuery("button[name=addbutton0]").live("click", function () {
			 var indexnum0 = jQuery("#indexnum0").val();
			 binddt(indexnum0-1);
		});
		setTimeout('binddetail()',1000);
		 checkCustomize = function () {
			var indexnum0=jQuery("#indexnum0").val(); 
			for( var index=0;index<indexnum0;index++){
				if( jQuery(cf_dt1+index).length>0){
					var cf_dt1_val = jQuery(cf_dt1+index).val();
					var ccjt_dt1_val = jQuery(ccjt_dt1+index).val();
					
					if(cf_dt1_val != ""&& ccjt_dt1_val != ""){
						Dialog.alert("明细中同一行明细餐费和出差津贴不能同时填写，请检查");
						return false; 
					}
				}
			} 
			 
			return true; 
		 }
		

		
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







	var hj = "#field13243";//合计
	var jg = "#field13269";//结果
	var jgycdis = "#disfield13267";//结果
	var jgyc = "#field13267";//结果隐藏

    jQuery(document).ready(function () {
		//alert(111);
		khjg();
		jQuery(hj).bind("change",function(){
			khjg();
		})
	
    })
	function khjg(){
		var hj_v = jQuery(hj).val();
		//alert('hj_v='+hj_v);
		if(hj_v<0){
			//alert(0);
			jQuery(jgycdis).val("0");
			jQuery(jg).val("0");
			jQuery(jgyc).val("0");
		}else if(hj_v>0){
			jQuery(jgycdis).val("1");
			jQuery(jg).val("1");
			jQuery(jgyc).val("1");
		}else{
			jQuery(jgycdis).val("2");
			jQuery(jg).val("2");
			jQuery(jgyc).val("2");
		}
	}





</script>
















