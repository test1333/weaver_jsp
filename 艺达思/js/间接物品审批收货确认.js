<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 var kmzh_dt1="field6479_";//科目组合-明细1
 var sfmap="#field6583";//是否匹配
 var sfmap2="#disfield6583";//是否匹配
    var sfmap_dt1="field6584_";//是否匹配-明细
    var shsl_dt1 ="field6486_";//收货数量
    var ddsl_dt1 ="field6472_";//订单数量
    var pozt_dt1="field6606_";//po状态
    var shcs="#field6610";//收货次数
    var shcsz="#field6611";//收货次数真
    var shcs_dt1="field6613_";//收货次数-明细
    var sfqbgb="#field6612";//是否全部关闭
    var sfqbgb2="#disfield6612";//是否全部关闭
      var bdlx="#field6487";//表单类型
  var wpdl="field6695_";//物品大类明细1
  var dlms="field6471_";//大类描述明细1
  var lh="field6467_";//料号明细1
  jQuery(document).ready(function () {
  	  //alert("11");
            dodetail();
            dodetail2();
           jQuery("#indexnum0").bindPropertyChange(function () {
           dodetail()
           }) 	  
          jQuery(bdlx).bind("change",function () {
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
       for(var index=0;index <indexnum0;index++){
       	if( jQuery("#"+dlms+index).length>0){
       	    	if(bdlx_val == "0"){
       	    		addcheck(wpdl+index,"1");
       	    		 jQuery("#"+dlms+index).attr("readonly", "readonly");
       	    		 removecheck(lh+index,"1");
       	    	}else if(bdlx_val == "1"){
       	    		jQuery("#"+dlms+index).removeAttr("readonly");
       	    	   addcheck(lh+index,"1");
       	    	   removecheck(wpdl+index,"1");
       	      }
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

