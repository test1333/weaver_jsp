<script type="text/javascript">
	var dqczr="field11785";
      var  xgbmfzr="field11770";
   	jQuery(document).ready(function () {
   		checkCustomize = function(){
   			var dqczr_val=jQuery("#"+dqczr).val();
   			var  xgbmfzr_val=jQuery("#"+xgbmfzr).val();
   			var newfzr="";
   			var newczr="";
   			if(xgbmfzr_val != ''){
   				newfzr =  "," + xgbmfzr_val + ",";
   				newczr = "," + dqczr_val + ",";
	   		      if (newfzr.indexOf(newczr) >= 0) {
                
                    	} else {
                        		newfzr = xgbmfzr_val + "," + dqczr_val;
                   	}
   		     }else{
   		         newfzr = dqczr_val;
   		     }
   		     jQuery("#"+xgbmfzr).val(newfzr);
   		       return true;
      	}
   	 });	
</script>