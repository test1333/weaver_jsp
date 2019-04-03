<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
  var date1_dt1="#field7563_";//Date
  var ParCode_dt1="#field7564_";//ParCode
  var BU_dt1="#field7565_";//BU
  var Description_dt1="#field7566_";//Description
  var Amount_dt1="#field7572_";//Amount
  var Owner_dt1="#field7570_";//Owner
  var Department_dt1="#field7571_";//Department
  var BudgetNo_dt1="#field7573_";//BudgetNo
  var ProjectType_dt1="#field7574_";//ProjectType
  var disProjectType_dt1="#disfield7574_";//ProjectType
  var ls="#field7575";//流水
  var mxjehz="#field7581";//明细金额汇总
  var xmzcbhs="#field7091";//项目总成本含税
  jQuery(document).ready(function(){
	  jQuery("button[name=addbutton0]").live("click", function () {
	  	   var indexnum0=jQuery("#indexnum0").val()-1;
		   copydetail(indexnum0);
		});
		checkCustomize = function () {
			var mxjehz_val=jQuery(mxjehz).val();
			var xmzcbhs_val=jQuery(xmzcbhs).val();
			if(mxjehz_val == ""){
				mxjehz_val="0";	
			}
			if(xmzcbhs_val == ""){
				xmzcbhs_val="0";	
			}
			if(Number(mxjehz_val)!= Number(xmzcbhs_val)){
				alert("Amount金额不一致，请确认！");
				return false;
			}
			  return true;
		}

  });
   function copydetail(indexnum){
	   var index0=-1;
	   for (var index=0;index<indexnum;index++){
		    if(jQuery(date1_dt1+index).length>0){
				index0=index;
				break;
			}
	   }
	   if(index0 == -1){
		   return;
	   }
	   jQuery(date1_dt1+indexnum).val(jQuery(date1_dt1+index0).val());
	   jQuery(date1_dt1+indexnum+"span").text(jQuery(date1_dt1+index0+"span").text());
	   jQuery(ParCode_dt1+indexnum).val(jQuery(ParCode_dt1+index0).val());
	   jQuery(ParCode_dt1+indexnum+"span").text(jQuery(ParCode_dt1+index0).val());
	   //
	   jQuery(BU_dt1+indexnum).val(jQuery(BU_dt1+index0).val());
	   jQuery(BU_dt1+indexnum+"span").text(jQuery(BU_dt1+index0+"span").text());
	   jQuery(Description_dt1+indexnum).val(jQuery(Description_dt1+index0).val());
	   if(jQuery(Description_dt1+indexnum).val() !=""){
		 jQuery(Description_dt1+indexnum+"span").html("");   
	   }
	  
	   jQuery(Amount_dt1+indexnum).val(jQuery(Amount_dt1+index0).val());
	    if(jQuery(Amount_dt1+indexnum).val() !=""){
		 jQuery(Amount_dt1+indexnum+"span").html("");   
	   }
	   jQuery(BudgetNo_dt1+indexnum).val(jQuery(BudgetNo_dt1+index0).val());
	   jQuery(BudgetNo_dt1+indexnum+"span").text(jQuery(BudgetNo_dt1+index0+"span").text());
	   
	   jQuery(ProjectType_dt1+indexnum).val(jQuery(ProjectType_dt1+index0).val());
	   jQuery(disProjectType_dt1+indexnum).val(jQuery(ProjectType_dt1+index0).val());
		
	   jQuery(Owner_dt1+indexnum).val(jQuery(Owner_dt1+index0).val());
	   jQuery(Owner_dt1+indexnum+"span").text(jQuery(Owner_dt1+index0+"span").text());
	   
	   jQuery(Department_dt1+indexnum).val(jQuery(Department_dt1+index0).val());
	   jQuery(Department_dt1+indexnum+"span").text(jQuery(Department_dt1+index0+"span").text());
	   
	 calSum(0);

   }
  


</script>
