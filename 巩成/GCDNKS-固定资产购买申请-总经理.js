<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var ysdj = '#field12135';
	var yszj = '#field12136';
	var zjlxz_dt1 = '#field12134_';
	var bj_dt1 = '#field11929_';
	var zj_dt1 = '#field11937_';
	jQuery(document).ready(function () {
		jQuery(ysdj).attr("readonly", "readonly");
		jQuery(yszj).attr("readonly", "readonly");
		var indexnum0 = jQuery("#indexnum0").val();
		for(var index=0; index<indexnum0;index++){
			if(jQuery(zjlxz_dt1+index).length>0){
				bindcheck(index);
			}
			
		}
	})
	function bindcheck(index){
		var ysdj_val = jQuery(ysdj).val();
		var yszj_val = jQuery(yszj).val();
		jQuery(zjlxz_dt1+index).click(function(){
			if(jQuery(zjlxz_dt1+index).is(':checked') == true){
				var bj_dt1_val = jQuery(bj_dt1+index).val();
				var zj_dt1_val = jQuery(zj_dt1+index).val();
				jQuery(ysdj).val(bj_dt1_val);
				jQuery(yszj).val(zj_dt1_val);
			}else{
				if(checkisOtherSelect() == "0"){
					jQuery(ysdj).val(ysdj_val);
					jQuery(yszj).val(yszj_val);
					
				}
			}
		})
		
		
	}
	
	function checkisOtherSelect(){
		var indexnum0 = jQuery("#indexnum0").val();
		for(var index=0; index<indexnum0;index++){
			if(jQuery(zjlxz_dt1+index).length>0){
				if(jQuery(zjlxz_dt1+index).is(':checked') == true){
					return "1"
				}
			}
			
		}
		return "0";
		
	}
	
</script>
