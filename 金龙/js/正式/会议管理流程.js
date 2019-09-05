
<script type="text/javascript">
	var hydd = "#field6306";//会议地点
	var zdyhydd = "#field6302";//自定义会议地点
	var chry = "#field6331";//参会人员
	var zcr = "#field6307";//主持人
	var fyr_dt1 = "#field12656_"//明细1发言人
	jQuery(document).ready(function () {
		jQuery(hydd).bindPropertyChange(function (){
			var hydd_val = jQuery(hydd).val();
			if(hydd_val == ""){
				jQuery(zdyhydd).removeAttr("readonly");
			}else{
				jQuery(zdyhydd).val("");
				jQuery(zdyhydd).attr("readonly", "readonly");
			}       
       
		})
		var hydd_val = jQuery(hydd).val();
		if(hydd_val == ""){
			jQuery(zdyhydd).removeAttr("readonly");
		}else{
			jQuery(zdyhydd).val("");
			jQuery(zdyhydd).attr("readonly", "readonly");
		}  
		
		checkCustomize = function () {
			var chry_val = jQuery(chry).val();
			var zcr_val = jQuery(zcr).val();
			chry_val = ","+chry_val+",";
			var indexnum0 = jQuery("#indexnum0").val();
			for(var index=0; index<indexnum0;index++){
				if(jQuery(fyr_dt1+index).length>0){
					var fyr_dt1_val = jQuery(fyr_dt1+index).val();
					var fyr_dt1_val2 =jQuery(fyr_dt1+index).val();
					fyr_dt1_val = ","+fyr_dt1_val+",";
					if(chry_val.indexOf(fyr_dt1_val)<0){
						if(zcr_val != fyr_dt1_val2){
							window.top.Dialog.alert("会议议程的发言人必须是参会人员或主持人，请修改");         
							return false;
						}
					}
				}
			}
			return true;
		}
		
	})
</script>
