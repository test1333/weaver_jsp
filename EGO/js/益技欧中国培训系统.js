<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var type = "#field6329";
var hdsx_dt1="#field6335_";
var hdsx_dt2="#field6338_";
var pxml="#field6330";
var name_dt3="#field6341_";
jQuery(document).ready(function(){
	jQuery(type).bindPropertyChange(function () {
		 var nodesnum0=jQuery("#nodesnum0").val();
		 var nodesnum1=jQuery("#nodesnum1").val();
		if(nodesnum0>0){
		  jQuery("[name = check_node_0]:checkbox").attr("checked", true);
		  adddelid(0,hdsx_dt1)
		  removeRow0(0);                                                               
		}
		if(nodesnum1>0){
		  jQuery("[name = check_node_1]:checkbox").attr("checked", true);
		  adddelid(1,hdsx_dt2)
		  removeRow0(1);                                                               
		}
	});
	jQuery(pxml).bindPropertyChange(function () {
		 var nodesnum2=jQuery("#nodesnum2").val();
		if(nodesnum2>0){
		  jQuery("[name = check_node_2]:checkbox").attr("checked", true);
		  adddelid(2,hdsx_dt1)
		  removeRow0(2);                                                               
		}
		
	});
})
  function adddelid(dtid,fieldidqf){
	var ids_dt1="";
          	var flag1="";
            var indexnum0=  jQuery("#indexnum"+dtid).val();
            for(var index=0;index <indexnum0;index++){
            	 if(jQuery(fieldidqf+index).length>0){
            	 	 var pp=document.getElementsByName('dtl_id_'+dtid+'_'+index)[0].value;
            	 	 ids_dt1=ids_dt1+flag1+pp;
            	 	 flag1=",";
            	}
           }
           	var deldtlid0_val=jQuery("#deldtlid"+dtid).val();
           	if(deldtlid0_val !=""){
           		deldtlid0_val=deldtlid0_val+","+ids_dt1;          
           }else{
           	   deldtlid0_val=ids_dt1;
          }
           	jQuery("#deldtlid"+dtid).val(deldtlid0_val);	
}
function removeRow0(groupid,isfromsap){
  try{
      var flag = false;
      var ids = document.getElementsByName("check_node_"+groupid);
      for(i=0; i<ids.length; i++) {
    if(ids[i].checked==true) {
      flag = true;
      break;
    }
    }
    if(isfromsap){flag=true;}
      if(flag) {
    if(isfromsap || _isdel()){
      var oTable=document.getElementById("oTable"+groupid)
      var len = document.forms[0].elements.length;
      var curindex=parseInt($G("nodesnum"+groupid).value);
      var i=0;
      var rowsum1 = 0;
      var objname = "check_node_"+groupid;
      for(i=len-1; i >= 0;i--) {
        if (document.forms[0].elements[i].name==objname){
          rowsum1 += 1;
        }
      }
      rowsum1=rowsum1+2;
      for(i=len-1; i>=0; i--) {
        if(document.forms[0].elements[i].name==objname){
          if(document.forms[0].elements[i].checked==true){
            var nodecheckObj;
            var delid;
            try{
              if(jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").length>0){                       
                    delid = jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").eq(0).val(); 
                  }
            }catch(e){}
            //记录被删除的旧记录 id串
            if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
              if($G("deldtlid"+groupid).value!=''){
                //老明细
                $G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
              }else{
                //新明细
                $G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
              }
            }
            //从提交序号串中删除被删除的行
            var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
            $G("submitdtlid"+groupid).value="";
            var k;
            for(k=0; k<submitdtlidArray.length; k++){
              if(submitdtlidArray[k]!=delid){
                if($G("submitdtlid"+groupid).value==''){
                  $G("submitdtlid"+groupid).value = submitdtlidArray[k];
                }else{
                  $G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
                }
              }
            }
            oTable.deleteRow(rowsum1);
            curindex--;
          }
          rowsum1--;
        }
      }
      $G("nodesnum"+groupid).value=curindex;
      calSum(groupid);
       }
     }else{
          alert('请选择需要删除的数据');
      return;
   }  
  }catch(e){}
    try{
      var indexNum = jQuery("span[name='detailIndexSpan0']").length;
      for(var k=1; k<=indexNum; k++){
        jQuery("span[name='detailIndexSpan0']").get(k-1).innerHTML = k;
      }
    }catch(e){}
  }
  
function _isdel(){
    return true;
} 	
</script>




