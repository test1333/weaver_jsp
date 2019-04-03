<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var cgjd="#field11002";//采购订单
	var htbczfje="#field9973";//合同本次支付金额
	var ddje="#field11324";//订单金额
	var ddyzfje="#field11325";//订单已支付金额
	var fkspzje="#field11327";//付款审批中金额
     jQuery(document).ready(function(){
     	 checkCustomize = function () {
     	 	 var htbczfje_val=jQuery(htbczfje).val();
     	 	 var ddje_val=jQuery(ddje).val();
     	 	 var ddyzfje_val=jQuery(ddyzfje).val();
     	 	 var fkspzje_val=jQuery(fkspzje).val();
     	 	 var cgjd_val=jQuery(cgjd).val();
     	 	 if(cgjd_val !=''){
	     	 	 if(ddje_val==""){
	     	 	    ddje_val="0";	 
	     	       }
	     	 	 if(htbczfje_val !=""){
	     	 	 	 var allmoney=accAdd(htbczfje_val,ddyzfje_val);
	     	 	 	 allmoney=accAdd(allmoney,fkspzje_val);
	     	 	 	 if(Number(allmoney)>Number(ddje_val)){
	     	 	 	   	 Dialog.alert("本次支付金额大于订单可支付金额，请检查");
	     	 	 	   	 return false;
	     	 	       }
	     	       }
     	   }
     	       return true;
              }
     });
  function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
  } 
</script>


