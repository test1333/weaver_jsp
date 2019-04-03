<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function () {
	jQuery("#"+t0.gs).bindPropertyChange(function(){
		getDetailInfo();
	});
	jQuery("#"+t0.zjjhlb).bindPropertyChange(function(){
		getDetailInfo();
	});
	jQuery("#"+t0.year).bindPropertyChange(function(){
		getDetailInfo();
	});
	jQuery("#"+t0.month).bindPropertyChange(function(){
		getDetailInfo();
	});
	
	setTimeout("changetab()",'1000');
	
})
function changetab(){
	var zjjhlb_val = jQuery("#"+t0.zjjhlb).val();
	if(zjjhlb_val == "1"){
		jQuery("#tab_3").click();
	}
}
function getDetailInfo(){
	var gs_val = jQuery("#"+t0.gs).val();
	var zjjhlb_val = jQuery("#"+t0.zjjhlb).val();
	var year_val = jQuery("#"+t0.year).val();
	var month_val = jQuery("#"+t0.month).val();
	deleteDetail();
	if(gs_val !="" && zjjhlb_val !="" && year_val !="" && month_val !=""){
		if(zjjhlb_val == "0"){
			dodetail1();
			dodetail2();
			jQuery("#tab_1").click();
		}
		if(zjjhlb_val == "1"){
			dodetail3();
			jQuery("#tab_3").click();
		}
	}
		
}

function deleteDetail(){
	var nodesnum0 = jQuery("#nodesnum0").val();
	if(nodesnum0 >0){
		jQuery("[name = check_node_0]:checkbox").attr("checked", true);
		adddelid(0,"#"+t1.type+"_");
		removeRow0(0);
	}
	var nodesnum1 = jQuery("#nodesnum1").val();
	if(nodesnum1 >0){
		jQuery("[name = check_node_1]:checkbox").attr("checked", true);
		adddelid(1,"#"+t2.type+"_");
		removeRow0(1);
	}
	var nodesnum2 = jQuery("#nodesnum2").val();
	if(nodesnum2 >0){
		jQuery("[name = check_node_2]:checkbox").attr("checked", true);
		adddelid(2,"#"+t3.type+"_");
		removeRow0(2);
	}
	
}
function dodetail1(){
	var gs_val = jQuery("#"+t0.gs).val();
	var year_val = jQuery("#"+t0.year).val();
	var month_val = jQuery("#"+t0.month).val();
	var indexnum0=  jQuery("#indexnum0").val();
    var xhr = null;
	if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}
	if (null != xhr) {			
		xhr.open("GET","/gvo/fi/get_zjjhzf_detail.jsp?gs="+gs_val+"&year="+year_val+"&month="+month_val, false);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
					var text_arr = text.split("@@@");
                    var length1=Number(text_arr.length)-1+Number(indexnum0);
					for(var i=indexnum0;i<length1;i++){                                                          
						addRow0(0);
						var tmp_arr = text_arr[i-indexnum0].split("###");					
						jQuery("#"+t1.type+"_"+i).val(tmp_arr[0]);	
						jQuery("#dis"+t1.type+"_"+i).val(tmp_arr[0]);		
						jQuery("#"+t1.month+"_"+i).val(tmp_arr[1]);							
						jQuery("#"+t1.month+"_"+i+"span").text(tmp_arr[1]);
						jQuery("#"+t1.month1+"_"+i).val(tmp_arr[2]);							
						jQuery("#"+t1.month1+"_"+i+"span").text(tmp_arr[2]);
						jQuery("#"+t1.month2+"_"+i).val(tmp_arr[3]);							
						jQuery("#"+t1.month2+"_"+i+"span").text(tmp_arr[3]);	
						jQuery("#"+t1.sum+"_"+i).val(tmp_arr[4]);							
						jQuery("#"+t1.sum+"_"+i+"span").text(tmp_arr[4]);							
					}
				}	
			}
		}
		xhr.send(null);			
	}
	
}
function dodetail2(){
	var gs_val = jQuery("#"+t0.gs).val();
	var year_val = jQuery("#"+t0.year).val();
	var month_val = jQuery("#"+t0.month).val();
	var indexnum1=  jQuery("#indexnum1").val();
    var xhr = null;
	if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}
	if (null != xhr) {			
		xhr.open("GET","/gvo/fi/get_zjjhsx_detail.jsp?gs="+gs_val+"&year="+year_val+"&month="+month_val, false);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
					var text_arr = text.split("@@@");
                    var length1=Number(text_arr.length)-1+Number(indexnum1);
					for(var i=indexnum1;i<length1;i++){                                                          
						addRow1(1);
						var tmp_arr = text_arr[i-indexnum1].split("###");					
						jQuery("#"+t2.type+"_"+i).val(tmp_arr[0]);	
						jQuery("#dis"+t2.type+"_"+i).val(tmp_arr[0]);		
						jQuery("#"+t2.month+"_"+i).val(tmp_arr[1]);							
						jQuery("#"+t2.month+"_"+i+"span").text(tmp_arr[1]);
						jQuery("#"+t2.month1+"_"+i).val(tmp_arr[2]);							
						jQuery("#"+t2.month1+"_"+i+"span").text(tmp_arr[2]);
						jQuery("#"+t2.month2+"_"+i).val(tmp_arr[3]);							
						jQuery("#"+t2.month2+"_"+i+"span").text(tmp_arr[3]);	
						jQuery("#"+t2.sum+"_"+i).val(tmp_arr[4]);							
						jQuery("#"+t2.sum+"_"+i+"span").text(tmp_arr[4]);								
					}
				}	
			}
		}
		xhr.send(null);			
	}
	
}
function dodetail3(){
	var gs_val = jQuery("#"+t0.gs).val();
	var year_val = jQuery("#"+t0.year).val();
	var month_val = jQuery("#"+t0.month).val();
	var indexnum2=  jQuery("#indexnum2").val();
    var xhr = null;
	if (window.ActiveXObject) {//IE浏览器
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}
	if (null != xhr) {			
		xhr.open("GET","/gvo/fi/get_zjjhsk_detail.jsp?gs="+gs_val+"&year="+year_val+"&month="+month_val, false);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
					var text_arr = text.split("@@@");
                    var length1=Number(text_arr.length)-1+Number(indexnum2);
					for(var i=indexnum2;i<length1;i++){                                                          
						addRow2(2);
						var tmp_arr = text_arr[i-indexnum2].split("###");					
						jQuery("#"+t3.type+"_"+i).val(tmp_arr[0]);	
						jQuery("#dis"+t3.type+"_"+i).val(tmp_arr[0]);		
						jQuery("#"+t3.month+"_"+i).val(tmp_arr[1]);							
						jQuery("#"+t3.month+"_"+i+"span").text(tmp_arr[1]);
						jQuery("#"+t3.month1+"_"+i).val(tmp_arr[2]);							
						jQuery("#"+t3.month1+"_"+i+"span").text(tmp_arr[2]);
						jQuery("#"+t3.month2+"_"+i).val(tmp_arr[3]);							
						jQuery("#"+t3.month2+"_"+i+"span").text(tmp_arr[3]);		
						jQuery("#"+t3.sum+"_"+i).val(tmp_arr[4]);							
						jQuery("#"+t3.sum+"_"+i+"span").text(tmp_arr[4]);								
					}
				}	
			}
		}
		xhr.send(null);			
	}
	
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
var t0 = {
    _index: 0,
    lcmc: 'field109244' /**流程名称-varchar2(4000)**/ ,
    lcbh: 'field109245' /**流程编号-varchar2(100)**/ ,
    sqr: 'field109246' /**申请人-integer**/ ,
    sqbm: 'field109247' /**申请部门-integer**/ ,
    sqrq: 'field109248' /**申请日期-char(10)**/ ,
    gs: 'field109249' /**公司-integer**/ ,
    year: 'field109250' /**年度-integer**/ ,
    llyyz: 'field109251' /**流程拥有者-integer**/ ,
    lllxr: 'field109252' /**流程联系人-integer**/ ,
    month: 'field109253' /**月份-integer**/ ,
    zjjhlb: 'field109254' /**资金计划类别-integer**/ ,
    lcid: 'field109270' /**流程id-browser.workflowID**/
};
var t1 = {
    _index: 1,
    type: 'field109255' /**资金支出明细-integer**/ ,
    month: 'field109256' /**开始月-number(15,2)**/ ,
    month1: 'field109257' /**中间月-number(15,2)**/ ,
    month2: 'field109258' /**结束月-number(15,2)**/ ,
    sum: 'field109259' /**合计-number(15,2)**/
};
var t2 = {
    _index: 2,
    type: 'field109260' /**受限资金明细-integer**/ ,
    month: 'field109261' /**开始月-number(15,2)**/ ,
    month1: 'field109262' /**中间月-number(15,2)**/ ,
    month2: 'field109263' /**结束月-number(15,2)**/ ,
    sum: 'field109264' /**合计-number(15,2)**/
};
var t3 = {
    _index: 3,
    type: 'field109265' /**资金收入明细-integer**/ ,
    month: 'field109266' /**开始月-number(15,2)**/ ,
    month1: 'field109267' /**中间月-number(15,2)**/ ,
    month2: 'field109268' /**结束月-number(15,2)**/ ,
    sum: 'field109269' /**合计-number(15,2)**/
};
</script>
