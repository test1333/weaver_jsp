<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
 var kmzh_dt1="field6404_";//��Ŀ���-��ϸ1
 var sfmap="#field6579";//�Ƿ�ƥ��
 var sfmap2="#disfield6579";//�Ƿ�ƥ��
 var sfmap_dt1="field6580_";//��Ŀ���-��ϸ1
var shcsz="#field6597";//�ջ�������
  var shcs_dt1="field6598_";//�ջ�����-��ϸ
var shsl_dt1 ="field6417_";//�ջ�����
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

