<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cgsqdh="#field35035";
var xghcgsl_dt="#field35042_";//修改后采购数量
var yzccgddsl_dt="#field35043_";//已转成采购订单数量
var ycgsl_dt="#field35041_";//原采购数量
var xghygdj_dt="#field35046_";//修改后预估单价
var yygdj_dt="#field35045_";//预估单价
var ywlms_dt="#field35040_";//原物料描述
var xghwlms_dt="#field36686_";//修改后物料描述
var wlbh_dt="#field35039_";//物料编号

var itemnos="#field43408";//项目号
var sqdh="#field36621";//申请单号
var xm_dt1="#field35038_";//明细1-项目
var xmid_dt2="#field43391_";//明细2-项目OAID
var zjxm_dt2="#field43392_";//明细2-组件项目
var zjwlh_dt2="#field43393_";//明细2-组件物料号
var zjwlms_dt2="#field43394_";//明细2-组件物料描述
var xqsl_dt2="#field43395_";//明细2-需求数量
var zjdw_dt2="#field43396_";//明细2-组件单位
 jQuery(document).ready(function(){
 	 //alert("10");
	 jQuery("button[name=addbutton1]").live("click", function () {
		    var indexnum1 =jQuery("#indexnum1").val()-1;
	  	   bindchange2(indexnum1);
	  });
	 
	 
 	 jQuery("button[name=addbutton0]").css('display','none');
 	 var nodesnum0 = jQuery("#nodesnum0").val();
 	  if(Number(nodesnum0)>0){
 	    	  jQuery(cgsqdh+"_browserbtn").attr('disabled',true);
 	    	}
 	 jQuery("#nodesnum0").bindPropertyChange(function () {
 	 	 var nodesnum00= jQuery("#nodesnum0").val();
 	 	  if(Number(nodesnum00)>0){
 	    	  jQuery(cgsqdh+"_browserbtn").attr('disabled',true);
 	    	 setTimeout('checkoutnum()',1000);
 	    	}else{
 	        jQuery(cgsqdh+"_browserbtn").attr('disabled',false);		
 	     }
		  setTimeout('getDetail2()',1000);
 	 })	 
 	 	 checkCustomize = function () {
 	 	var indexnum0 = jQuery("#indexnum0").val();
 	 	 for(var index=0;index<indexnum0;index++){
 	  	 if (jQuery(xghcgsl_dt + index).length > 0) {
                var xghcgsl_dt_val=jQuery(xghcgsl_dt + index).val();
                var yzccgddsl_dt_val=jQuery(yzccgddsl_dt + index).val();
                  var ycgsl_dt_val=jQuery(ycgsl_dt + index).val();
                  if(xghcgsl_dt_val == ''){
                  	  jQuery(xghcgsl_dt + index).val(ycgsl_dt_val);
                  }
                   var xghygdj_dt_val=jQuery(xghygdj_dt + index).val();
                    var yygdj_dt_val=jQuery(yygdj_dt + index).val();
                     if(xghygdj_dt_val == ''){
                  	  jQuery(xghygdj_dt + index).val(yygdj_dt_val);
                  }
                  
                  var ywlms_dt_val=jQuery(ywlms_dt + index).val();
                    var xghwlms_dt_val=jQuery(xghwlms_dt+ index).val();
                     if(xghwlms_dt_val == ''){
                  	  jQuery(xghwlms_dt + index).val(ywlms_dt_val);
                  }
                if(Number(xghcgsl_dt_val)<Number(yzccgddsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量小于已转成采购订单数量，请检查。");
                     return false;
                }
                 if(Number(ycgsl_dt_val)<Number(xghcgsl_dt_val)){
                	  window.top.Dialog.alert("存在修改后数量大于已原采购数量，请检查。");
                     return false;
                }
            }	 
         }
         return true;
       }	 
 setTimeout('checkoutnum()',300);
  dodetailonLoad();

	 
 });
  function dodetailonLoad(){
	  
	   var indexnum1 =jQuery("#indexnum1").val();
	   for( var index=0;index<indexnum1;index++){
		if( jQuery(zjxm_dt2+index).length>0){
			bindchange2(index);
		}
	  }
 }
   function getDetail2(){
	   
	   var nodesnum1 = jQuery("#nodesnum1").val();
	   if(nodesnum1 >0){
            jQuery("[name = check_node_1]:checkbox").attr("checked", true);
            adddelid(1,xmid_dt2);
            removeRow0(1);
       }
	   
	   var itemnos_val=getItemNO();
	   jQuery(itemnos).val(itemnos_val);
	   var sqdh_val = jQuery(sqdh).val();
	   if(itemnos_val !="" && sqdh_val != ""){
		   getDetail2Data(itemnos_val,sqdh_val);
		   
	   }
	  
   }
   
   function getDetail2Data(itemnos_val,I_BANFN){
	    var indexnum1=  jQuery("#indexnum1").val();
     var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
  	   	   	xhr.open("GET","/gvo/displaycenter/get-bom-data-update.jsp?I_BANFN="+I_BANFN+"&I_ITEMNOS="+itemnos_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		var text = xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum1);
		for(var i=indexnum1;i<length1;i++){
		  addRow1(1);
		  var tmp_arr = text_arr[i-indexnum1].split("###");
		  jQuery(xmid_dt2+i).val(tmp_arr[0]);
		  jQuery(xmid_dt2+i).attr("readonly", "readonly");
		  jQuery(zjxm_dt2+i).val(tmp_arr[1]);
		  jQuery(zjxm_dt2+i+"span").text(tmp_arr[1]);
		  
		  jQuery(zjwlh_dt2+i).val(tmp_arr[2]);
		  jQuery(zjwlh_dt2+i+"span").text(tmp_arr[2]);
		   if(tmp_arr[2] !=""){
			    jQuery(zjwlh_dt2+i+"spanimg").html("");
		   }
		   jQuery(zjwlh_dt2+i+"_browserbtn").attr('disabled',true);	
		  jQuery(zjwlms_dt2+i).val(tmp_arr[3]);
		  jQuery(zjwlms_dt2+i+"span").text(tmp_arr[3]);
		  jQuery(xqsl_dt2+i).val(tmp_arr[4]);
		   if(tmp_arr[4] !=""){
			    jQuery(xqsl_dt2+i+"span").html("");
		   }
		  jQuery(zjdw_dt2+i).val(tmp_arr[5]);
		  jQuery(zjdw_dt2+i+"span").text(tmp_arr[5]);
		
		  
	     }
          }
	  }
	 }
       xhr.send(null);
     }
	   
   }
   
   function getItemNO(){
	   var itemnos_val="";
	   var flag="";
	   var indexnum0 =jQuery("#indexnum0").val();
	    for( var index=0;index<indexnum0;index++){
			if( jQuery(xm_dt1+index).length>0){
				var xm_dt1_val=jQuery(xm_dt1+index).val().replace(/\b(0+)/gi,"");
				if(xm_dt1_val !=""){
					itemnos_val = itemnos_val+flag+xm_dt1_val;
					flag=",";
			    }
				
			}
		}
	   return itemnos_val;
   }
   function bindchange2(index){
	jQuery(xmid_dt2+index).bind('change',function (){
		 var xmid_dt2_val=jQuery(xmid_dt2+index).val();
		 if(xmid_dt2_val == ""){
			return; 
		 }
		 if(!checkexists(xmid_dt2_val)){
			 alert("所填写项目号不在明细表1中，请检查");
			 jQuery(xmid_dt2+index).val("");
		 }else{
			 var Nextzjxm=getNextzjxm(xmid_dt2_val,index)
			 jQuery(zjxm_dt2+index).val(Nextzjxm);
			 jQuery(zjxm_dt2+index+"span").text(Nextzjxm);
		 }
	});   
  }
  function getNextzjxm(xmid,indexsf){
	  var indexnum1 =jQuery("#indexnum1").val();
	  var maxnum="0";
	    for( var index=0;index<indexnum1;index++){
			if( jQuery(xmid_dt2+index).length>0){
				if(index==indexsf){
					continue;
				}
				 var xmid_dt2_val=jQuery(xmid_dt2+index).val();
				if(xmid == xmid_dt2_val ){
					var zjxm_dt2_val=jQuery(zjxm_dt2+index).val();
					if(zjxm_dt2_val == ""){
						zjxm_dt2_val = "0";						
				    }
					if(Number(zjxm_dt2_val)>Number(maxnum)){
						maxnum = zjxm_dt2_val;
					}
				}
				
			}
		}
		
	  return accAdd(maxnum,10);
  }
  
  function checkexists(xmid_dt2_val){
	   var indexnum0 =jQuery("#indexnum0").val();
	    for( var index=0;index<indexnum0;index++){
			if( jQuery(xm_dt1+index).length>0){
				var xm_dt1_val=jQuery(xm_dt1+index).val().replace(/\b(0+)/gi,"");
				if(xm_dt1_val == xmid_dt2_val ){
					return true;
				}
				
			}
		}
	  return false;
  }
  function checkoutnum(){
 	var indexnum0 = jQuery("#indexnum0").val();
 	 for(var index=0;index<indexnum0;index++){
 	   if (jQuery(yzccgddsl_dt+index).length > 0) {
                var yzccgddsl_dt_val=jQuery(yzccgddsl_dt + index).val();
                if(Number(yzccgddsl_dt_val)>Number(0)){
                     jQuery(xghygdj_dt+index).attr("readonly", "readonly");
                }
                var wlbh_dt_val=jQuery(wlbh_dt+index).val();
                if(wlbh_dt_val != ''){
                	jQuery(xghwlms_dt+index).attr("readonly", "readonly");
                }
            }	 
       }
 } 
 
 	
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
function accMul(arg1,arg2) 
{ 
	var m=0,s1=arg1.toString(),s2=arg2.toString(); 
	try{m+=s1.split(".")[1].length}catch(e){} 
	try{m+=s2.split(".")[1].length}catch(e){} 
	return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
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

