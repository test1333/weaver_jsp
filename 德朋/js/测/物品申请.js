<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
var ysqj_dt1="#field6479_";
var sqlx_dt1="#field6497_";
var cdzt_dt1="#field6474_";
jQuery(document).ready(function(){
	checkCustomize = function(){ 
		var indexnum0 = jQuery("#indexnum0").val();
		var checkval1='';
		var cdzt_old='-1';
		var sqlx_old='-1';
		 for (var index0= 0; index0 < indexnum0; index0++) {   
		 	   if (jQuery(ysqj_dt1 + index0).length > 0) {
		 	   	    var cdzt_dt1_val = jQuery(cdzt_dt1 + index0).val();
		 	   	    var sqlx_dt1_val = jQuery(sqlx_dt1 + index0).val();
		 	   	     if(sqlx_old == '-1'){
		 	         sqlx_old=sqlx_dt1_val;
		 	         }else{
		 	           	 if(sqlx_old != sqlx_dt1_val){
		 	           	 	 alert("�����������Ͳ�һ�£����޸ġ�");
		 	           	 	 return false;
		 	              }
		 	        }
		 	   	   if(cdzt_old == '-1'){
		 	         cdzt_old=cdzt_dt1_val;
		 	         }else{
		 	           	 if(cdzt_old != cdzt_dt1_val){
		 	           	 	 alert("���ڳе����岻һ�£����޸ġ�");
		 	           	 	 return false;
		 	              }
		 	        }
		 	   
		 	   	   var ysqj_dt1_val = jQuery(ysqj_dt1 + index0).val();
		 	   	   if(ysqj_dt1_val ==''){
		 	   		continue;
		 	   		}
		 	   	 if(checkval1 ==''){
		 	  	    checkval1 = ysqj_dt1_val;
		 	  	  }else{
		 	  	   if(ysqj_dt1_val != checkval1){
		 	  	     alert("Ԥ���ڼ䲻һ�£���鿴");
		 	  	     return false;
		 	  	   }	  	  
		 	    	}
		 	   	   
		 	   	   
		 	   }
		 }
		 	
	     return true;
	         
	}	
});	


</script>

