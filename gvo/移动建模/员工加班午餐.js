/*
	表单提交前会调用此脚本，如果脚本中返回false，则会阻止表单提交，无返回值或者返回true，表单将正常提交。
	编写脚本时可以直接使用Mobile_NS.getFormField方法获取字段，如Mobile_NS.getFormField("title").val();
*/
var txrq_val= $("input[name='fieldname_TXRQ']").val();
var txsj_val= $("input[name='fieldname_TXSJ']").val();


for(var i=1;i<=100;i++){
  if($("input[name='UF_STAFF_LUNCH_JB_DT1_DCRQ_rowindex_"+i+"']").length>0){
	  var dcrq_val=$("input[name='UF_STAFF_LUNCH_JB_DT1_DCRQ_rowindex_"+i+"']").val();	
	  var dcsd_val=$("input[name='UF_STAFF_LUNCH_JB_DT1_DCSD_rowindex_"+i+"']").val();	
	   var dcr_val=$("input[name='UF_STAFF_LUNCH_JB_DT1_DCR_rowindex_"+i+"']").val();	 
	  var result = Mobile_NS.SQL("SELECT to_char(to_date('"+dcrq_val+"','yyyy-mm-dd'),'Day') as xq FROM DUAL ");
	  var dqxq_val=result[0].xq;
	  if(dqxq_val == "星期六"){
		   var sqlresult = Mobile_NS.SQL("select to_char(to_date('"+dcrq_val+"','yyyy-mm-dd')-1,'yyyy-mm-dd') as zw from dual ");
		   var zw=sqlresult[0].zw;
		   if(txrq_val > zw ){
			   alert("周末加班餐只能在周五下午5点前预定");
			    return false;
		   }
		   if(txrq_val == zw && txsj_val>"17:00"){
			   alert("周末加班餐只能在周五下午5点前预定");
			    return false;
		   }
	  }
	  if(dqxq_val == "星期日"){
		   var sqlresult = Mobile_NS.SQL("select to_char(to_date('"+dcrq_val+"','yyyy-mm-dd')-2,'yyyy-mm-dd') as zw from dual ");
		   var zw=sqlresult[0].zw;
		   if(txrq_val > zw ){
			   alert("周末加班餐只能在周五下午5点前预定");
			    return false;
		   }
		    if(txrq_val == zw && txsj_val>"17:00"){
			   alert("周末加班餐只能在周五下午5点前预定");
			    return false;
		   }
	  }
	 if(txrq_val == dcrq_val){
		 if(txsj_val>"09:00" && dcsd_val=="0"){
		   alert("当天午餐只能在当天早上9点之前订，请修改订餐日期");
           return false;
		 }
		 if(txsj_val>"14:00" && dcsd_val=="1"){
		   alert("当天晚餐只能在当天早上14点之前订，请修改订餐日期");
           return false;
		 }
	 }
	 var sqlresult = Mobile_NS.SQL("select count(1) as count  from uf_staff_lunch_jb a,uf_staff_lunch_jb_dt1 b where a.id=b.mainid and b.dcr='"+dcr_val+"' and b.dcrq='"+dcrq_val+"' and b.dcsd='"+dcsd_val+"'");
	  var count=sqlresult[0].count;
	  if(count>0){
		  sqlresult = Mobile_NS.SQL("select lastname from hrmresource where id="+dcr_val);
		   var lastname=sqlresult[0].lastname;
		   if(dcsd_val == "0"){
			alert(lastname+"在"+dcrq_val+"日已订过午餐，请检查"); 
		   }else{
			alert(lastname+"在"+dcrq_val+"日已订过晚餐，请检查"); 
		   }
		return false;
	  }
  }else{
     i=101;	
  }
}