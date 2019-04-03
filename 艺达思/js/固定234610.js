<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 var kmzh_dt1="field6445_";//科目组合-明细1
 var sfmap="#field6581";//是否匹配
 var sfmap2="#disfield6581";//是否匹配
    var sfmap_dt1="field6582_";//科目组合-明细1
  var sfbh_dt1="#field6711_";//是否标红-明细1
    var djhs_dt1="#field6442_";//单价含税-明细1
  jQuery(document).ready(function () {
  	  	var indexnum00=  jQuery("#indexnum0").val();
  	        for(var index = 0;index<indexnum00;index++){
  	        	if(jQuery(sfbh_dt1+index).length>0){	
  	        		 var sfbh_dt1_val =jQuery(sfbh_dt1+index).val();
  	        		 if(sfbh_dt1_val=="1"){
  	        		   	 jQuery(djhs_dt1+index).attr({style:"color:red  !important"});
  	        		   	 jQuery(djhs_dt1+index+"span").attr({style:"color:red  !important"});  	 
  	        		}
  	              }
  	        }
  	 
 })


</script>
