<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">

var cgddh ="#field55664";//采购订单号
var cgddlc="#field55665";//采购订单流程
var fyssqj_dt = "#field52126_";//费用所属期间
var ddzje = "#field56288";//订单总金额
var bcbxzje = "#field55888";//本次报销总金额

var cgsqdh_dt1 = "#field56191_";//采购申请单号
var hxmh_dt1 = "#field56192_";//行项目号
var fycdzt_dt1 = "#field56199_";//费用承担主体
var fycdbm_dt1 = "#field56200_";//费用承担部门
var fyssqj_dt1 = "#field52126_";//费用所属期间
var yskm_dt1 = "#field52127_";//预算科目
var djje_dt1 = "#field56281_";//冻结金额
var wsje_dt1 = "#field52131_";//未税金额
jQuery(document).ready(function(){

	jQuery(cgddlc).bindPropertyChange(function (){ 
		var cgddlc_val = jQuery(cgddlc).val();
		var nodesnum0=jQuery("#nodesnum0").val();
		if(nodesnum0>0){
		  jQuery("[name = check_node_0]:checkbox").attr("checked", true);
		  adddelid(0,fyssqj_dt)
		  removeRow0(0);                                                               
		}
		if(cgddlc_val != ""){
			dodetail(cgddlc_val);
		}
	
	
	})
	jQuery(cgddh).bindPropertyChange(function (){ 
		var cgddh_val = jQuery(cgddh).val();
		 var nodesnum0=jQuery("#nodesnum0").val();
		if(nodesnum0>0){
		  jQuery("[name = check_node_0]:checkbox").attr("checked", true);
		  adddelid(0,fyssqj_dt)
		  removeRow0(0);                                                               
		}
		cgddh_val=cgddh_val.replace(/\|\|/g,',');	
		if(cgddh_val !=""){
			var rqids="";
			var rqnames="";
			var flag="";
			var result=getRQID(cgddh_val,'PO07');
			var text_arr = result.split("@@@");
			if (text_arr.length > 1) {
				var length_dt = Number(text_arr.length);
				for (var i = 0; i < length_dt-1; i++) {
					var tmp_arr = text_arr[i].split("###");
					rqids=rqids+flag+tmp_arr[1];
					
					rqnames=rqnames+"<a href='javaScript:openFullWindowHaveBar(&quot;/workflow/request/ViewRequest.jsp?requestid="+tmp_arr[1]+"&quot;)'>"+tmp_arr[0]+"</a>   ";
					flag=",";
				}
				 
			}
		}
		jQuery(cgddlc).val(rqids);
		jQuery(cgddlc+"span").html(rqnames);
		//if(rqids != ""){
			//alert(rqids);
		//	dodetail(rqids);
			
		//}
	
		
    })
	checkCustomize = function () {
		//var ddzje_val = jQuery(ddzje).val();
		var bcbxzje_val = jQuery(bcbxzje).val();
		if(bcbxzje_val == ""){
			bcbxzje_val = "0";	
		}
		//if(ddzje_val == ""){
		//	ddzje_val = "0";	
		//}
		//if(Number(bcbxzje_val)>Number(ddzje_val)){
			//Dialog.alert("本次报销总金额必须小于等于订单总金额，请检查");
			//return false;
		//}
		var indexnum0=  jQuery("#indexnum0").val();
		for( var index=0;index<indexnum0;index++){
        	if( jQuery(wsje_dt1+index).length>0){
				var wsje_dt1_val = jQuery(wsje_dt1+index).val();
				var djje_dt1_val = jQuery(djje_dt1+index).val();
				if(wsje_dt1_val == ""){
				   wsje_dt1_val = "0";					
				}
				if(wsje_dt1_val == ""){
				   wsje_dt1_val = "0";					
				}
				if(Number(wsje_dt1_val)>Number(djje_dt1_val)){
					Dialog.alert("明细中未税金额必须小于等于冻结未税金额，请检查");
					return false;					
				}
				
			}
		}
		return true;
	}
	
})
function dodetail(rqids){
	var indexnum1=  jQuery("#indexnum0").val();
	jQuery.ajax({
             type: "POST",
             url: "/gvo/costcontrol/getxjginfo.jsp",
             data: {'cgddlcs':rqids},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        //alert(data);
						if(data != ""){
							var text_arr = data.split("@@@");
							var length1=Number(text_arr.length)-1+Number(indexnum1);
							for(var i=indexnum1;i<length1;i++){
							  addRow0(0);
							  var tmp_arr = text_arr[i-indexnum1].split("###");
							  jQuery(fycdzt_dt1+i).val(tmp_arr[0]);
							  jQuery(fycdzt_dt1+i+"span").text(tmp_arr[0]);
							  jQuery(fycdbm_dt1+i).val(tmp_arr[1]);
							  jQuery(fycdbm_dt1+i+"span").text(tmp_arr[2]);
							  //jQuery(fyssqj_dt1+i).val(tmp_arr[3]);
							 // jQuery(fyssqj_dt1+i+"span").text(tmp_arr[3]);
							  jQuery(yskm_dt1+i).val(tmp_arr[4]);
							  jQuery(yskm_dt1+i+"span").text(tmp_arr[5]);
							   jQuery(cgsqdh_dt1+i).val(tmp_arr[6]);
							  jQuery(cgsqdh_dt1+i+"span").text(tmp_arr[6]);
							  jQuery(hxmh_dt1+i).val(tmp_arr[7]);
							  jQuery(hxmh_dt1+i+"span").text(tmp_arr[7]);
							  jQuery(djje_dt1+i).val(tmp_arr[8]);
							  jQuery(djje_dt1+i+"span").text(tmp_arr[8]);
							 }
							
						}
             }
     });
}

function getRQID(cgddhs,type){
    var result="";
    $.ajax({
             type: "POST",
             url: "/gvo/costcontrol/getrqinfo.jsp",
             data: {'cgddhs':cgddhs, 'type':type},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        result=data;
             }
         });
     return result;
}

function accAdd(arg1,arg2){
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2))
    return (arg1*m+arg2*m)/m
}

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

















