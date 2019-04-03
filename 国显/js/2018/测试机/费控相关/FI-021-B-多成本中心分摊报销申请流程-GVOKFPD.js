<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var bxje="#field50034";//报销金额
var qxje="#field50035";//取现金额
var cjzje="#field50095";//冲借支金额
var jkr_dt2="#field50118_";//明细2 借款人
var bxr_dt3="#field50119_";//明细3 报销人
var qxje_dt3="#field50126_";//明细3 取现金额
var fphm_dt1 = "#field50104_";//明细1 发票号码
var sfcf_dt1 = "#field51996_";//明细1 是否重复
var fycdfb="#field50040";
jQuery(document).ready(function(){
	jQuery(bxje).bindPropertyChange(function (){ 
		var bxje_val=jQuery(bxje).val();
		var cjzje_val=jQuery(cjzje).val();
		if(bxje_val==""){
			bxje_val = "0";
		}
		if(cjzje_val==""){
			cjzje_val = "0";
		}
		var qxje_val=accSub(bxje_val,cjzje_val);
		var indexnum2 = jQuery("#indexnum2").val();
		for(var index=0; index<indexnum2;index++){
			if(jQuery(qxje_dt3+index).length>0){	
				jQuery(qxje_dt3+index).val(qxje_val);
			}
		}
		calSum(2);
	
	});
	jQuery(cjzje).bindPropertyChange(function (){ 
		var bxje_val=jQuery(bxje).val();
		var cjzje_val=jQuery(cjzje).val();
		if(bxje_val==""){
			bxje_val = "0";
		}
		if(cjzje_val==""){
			cjzje_val = "0";
		}
		var qxje_val=accSub(bxje_val,cjzje_val);
		var indexnum2 = jQuery("#indexnum2").val();
		for(var index=0; index<indexnum2;index++){
			if(jQuery(qxje_dt3+index).length>0){	
				jQuery(qxje_dt3+index).val(qxje_val);
			}
		}
		calSum(2);
	
	});
	checkCustomize = function () {
		var fycdfb_val=jQuery(fycdfb).val();
		if(fycdfb_val !="24" && fycdfb_val !="43"){
			window.top.Dialog.alert("费用承担分部必须属于国显光电或者显示中心，请检查");
			return false;
		}
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
function accSub(arg1,arg2){
   var r1,r2,m,n;
    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
       m=Math.pow(10,Math.max(r1,r2));
       //动态控制精度长度
       n=(r1>=r2)?r1:r2;
       return ((arg1*m-arg2*m)/m).toFixed(n);
}
</script>

