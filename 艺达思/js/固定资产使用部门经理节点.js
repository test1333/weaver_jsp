<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 var kmzh_dt1="field6445_";//科目组合-明细1
 var sfmap="#field6581";//是否匹配
 var sfmap2="#disfield6581";//是否匹配
 var sfmap_dt1="field6582_";//科目组合-明细1
 var shcsz="#field6600";//收货次数真
var shcs_dt1="field6601_";//收货次数-明细
var shsl_dt1 ="field6452_";//收货数量
  jQuery(document).ready(function () {
  	  	 	var indexnum1=  jQuery("#indexnum0").val();
  	    	var shcsz_val = jQuery(shcsz).val();
  	    		if(shcsz_val==""){
  	    	shcsz_val="1";	
  	        }else{
  	        	shcsz_val=Number(shcsz_val)+1;
  	        } 
  	    	for(var index = 0;index<indexnum1;index++){
  	    	 	 if(jQuery("#"+shsl_dt1+index).length>0){
  	    	 	 	 var shcs_dt1_val =jQuery("#"+shcs_dt1+index).val();
  	    	 	 	 var shsl_dt1_val =jQuery("#"+shsl_dt1+index+"span").html();
  	    	 	 	 if(shcs_dt1_val==shcsz_val){
  	    	 	 	 	 jQuery("#"+shsl_dt1+index+"span").attr({style:"color:blue !important"});
  	    	 	       }
  	    	 	 }
  	    	}
  	    checkCustomize = function(){
  	    	jQuery(sfmap).val("");
  	    	jQuery(sfmap2).val("");
  	    	var indexnum0=  jQuery("#indexnum0").val();
  	    	var kmzhall="";
  	    	var flag="0";
  	    	 for(var index = 0;index<indexnum0;index++){
  	    	 	 if(jQuery("#"+kmzh_dt1+index).length>0){
  	    	 	 	 var sfmap_dt1_val=jQuery("#"+sfmap_dt1+index).val()
  	    	 	 	 if(sfmap_dt1_val == '0'){
  	    	 	 	 	 flag="1";
  	    	 	 	 	 break;
  	    	 	        }
  	    	        }
  	    	 }
  	     	jQuery(sfmap).val(flag);
  	     	jQuery(sfmap2).val(flag);
  	     	return true;
  	    }
 })


</script>

