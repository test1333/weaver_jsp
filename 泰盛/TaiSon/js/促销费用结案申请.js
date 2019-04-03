<script type="text/javascript">
           var fysqlcy = "#field8023";
var fysqlc = "#field8027";
var ygfy_dt="field7982_";
var bcbxfy_dt="field8016_";
var yjaje_dt="field8029_";

	jQuery(document).ready(function () {
              	var fysqlc_val = jQuery(fysqlc).val();
              	if(fysqlc_val !=''){
              			 jQuery(fysqlc+"_browserbtn").attr('disabled',true);
              	}	
		jQuery(fysqlc).bindPropertyChange(function (){ 
			var fysqlc_val = jQuery(fysqlc).val();
		
				 jQuery(fysqlc+"_browserbtn").attr('disabled',true);
				 jQuery(fysqlcy).val(fysqlc_val);
			
		
        	})
         checkCustomize = function () {
         	 var indexnum0=  jQuery("#indexnum0").val();
         	 	 for(index=0;index<indexnum0;index++){
		     	if(jQuery("#"+bcbxfy_dt+index).length>0){
		     		var ygfy_dt_val=jQuery("#"+ygfy_dt+index).val();
		     		var bcbxfy_dt_val=jQuery("#"+bcbxfy_dt+index).val();
		     		var yjaje_dt_val=jQuery("#"+yjaje_dt+index).val();
		     		if(bcbxfy_dt_val==''){
		     		continue;	
		     	      }
		     	      if(ygfy_dt_val==''){
		     	  	ygfy_dt_val=0;
		     	  	}
		     	  	if(yjaje_dt_val==''){
		     	  	yjaje_dt_val=0;
		     	  	}
		     	      if(Number(yjaje_dt_val)+Number(bcbxfy_dt_val)>Number(ygfy_dt_val)){
		     	         alert("明细中存在本次报销加上已结案金额大于预估费用的情况，请检查。");
		     	         return false;
		     	      }
		     		
		             }
		             return true;
		    }
         }
        
    });
</script>





