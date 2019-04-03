<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 var kmzh_dt1="field6479_";//科目组合-明细1
 var sfmap="#field6583";//是否匹配
 var sfmap2="#disfield6583";//是否匹配
    var sfmap_dt1="field6584_";//明细1
  var bdlx="#field6487";//表单类型
  var wpdl="field6695_";//物品大类明细1
  var dlms="field6471_";//大类描述明细1
  var lh="field6467_";//料号明细1
  var jghs="field6731_";//价格含税明细1
  var djyc="field6696_";//单价隐藏
    
   var je="#field6714";//金额
 var jebh="#field6715";//金额变化
 var blbh="#field6716";//比例变化
 var sfth="#field6725";//是否退回
 var xgqje_dt1="#field6718_";//修改前金额-明细1
 var jec1_dt1="#field6720_";//金额差1-明细1
 var jec2_dt1="#field6721_";//金额差2-明细1
 var blc1_dt1="#field6726_";//比例差1-明细1
 var blc2_dt1="#field6727_";//比例差2-明细1
 var sfbh_dt1="#field6722_";//是否标红-明细1
 var cgdjhs="field6476_";//采购单价含税明细1
  jQuery(document).ready(function () {
  	   dodetail();
  	   jQuery(bdlx).bind("change",function () {
         	dodetail();
          });
     	jQuery("#indexnum0").bindPropertyChange(function () {
		
		dodetail();
	});
	 jQuery("button[name=addbutton0]").live("click", function () {
	  	   		dodetail();
	 });
  	    checkCustomize = function(){
  	    	jQuery(sfmap).val("");
  	    	jQuery(sfmap2).val("");
  	    	var indexnum0=  jQuery("#indexnum0").val();
  	    	var kmzhall="";
  	    	var flag="0";
  	    	 for(var index = 0;index<indexnum0;index++){
  	    	 	 if(jQuery("#"+kmzh_dt1+index).length>0){
  	    	 	 	 var sfmap_dt1_val=jQuery("#"+sfmap_dt1+index).val();
  	    	 	 	 if(sfmap_dt1_val == '0'){
  	    	 	 	 	 flag="1";
  	    	 	 	 	 break;
  	    	 	        }
  	    	        }
  	    	 }
  	     	jQuery(sfmap).val(flag);
  	     	jQuery(sfmap2).val(flag);
  	     	  jQuery(sfth).val(""); 
  	     	 var bdlx_val =jQuery(bdlx).val();
  	     	 if(bdlx_val=="0"){
  	   	var je_val=jQuery(je).val();
  	   	var jebh_val=jQuery(jebh).val();
  	   	var blbh_val=jQuery(blbh).val();
  	       var indexnum00=  jQuery("#indexnum0").val();
  	       for(var index = 0;index<indexnum00;index++){
  	    	   if(jQuery(xgqje_dt1+index).length>0){
  	    	   	   jQuery(sfbh_dt1+index).val("");
  	    	   	   var xgqje_dt1_val=checknumdate(jQuery(xgqje_dt1+index).val());
  	    	   	   var jec1_dt1_val=checknumdate(jQuery(jec1_dt1+index).val());
  	    	   	   var jec2_dt1_val=checknumdate(jQuery(jec2_dt1+index).val());
  	    	   	   var blc1_dt1_val=checknumdate(jQuery(blc1_dt1+index).val());
  	    	   	   var blc2_dt1_val=checknumdate(jQuery(blc2_dt1+index).val());
  	    	   	   if(Number(xgqje_dt1_val)<Number(je_val)){
  	    	   	   	   if(Number(jec1_dt1_val)>=0){
  	    	   	   	   	  if(Number(jec1_dt1_val)>=Number(jebh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }
  	    	   	          }else{
  	    	   	             if(Number(jec2_dt1_val)>=Number(jebh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }	  
  	    	   	          }
  	    	   	   	   
  	    	          }else{
  	    	          	   if(Number(blc1_dt1_val)>=0){
  	    	   	   	   	  if(Number(blc1_dt1_val)>=Number(blbh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }
  	    	   	          }else{
  	    	   	             if(Number(blc2_dt1_val)>=Number(blbh_val)){
  	    	   	   	   	  	  jQuery(sfbh_dt1+index).val("1");
  	    	   	   	   	  	   jQuery(sfth).val("0");
  	    	   	   	         }	  
  	    	   	          }
  	    	         }
  	    	   }
  	    	}   
       	}
  	     	return true;
  	    }
 })
 function checknumdate(dataval){
  if(dataval == ''){
   	 dataval = "0"; 
  } 	 
  return dataval;
}
 function dodetail(){
 	 var bdlx_val =jQuery(bdlx).val();
 	 if(bdlx_val == ''){
 	 	  jQuery("button[name=addbutton0]").css('display','none');
        }else{
        	 jQuery("button[name=addbutton0]").css('display','');
        }
       	if(bdlx_val == "0"){
        	 $(".lhyc").hide();
        	 $(".wpdlyc").show();
        	}else if(bdlx_val == "1"){
              $(".wpdlyc").hide();
              $(".lhyc").show();
              }
       var indexnum0= jQuery("#indexnum0").val();
       for(var index=0;index <indexnum0;index++){
       	if( jQuery("#"+dlms+index).length>0){
       	    	if(bdlx_val == "0"){
       	    		addcheck(wpdl+index,"1");
       	    		 jQuery("#"+dlms+index).attr("readonly", "readonly");
       	    		 	jQuery("#"+jghs+index).removeAttr("readonly");
       	    		 removecheck(lh+index,"1");
       	    		 
       	    	}else if(bdlx_val == "1"){
       	    		jQuery("#"+dlms+index).removeAttr("readonly");
       	    		 jQuery("#"+jghs+index).attr("readonly", "readonly");
       	    		 jQuery("#"+cgdjhs+index).attr("readonly", "readonly");
       	    	   addcheck(lh+index,"1");
       	    	   removecheck(wpdl+index,"1");
       	      }
       	     bindchange(index);	  
    		}
       }

}

function bindchange(index){
  	jQuery("#"+djyc+index).bindPropertyChange(function () {
		var djyc_val=jQuery("#"+djyc+index).val();
		var bdlx_val =jQuery(bdlx).val();
	       if(bdlx_val=="1"){
		    jQuery("#"+jghs+index).val(djyc_val);
		    if(djyc_val !=""){
		     jQuery("#"+jghs+index+"span").html("");
		    }else{
		    	 jQuery("#"+jghs+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		    }	
	        }else{
	           jQuery("#"+jghs+index).val(""); 
	            jQuery("#"+jghs+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");	
	       }
	});
}	
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
