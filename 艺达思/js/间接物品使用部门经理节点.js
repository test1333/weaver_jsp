<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
 var kmzh_dt1="field6479_";//��Ŀ���-��ϸ1
 var sfmap="#field6583";//�Ƿ�ƥ��
 var sfmap2="#disfield6583";//�Ƿ�ƥ��
    var sfmap_dt1="field6584_";//��ϸ1
     var shcsz="#field6611";//�ջ�������
    var shcs_dt1="field6613_";//�ջ�����-��ϸ
        var shsl_dt1 ="field6486_";//�ջ�����
     var bdlx="#field6487";//������
  var wpdl="field6695_";//��Ʒ������ϸ1
  var dlms="field6471_";//����������ϸ1
  var lh="field6467_";//�Ϻ���ϸ1
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
       	    		 removecheck(lh+index,"1");
       	    	}else if(bdlx_val == "1"){
       	    		jQuery("#"+dlms+index).removeAttr("readonly");
       	    	   addcheck(lh+index,"1");
       	    	   removecheck(wpdl+index,"1");
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

