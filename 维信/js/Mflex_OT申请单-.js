<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var jbksrq_dt1="#field7426_";//加班开始日期
	var jbkssj_dt1="#field7427_";//加班开始时间
	var jbjsrq_dt1="#field7454_";//加班结束日期
	var jbjssj_dt1="#field7428_";//加班结束时间
	var gh_dt1="#field7424_";//工号
    jQuery(document).ready(function(){
		checkCustomize = function () {
			var indexnum0 = jQuery("#indexnum0").val();
			 var countnum=0;
			 for(var index=0;index<indexnum0;index++){
				 if (jQuery(jbksrq_dt1 + index).length > 0) {
					 countnum = countnum+1;	
					 var jbksrq_dt1_val=jQuery(jbksrq_dt1 + index).val();
					 var jbjsrq_dt1_val=jQuery(jbjsrq_dt1 + index).val();
					 var jbkssj_dt1_val=jQuery(jbkssj_dt1 + index).val();
					 var jbjssj_dt1_val=jQuery(jbjssj_dt1 + index).val();
					 var gh_dt1_val=jQuery(gh_dt1 + index).val();
					 var begindate_val=jbksrq_dt1_val+' '+jbkssj_dt1_val;
					 var enddate_val = jbjsrq_dt1_val+' '+jbjssj_dt1_val;
					 if(jbksrq_dt1_val>jbjsrq_dt1_val){
						 alert("加班结束时间不得早于加班开始时间,请检查");
							return false; 
					 }
					 if(jbksrq_dt1_val==jbjsrq_dt1_val && jbkssj_dt1_val>jbjssj_dt1_val){
						 alert("加班结束时间不得早于加班开始时间,请检查");
							return false; 
					 }
					 if(!checktimeinner(index+1,gh_dt1_val,begindate_val,enddate_val)){

					  alert("工号为"+gh_dt1_val+"的员工加班开始时间为\""+begindate_val+"\"的记录存在时间冲突，请检查");
					  return false;
		              }	  
					 
				 }
			 }
			 return true;
		}
		
	});
	
	function checktimeinner(startindex,jygh,begin,end){
		var indexnum0 = jQuery("#indexnum0").val();
		 for (var index2= startindex; index2 < indexnum0; index2++) {  
			if (jQuery(jbksrq_dt1 + index2).length > 0) {
					
				var jbksrq_dt1_val=jQuery(jbksrq_dt1 + index2).val();
				var jbjsrq_dt1_val=jQuery(jbjsrq_dt1 + index2).val();
				var jbkssj_dt1_val=jQuery(jbkssj_dt1 + index2).val();
				var jbjssj_dt1_val=jQuery(jbjssj_dt1 + index2).val();
				var gh_dt1_val=jQuery(gh_dt1 + index2).val();
				var begindate_val=jbksrq_dt1_val+' '+jbkssj_dt1_val;
				var enddate_val = jbjsrq_dt1_val+' '+jbjssj_dt1_val;
				if(jygh ==gh_dt1_val ){
					if(begindate_val < end && enddate_val > begin){
         	 		  return false;	
         	 		}	
         	     }else{
         	      continue;
         	     }
					 
				}
		 }
		 return true;
	}
</script>
