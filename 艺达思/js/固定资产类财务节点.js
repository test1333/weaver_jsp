<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
 var kmzh_dt1="field6445_";//��Ŀ���-��ϸ1
 var sfmap="#field6581";//�Ƿ�ƥ��
 var sfmap2="#disfield6581";//�Ƿ�ƥ��
    var sfmap_dt1="field6582_";//��Ŀ���-��ϸ1
    var sfbh_dt1="#field6711_";//�Ƿ���-��ϸ1
    var djhs_dt1="#field6442_";//���ۺ�˰-��ϸ1
  jQuery(document).ready(function () {
  	  	    	var indexnum1=  jQuery("#indexnum0").val();
  	    	for(var index = 0;index<indexnum1;index++){
  	    	 	 if(jQuery("#"+sfmap_dt1+index).length>0){
  	    	 	 	 var sfmap_dt1_val =jQuery("#"+sfmap_dt1+index).val();
  	    	 	 	 var kmzh_dt1_val =jQuery("#"+kmzh_dt1+index+"span").html();
  	    	 	 	 if(sfmap_dt1_val=="0"){
  	    	 	 	 	 jQuery("#"+kmzh_dt1+index+"span").attr({style:"color:red  !important"});
  	    	 	       }
  	    	 	       var sfbh_dt1_val =jQuery(sfbh_dt1+index).val();
  	        		 if(sfbh_dt1_val=="1"){
  	        		   	 jQuery(djhs_dt1+index).attr({style:"color:red  !important"});
  	        		   	 jQuery(djhs_dt1+index+"span").attr({style:"color:red  !important"});  	 
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

