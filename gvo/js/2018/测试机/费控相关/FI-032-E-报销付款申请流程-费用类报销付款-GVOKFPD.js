<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var bxje="#field52973";//报销金额
var qxje="#field52974";//付款金额
var cjzje="#field52845";//冲预付款金额
var fphm_dt1 = "#field47246_";//明细1 发票号码
var sfcf_dt1 = "#field53020_";//明细1 是否重复
var fkjeyb="#field52925";//付款金额原币
var htwfje="#field52853";//合同未付金额
var cgddh ="#field49427";//采购订单号
var cgddlc="#field49428";//采购订单流程

var sfhtkz = "#field52854";  //是否合同控制
var bcfue = "#field52925";  //付款金额
var htwfe = "#field52853";   //合同未付金额

var sqdjje_dt1 =  "#field52967_";//冻结金额
var wsje_dt1 = "#field47247_";//未税金额
var ysje_dt1 = "#field55122_";//预算金额

var podh_dt1 = "#field47237_";//po单号
var ysssqj_dt1 = "#field47250_";//预算所属期间
var fycdbm_dt1 = "#field47239_";//费用承担部门
var yskm_dt1 = "#field49467_";//预算科目
var cbzxbm_dt1 = "#field47240_";//成本中心
var kmbm_dt1 = "#field47238_";//科目编码
var xmyfbh_dt1 = "#field53144_";//项目研发编号
jQuery(document).ready(function(){
	//alert("123");
	jQuery("button[name=addbutton0]").css('display','none');
	jQuery("button[name=delbutton0]").css('display','none');
	var indexnum0 = jQuery("#indexnum0").val();
	for(var index=0; index<indexnum0;index++){
		if(jQuery(sqdjje_dt1+index).length>0){
			 bind(index);		
		}
		
	}
	jQuery(cgddlc).bindPropertyChange(function (){ 
		var cgddlc_val = jQuery(cgddlc).val();
		if(cgddlc_val != ""){
			setTimeout('dodetail()',1000);
		}
	
	
	})
	jQuery(cgddh).bindPropertyChange(function (){ 
		var cgddh_val = jQuery(cgddh).val();

		 var nodesnum0=jQuery("#nodesnum0").val();
		if(nodesnum0>0){
		  jQuery("[name = check_node_0]:checkbox").attr("checked", true);
		  adddelid(0,fphm_dt1)
		  removeRow0(0);                                                               
		}
		cgddh_val=cgddh_val.replace(/\|\|/g,',');	
		if(cgddh_val !=""){
			var rqids="";
			var rqnames="";
			var flag="";
			var result=getRQID(cgddh_val,'PO03');
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
		addDetail1Row(rqids);
		if(rqids != ""){
			setTimeout('dodetail()',1000);
		}
		
    })
	checkCustomize = function () {
		var bxje_val=jQuery(bxje).val();
		var qxje_val=jQuery(qxje).val();
		var cjzje_val=jQuery(cjzje).val();
		var fkjeyb_val = jQuery(fkjeyb).val();
		var htwfje_val = jQuery(htwfje).val();
		var bxrid="";
		if(bxje_val == ""){
			bxje_val = "0";
		}
		if(qxje_val == ""){
			qxje_val = "0";
		}if(cjzje_val == ""){
			cjzje_val = "0";
		}
		if(fkjeyb_val == ""){
			fkjeyb_val = "0";
		}if(htwfje_val == ""){
			htwfje_val = "0";
		}
           if(jQuery(sfhtkz).val()=="0"){
		if(Number(fkjeyb_val) > Number(htwfje_val)){
			window.top.Dialog.alert("本次付款额（原币）不得超过合同未付金额,请检查");
			return false;
		}
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
function dodetail(){
	var indexnum0 = jQuery("#indexnum0").val();
	for(var index=0; index<indexnum0;index++){
		if(jQuery(sqdjje_dt1+index).length>0){
			var ysje_dt1_val = jQuery(ysje_dt1+index).val();
			jQuery(sqdjje_dt1+index).val(ysje_dt1_val);
			jQuery(sqdjje_dt1+index+"span").text(ysje_dt1_val);
			 bind(index);
			 getotherinfo(index);
			
		}
		
	}
	calSum(0);
}
function getotherinfo(index){
	var cgddlc_val = jQuery(cgddlc).val();
	var ysssqj_dt1_val = jQuery(ysssqj_dt1+index).val();
	var fycdbm_dt1_val = jQuery(fycdbm_dt1+index).val();
	var yskm_dt1_val = jQuery(yskm_dt1+index).val();
	//alert(cgddlc_val);alert(ysssqj_dt1_val);alert(fycdbm_dt1_val);alert(yskm_dt1_val);
	 jQuery.ajax({
             type: "POST",
             url: "/gvo/costcontrol/getfyreiminfo.jsp",
             data: {'cgddlcs':cgddlc_val,'ysssqj':ysssqj_dt1_val,'fycdbm':fycdbm_dt1_val,'yskm':yskm_dt1_val},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        //alert(data);
						if(data != ""){
							var tmp_arr = data.split("###");	
							jQuery(podh_dt1+index).val(tmp_arr[0]);
							jQuery(podh_dt1+index+"span").text(tmp_arr[0]);							
							jQuery(cbzxbm_dt1+index).val(tmp_arr[1]);
							jQuery(cbzxbm_dt1+index+"span").text(tmp_arr[1]);							
							jQuery(kmbm_dt1+index).val(tmp_arr[2]);
							jQuery(kmbm_dt1+index+"span").text(tmp_arr[2]);
							jQuery(xmyfbh_dt1+index).val(tmp_arr[3]);
							jQuery(xmyfbh_dt1+index+"span").text(tmp_arr[3]);
							
						}
             }
     });

	
}
function bind(index){
	jQuery(wsje_dt1+index).bindPropertyChange(function (){ 
		var wsje_dt1_val = jQuery(wsje_dt1+index).val();
		jQuery(ysje_dt1+index).val(wsje_dt1_val);
		
	})
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










