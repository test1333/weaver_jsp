<script type="text/javascript">
var hkje="#field9453";//还款金额
var jkje="#field9455";//借款
jQuery(document).ready(function(){
	
	
	checkCustomize = function () {
		var hkje_val = jQuery(hkje).val();
		var jkje_val = jQuery(jkje).val();
		if (hkje_val == ""){
			hkje_val = "0";
		}
		if (jkje_val == ""){
			jkje_val = "0";
		}
		if(Number(accSub(hkje_val,jkje_val))>Number("0")){
			window.top.Dialog.alert("还款金额大于借款金额无法提交");
		    return false;
		}
			
		
		return true;
	}
	
});
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