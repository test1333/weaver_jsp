<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var glprdj = "#field10448";//关联pr单据
var prdtid_dt1 = "#field10449_";//明细1 prdtid
var prdtid2_dt1 = "field10449_";//明细1 prdtid
var wlms_dt1 = "#field10419_";//明细1 物料描述
var wlmsyw_dt1 = "#field10420_";//明细1 物料描述英文
var wlbm_dt1 = "#field10418_";//明细1 物料编码
//var cbzx_dt1 = "#field6798_";//明细1 成本中心
//var je_dt1 = "#field6445_";//明细1 金额
//var yje_dt1 = "#field7044_";//明细1 原金额
var pzlx = "#field10394";//凭证类型
var pzlxwb = "#field10441";//凭证类型文本
jQuery(document).ready(function () {
	jQuery("#xzmx").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='选择明细' onclick='showxx()'>");
	checkCustomize = function () {
		var pzlx_val = jQuery(pzlx).val();
		if(pzlx_val == "1"){
			jQuery(pzlxwb).val("GWK");
		}else{
			jQuery(pzlxwb).val("SMK");
		}
		return true;
	}
});
function showxx() {
	var currentrqid_val=document.getElementsByName("requestid")[0].value;   
	var glprdj_val = jQuery(glprdj).val();
	if(glprdj_val == ""){
		alert("请先选择关联pr流程");
		return;
	}
	var title = "";
	var url = "/zx/purchase/show-wwpr-detail-info-url.jsp?rqid="+glprdj_val+"&currentrqid="+currentrqid_val;
	var diag_vote = new window.top.Dialog();
	diag_vote.currentWindow = window;
	diag_vote.Width = 1000;
	diag_vote.Height = 750;
	diag_vote.Modal = true;
	diag_vote.Title = title;
	diag_vote.URL = url;
	diag_vote.isIframe=false;
	diag_vote.CancelEvent=function(){diag_vote.close();	
	};
	diag_vote.show();
		
}
function savefc(checkids){
	setTimeout("dodetail('"+checkids+"')",150);
}
function dodetail(checkids){
    var nodesnum0 = jQuery("#nodesnum0").val();
    if(nodesnum0 >0){
        jQuery("[name = check_node_0]:checkbox").attr("checked", true);
        adddelid(0,prdtid_dt1);
        removeRow0(0);
    }
	var indexnum1=  jQuery("#indexnum0").val();
	var text_arr = checkids.split(",");
	var length1=Number(text_arr.length)+Number(indexnum1);
	for(var i=indexnum1;i<length1;i++){
	addRow0(0);
	jQuery(prdtid_dt1+i).val(text_arr[i-indexnum1]);
		
	}
	indexnum1=  jQuery("#indexnum0").val();
	for(var index=0;index<indexnum1;index++){
		 if(jQuery(prdtid_dt1+index).length>0){
			 var prdtid_val = jQuery(prdtid_dt1+index).val();
			// alert(prdtid_val);
			 jQuery.ajax({
				 type: "POST",
				 url: "/zx/purchase/get_wwpr_detailinfo.jsp",
				 data: {'checkids':prdtid_val},
				 dataType: "text",
				 async:false,//同步   true异步
				 success: function(data){
							data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert(data);
							var text_arr = data.split("@@@");
							if(text_arr.length>0){
								var data_arr = text_arr[0].split("###");
								jQuery(wlbm_dt1+index).val(data_arr[0]);
								jQuery(wlbm_dt1+index+"span").text(data_arr[0]);
								jQuery(wlms_dt1+index).val(data_arr[1]);
								jQuery(wlms_dt1+index+"span").text(data_arr[1]);
								jQuery(wlmsyw_dt1+index).val(data_arr[2]);
								jQuery(wlmsyw_dt1+index+"span").text(data_arr[2]);
								
								
							}
				}
			 });
		 }

	}
	
	//for(var index=0;index<indexnum1;index++){
	//	 if(jQuery(prdtid_dt1+index).length>0){
	//		datainputd(prdtid2_dt1+index);
	//	 }

	//}

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
    }    }catch(e){}
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
