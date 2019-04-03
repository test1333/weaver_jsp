<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var bxje="#field52973";//报销金额
var qxje="#field52974";//付款金额
var cjzje="#field52845";//冲预付款金额
var fphm_dt1 = "#field47246_";//明细1 发票号码
var sfcf_dt1 = "#field53933_";//明细1 是否重复
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
			window.top.Dialog.alert("报销金额不等于付款金额加冲预付款金额,请检查");
			return false;
		}
		var indexnum0 = jQuery("#indexnum0").val();
    	var countnum=0;
		for(var index=0; index<indexnum0;index++){
			if(jQuery(fphm_dt1+index).length>0){
				countnum = countnum +1;
				var fphm_dt1_val = jQuery(fphm_dt1+index).val();
				var sfcf_dt1_val = jQuery(sfcf_dt1+index).val();
				if(fphm_dt1_val != "" && sfcf_dt1_val != ""){
					Dialog.alert("第"+countnum+"行明细的发票号码（"+fphm_dt1_val+"）已在流程编号为（"+sfcf_dt1_val+"）的流程中使用，请检查");
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
