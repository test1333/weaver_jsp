   var px1 = "#field13864";
        var px2 = "#field13865";
        var px3 = "#field13866";
        var px11="#field13867";
        var px22="#field13868";
        var px33="#field13869";

var dm= "#field12659";
var zh= "#field12660";
var hy= "#field12661";
function getJCName(){
	var dm_val=jQuery(dm).val();
	var zh_val=jQuery(zh).val();
	var hy_val=jQuery(hy).val();
	var px1_val=jQuery(px1).val();
	var px2_val=jQuery(px2).val();
	var px3_val=jQuery(px3).val();
	var result='';	
	if(px1_val == '' || px2_val=='' || px3_val== '')	{
         result = dm_val+zh_val+hy_val;
    }else if(px1_val==px2_val || px1_val==px3_val || px2_val==px3_val){
        result = dm_val+zh_val+hy_val;
    }else{
    	if(px1_val=='0'){
    		if(px2_val=='1'){
    			  result = dm_val+zh_val+hy_val;
    		}else{
    	      	result = dm_val+hy_val+zh_val;
    	      }
      }else if(px1_val=='1'){
      	  if(px2_val=='0'){
    			  result = zh_val+dm_val+hy_val;
    		}else{
    	      	result = hy_val+dm_val+zh_val;
    	      }
      }else{
      	  if(px2_val=='0'){
    			  result = zh_val+hy_val+dm_val;
    		}else{
    	      	result = hy_val+zh_val+dm_val;
    	      }
  	}
    }
    alert(result);
}