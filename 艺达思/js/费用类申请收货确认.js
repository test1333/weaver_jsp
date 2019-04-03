<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 var kmzh_dt1="field6404_";//科目组合-明细1
 var sfmap="#field6579";//是否匹配
 var sfmap2="#disfield6579";//是否匹配
    var sfmap_dt1="field6580_";//
    var shsl_dt1 ="field6417_";//收货数量
    var ddsl_dt1 ="field6396_";//订单数量
    var pozt_dt1="field6603_";//po状态
    var shcs="#field6596";//收货次数
    var shcsz="#field6597";//收货次数真
    var shcs_dt1="field6598_";//收货次数-明细
    var sfqbgb="#field6602";//是否全部关闭
    var sfqbgb2="#disfield6602";//是否全部关闭
  jQuery(document).ready(function () {
  	  //alert("11");
            dodetail();
            dodetail2();
           jQuery("#indexnum0").bindPropertyChange(function () {
           dodetail()
           }) 	  
  	    checkCustomize = function(){
  	    	jQuery(sfmap).val("");
  	    	jQuery(sfmap2).val("");
  	    	var indexnum0=  jQuery("#indexnum0").val();
  	    	var kmzhall="";
  	    	var flag="0";
  	    	var falg1="1";
  	    	var shcs_val=  jQuery(shcs).val();
  	    	var shcsz_val=  jQuery(shcsz).val();
  	    	shcs_val=shcsz_val;
  	    	if(shcs_val==""){
  	    	shcs_val="1";	
  	        }else{
  	        	shcs_val=Number(shcs_val)+1;
  	        } 
  	       // alert(shcs_val);
  	    	 for(var index = 0;index<indexnum0;index++){
  	    	 	 if(jQuery("#"+kmzh_dt1+index).length>0){
  	    	 	 	 var sfmap_dt1_val=jQuery("#"+sfmap_dt1+index).val()
  	    	 	 	 if(sfmap_dt1_val == '0'){
  	    	 	 	 	 flag="1";
  	    	 	        }
  	    	 	        
  	    	 	       var shsl_dt1_val=jQuery("#"+shsl_dt1+index).val();
  	    	 	         var shcs_dt1_val=jQuery("#"+shcs_dt1 + index).val();
  	    	 	         if(shsl_dt1_val != "" && shcs_dt1_val == ""){
  	    	 	         //	  alert("aa");
  	    	 	         	 	jQuery("#"+pozt_dt1+index).val("已关闭");
  	     	                    	jQuery("#"+shcs_dt1 + index).val(shcs_val);
  	    	 	}
  	    	 	 if(	jQuery("#"+pozt_dt1+index).val()=="未关闭"){
  	    	 	 falg1="0";	 
  	    	        }
  	    	        }
  	    	 }
  	    	 jQuery(shcs).val(shcs_val);
  	     	jQuery(sfmap).val(flag);
  	     	jQuery(sfmap2).val(flag);
  	     	jQuery(sfqbgb).val(falg1);
  	     	jQuery(sfqbgb2).val(falg1);
  	     	return true;
  	    }
 })
 function dodetail(){
 	 var indexnum0 =jQuery("#indexnum0").val();
   	      for( var index=0;index<indexnum0;index++){
   	       	//jQuery("#"+pozt_dt1+index).val("1");
  	     	     //	jQuery("#"+pozt_dt12+index).val("1");
  	     	     if(jQuery("#"+shsl_dt1 + index).length > 0){
  	     	     	 bindchange(index);
  	     	     	  jQuery("#"+pozt_dt1+index).attr("readonly", "readonly");	 
  	     	     }
   	    }
}
function bindchange(index){
	  jQuery("#"+shsl_dt1 + index).bind("change",function () {
             var shsl_dt1_val=jQuery("#"+shsl_dt1 + index).val();
             var ddsl_dt1_val=jQuery("#"+ddsl_dt1 + index).val();
             if(Number(shsl_dt1_val) <Number(ddsl_dt1_val)){
             	 alert("您填写的收货数量不等于订单数量，请确认！");
             }
              if(Number(shsl_dt1_val) >Number(ddsl_dt1_val)){
             	 alert("您填写的收货数量不能大于订单数量！");
             	  jQuery("#"+shsl_dt1 + index).val("");
             }
           }) 
}
function dodetail2(){
	var shcsz_val=  jQuery(shcsz).val();
		 var indexnum0 =jQuery("#indexnum0").val();
	 for(var index = 0;index<indexnum0;index++){
  	    	 	 if(jQuery("#"+kmzh_dt1+index).length>0){
  	    	 	   jQuery("#"+pozt_dt1+index).attr("readonly", "readonly");	 
  	    	 	    var shcs_dt1_val=jQuery("#"+shcs_dt1 + index).val();
  	    	 	    //alert(shcs_dt1_val+"aa");
  	    	 	    if(shcsz_val == ""){
  	    	 	    	jQuery("#"+pozt_dt1+index).val("未关闭");
  	     	                    	jQuery("#"+shcs_dt1 + index).val("");
  	    	 	    }else if(shcs_dt1_val !=""){
  	    	 	    	if(Number(shcs_dt1_val)>Number(shcsz_val)){
  	    	 	     	jQuery("#"+pozt_dt1+index).val("未关闭");
  	     	                    	jQuery("#"+shcs_dt1 + index).val("");
  	     	              }else{
  	     	              	   jQuery("#"+shsl_dt1+index).attr("readonly", "readonly");
  	     	            }
  	    	 	  }
  	    	        if(shcs_dt1_val == ""){
  	    	        	jQuery("#"+pozt_dt1+index).val("未关闭");
  	    	        }  
  	    	 }
  	    	 
  	  }	
}
</script>

