<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var bxje="#field49669";//报销金额
var qxje="#field49670";//取现金额
var cjzje="#field49798";//冲借支金额
var jkr_dt2="#field49800_";//明细2 借款人
var bxr_dt3="#field49693_";//明细2 报销人
var fphm_dt4 = "#field49754_";//明细4 发票号码
var sfcf_dt4 = "#field49788_";//明细4 是否重复
var fphm_dt5 = "#field49757_";//明细5 发票号码
var sfcf_dt5 = "#field49760_";//明细6 是否重复
var fphm_dt7 = "#field49764_";//明细7 发票号码
var sfcf_dt7 = "#field49790_";//明细7 是否重复
jQuery(document).ready(function(){
	checkCustomize = function () {
		var bxje_val=jQuery(bxje).val();
		var qxje_val=jQuery(qxje).val();
		var cjzje_val=jQuery(cjzje).val();
		var bxrid="";
		if(bxje_val == ""){
			bxje_val = "0";
		}
		if(qxje_val == ""){
			qxje_val = "0";
		}if(cjzje_val == ""){
			cjzje_val = "0";
		}
		if(accAdd(Number(qxje_val),Number(cjzje_val))!=Number(bxje_val)){
			window.top.Dialog.alert("报销金额不等于取现金额加冲借支金额,请检查");
			return false;
		}
		var indexnum1 = jQuery('#indexnum1').val();
		for(var index =0;index <indexnum1;index++){
			if(jQuery(jkr_dt2+index).length>0){
				var jkr_dt2_val=jQuery(jkr_dt2+index).val();
				if(jkr_dt2_val != ""){
					if(bxrid == ""){
						bxrid = jkr_dt2_val;
					}else{
						if(jkr_dt2_val != bxrid){
							window.top.Dialog.alert("明细中借款人和报销人必须为同一人,请检查");
							return false;							
						}
					}
					
				}
				
			}
		}
		var indexnum2 = jQuery('#indexnum2').val();
		for(var index =0;index <indexnum2;index++){
			if(jQuery(bxr_dt3+index).length>0){
				var bxr_dt3_val=jQuery(bxr_dt3+index).val();

				if(bxr_dt3_val != ""){
					if(bxrid == ""){
						bxrid = bxr_dt3_val;
					}else{
						if(bxr_dt3_val != bxrid){
							window.top.Dialog.alert("明细中借款人和报销人必须为同一人");
							return false;							
						}
					}
					
				}
				
			}
		}
		var indexnum3 = jQuery("#indexnum3").val();
    	var countnum3=0;
		for(var index=0; index<indexnum3;index++){
			if(jQuery(fphm_dt4+index).length>0){
				countnum3 = countnum3 +1;
				var fphm_dt4_val = jQuery(fphm_dt4+index).val();
				var sfcf_dt4_val = jQuery(sfcf_dt4+index).val();
				if(fphm_dt4_val != "" && sfcf_dt4_val != ""){
					Dialog.alert("交通费第"+countnum3+"行明细的发票号码（"+fphm_dt4_val+"）已在流程编号为（"+sfcf_dt4_val+"）的流程中使用，请检查");
					return false;
				}
			}
		}
		var indexnum4 = jQuery("#indexnum4").val();
    	var countnum4=0;
		for(var index=0; index<indexnum4;index++){
			if(jQuery(fphm_dt5+index).length>0){
				countnum4 = countnum4 +1;
				var fphm_dt5_val = jQuery(fphm_dt5+index).val();
				var sfcf_dt5_val = jQuery(sfcf_dt5+index).val();
				if(fphm_dt5_val != "" && sfcf_dt5_val != ""){
					Dialog.alert("住宿费第"+countnum4+"行明细的发票号码（"+fphm_dt5_val+"）已在流程编号为（"+sfcf_dt5_val+"）的流程中使用，请检查");
					return false;
				}
			}
		}
		var indexnum6 = jQuery("#indexnum6").val();
    	var countnum6=0;
		for(var index=0; index<indexnum6;index++){
			if(jQuery(fphm_dt7+index).length>0){
				countnum6 = countnum6 +1;
				var fphm_dt7_val = jQuery(fphm_dt7+index).val();
				var sfcf_dt7_val = jQuery(sfcf_dt7+index).val();
				if(fphm_dt7_val != "" && sfcf_dt7_val != ""){
					Dialog.alert("其他费用第"+countnum6+"行明细的发票号码（"+fphm_dt7_val+"）已在流程编号为（"+sfcf_dt7_val+"）的流程中使用，请检查");
					return false;
				}
			}
		}
		return true;
	}
	
})
function accAdd(arg1,arg2){
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2))
    return (arg1*m+arg2*m)/m
}

</script>
