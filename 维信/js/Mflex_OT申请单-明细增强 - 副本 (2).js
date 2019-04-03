<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var jbksrq_dt1="#field7426_";//加班开始日期
	var jbkssj_dt1="#field7427_";//加班开始时间
	var jbjsrq_dt1="#field7454_";//加班结束日期
	var jbjssj_dt1="#field7428_";//加班结束时间
	var gh_dt1="#field7424_";//工号
    jQuery(document).ready(function(){
		var checkCustomizeOld = checkCustomize;
	    checkCustomize = function(){ 
		var flag=true;
		var detail = wfDetail.doGet(0);
		var datas = detail.datas
		 $.each(datas, function(i, value) {
			 var jbksrq_dt1_val=this.wdfield7426;
			 var jbkssj_dt1_val=this.wdfield7427;
			 var jbjsrq_dt1_val=this.wdfield7454;
			 var jbjssj_dt1_val=this.wdfield7428;
			 var gh_dt1_val=this.wdfield7424;
			 var key=this.key;
			 var begindate_val=jbksrq_dt1_val+' '+jbkssj_dt1_val;
			var enddate_val = jbjsrq_dt1_val+' '+jbjssj_dt1_val;
			 if(begindate_val>enddate_val){
				alert("第"+key+"行明细,工号为"+gh_dt1_val+"的员工加班结束时间不得早于加班开始时间,请检查");
					flag=false;
				    return false; 
			 }
			 if(gh_dt1_val !=''){
				 if(!checktimeinner(key,gh_dt1_val,begindate_val,enddate_val)){

					alert("工号为"+gh_dt1_val+"的员工加班开始时间为\""+begindate_val+"\"的记录存在时间冲突，请检查");
					flag=false;
					return false;
				 }	
			 }
			 
		 });
		  if(!flag){
                return false; 	   
          }
	      return checkCustomizeOld();
		}
		
		
	});
	
	function checktimeinner(startindex,jygh,begin,end){
		var flag=true;
		var detail = wfDetail.doGet(0);
		var datas = detail.datas
		 $.each(datas, function(i, value) {
			  	 var jbksrq_dt1_val=this.wdfield7426;
			 var jbkssj_dt1_val=this.wdfield7427;
			 var jbjsrq_dt1_val=this.wdfield7454;
			 var jbjssj_dt1_val=this.wdfield7428;
			 var gh_dt1_val=this.wdfield7424;
			 var key=this.key;
			 var begindate_val=jbksrq_dt1_val+' '+jbkssj_dt1_val;
			var enddate_val = jbjsrq_dt1_val+' '+jbjssj_dt1_val;
			if(Number(key)>Number(startindex)){
				if(jygh ==gh_dt1_val ){
					if(begindate_val < end && enddate_val > begin){
						flag=false;
         	 		  return false;	
         	 		}	
         	     }
			}
			
		 })
		if(!flag){
                return false; 	   
          }
		 return true;
	}
</script>
