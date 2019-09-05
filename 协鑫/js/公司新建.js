<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var tzbl_dt1 = "#field870605_";

jQuery(document).ready(function(){
	checkCustomize = function(){ 
		
		var indexnum1 = jQuery("#indexnum0").val();
		var sumbl = "0";
		for (var index= 0; index < indexnum1; index++) {   
		    if (jQuery(tzbl_dt1 + index).length > 0) {
		 	   	   var tzbl_dt1_val = jQuery(tzbl_dt1 + index).val();
				   if(tzbl_dt1_val == ""){
					  tzbl_dt1_val = "0";   
				   }
				   sumbl = accAdd(tzbl_dt1_val,sumbl);
			 	    
		 	}
		}
		if(Number(sumbl)>Number("100")){
			alert("投资比例合计不能超过100%，请检查");
			return false;
		}
		return true;
		 
	}	
});	
function accAdd(arg1,arg2){
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2))
    return (arg1*m+arg2*m)/m
}


</script>

