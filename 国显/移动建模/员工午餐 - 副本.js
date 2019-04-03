/*
	表单提交前会调用此脚本，如果脚本中返回false，则会阻止表单提交，无返回值或者返回true，表单将正常提交。
	编写脚本时可以直接使用Mobile_NS.getFormField方法获取字段，如Mobile_NS.getFormField("title").val();
*/

var txrq_val= $("input[name='fieldname_TXRQ']").val();
var txsj_val= $("input[name='fieldname_TXSJ']").val();

for(var i=1;i<=100;i++){
  if($("input[name='uf_staff_lunch_dt1_dcrq_rowindex_"+i+"']").length>0){
	  var dcrq_val=$("input[name='uf_staff_lunch_dt1_dcrq_rowindex_"+i+"']").val();	  
	 if(txrq_val == dcrq_val){
		 if(txsj_val>"09:00"){
		   alert("当天午餐只能在当天早上9点之前订，请修改订餐日期");
           return false;
		 }
	 }
  }else{
     i=101;	
  }
}