<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var qjlx="#field6423";//请假类型
	var qtlx="field6371";//其他类型
    jQuery(document).ready(function(){
    	var qjlx_val=jQuery(qjlx).val();
    	if(qjlx_val == "13"){
    			addcheck(qtlx,'0');
	   	}  
    	jQuery(qjlx).bindPropertyChange(function () {
    		var qjlx_val=jQuery(qjlx).val();
    		if(qjlx_val == "13"){
    			addcheck(qtlx,'0');
	    	}else{
	    	    removecheck(qtlx,'0');
	    	}    
    	})
    })
     function addcheck(btid,flag){
  	  	var btid_val = jQuery("#"+btid).val();
  	  	var btid_check=btid;
  	      if(btid_val==''){
		    if(flag=='0'){ 
     	 	  jQuery("#"+btid+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }else{
     	 	 	 jQuery("#"+btid+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	 	 	  } 	  
     	 	 	 
     	}
     	var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+btid_check)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=btid_check;
                }
  }
  function removecheck(btid,flag){
      if(flag=='0'){ 
  	   jQuery("#"+btid+"span").html("");
     }else{
     	   jQuery("#"+btid+"spanimg").html("");
    }
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+btid,"");
                document.all('needcheck').value=parastr;
  }
</script>
