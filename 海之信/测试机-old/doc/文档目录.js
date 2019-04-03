<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  var  sjml = "field13715_";
  var  mlmc = "field13710_"; 
  var checkflag="field13720_"; 
  jQuery(document).ready(function () {
  	  checkCustomize = function () {
  	  	   var indexnum = jQuery("#indexnum0").val();
  	  	   var mlall="";
  	  	    for (var index = 0; index < indexnum; index++) {
  	  	    	if(jQuery("#"+sjml + index).length > 0){
  	  	    		 var sjml_val = jQuery("#"+sjml + index).val();
  	  	    	 	var mlmc_val = jQuery("#"+mlmc + index).val();
  	  	    	 	var checkflag_val = jQuery("#"+checkflag + index).val();
  	  	    	 
  	  	    	 	if(mlmc_val != ''){
  	  	    	        	var iscopy= checkname(sjml_val,mlmc_val,index);
             		   	if(iscopy =="1"){
             		   	alert("明细表中存在重复数据，请调整后再提交");
  	  	    	        	return false;
             		     }
  	  	    	      }
  	  	    	      if(checkflag_val == "1"){
  	  	    	      alert(mlmc_val+"目录在对应的上级目录下已经存在，请调整");
  	  	    	        	return false;
  	  	    	     }
  	  	    	      
  	  	    	}
  	          }
  	          return true;
         }
  	  
  });
  function checkname(sjml_val,mlmc_val,index){
       var indexnum1 = jQuery("#indexnum0").val();
       for (var index1 = 0; index1 < indexnum1; index1++) {
       	   if(index1 == index){
                 continue;
                }
                var sjml_val1 = jQuery("#"+sjml + index1).val();
  	  	   var mlmc_val1 = jQuery("#"+mlmc + index1).val();
  	  	   if(sjml_val1 == sjml_val && mlmc_val1 == mlmc_val){
  	  	     return "1";
  	  	  }
     }
     return "0";
  }
  

</script>
