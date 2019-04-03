<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var gc="#field34764";//工厂
   
    var gc_dt1="#field36608_";//明细1-工厂
	var xm_dt1="#field34666_";//明细1-项目
	var wlbh_dt1="#field34669_";//明细1-物料编号
	var cgsl_dt1="#field34699_";//明细1-采购数量
	
	var xmid_dt2="#field43287_";//明细2-项目OAID
	var zjxm_dt2="#field43288_";//明细2-组件项目
	var zjwlh_dt2="#field43289_";//明细2-组件物料号
	var zjwlms_dt2="#field43290_";//明细2-组件物料描述
	var xqsl_dt2="#field43291_";//明细2-需求数量
	var zjdw_dt2="#field43307_";//明细2-组件单位
	
    jQuery(document).ready(function(){
	  jQuery("button[name=addbutton0]").live("click", function () {
	  	   dodetail();
		  var indexnum0 =jQuery("#indexnum0").val()-1;
		  bindchange(indexnum0);
	  });
	  jQuery("button[name=delbutton0]").live("click", function () {
	  	  getBomData();
	  });
	   jQuery("button[name=addbutton1]").live("click", function () {
		    var indexnum1 =jQuery("#indexnum1").val()-1;
	  	   bindchange2(indexnum1);
	  });
	  
	  dodetailonLoad();
	});

 function dodetailonLoad(){
	  var indexnum0 =jQuery("#indexnum0").val();
	  for( var index=0;index<indexnum0;index++){
		if(     jQuery(gc_dt1+index).length>0){
			bindchange(index);
		}
	  }
	   var indexnum1 =jQuery("#indexnum1").val();
	   for( var index=0;index<indexnum1;index++){
		if( jQuery(zjxm_dt2+index).length>0){
			bindchange2(index);
		}
	  }
 }
  function dodetail(){
   	      var indexnum0 =jQuery("#indexnum0").val();
   	      var gc_val=jQuery(gc).val();
   	      for( var index=0;index<indexnum0;index++){
			  if(     jQuery(gc_dt1+index).length>0){
				var gc_dt1_val=jQuery(gc_dt1+index).val();
				if(gc_dt1_val==""){
					jQuery(gc_dt1+index).val(gc_val);
					jQuery(gc_dt1+index+"span").text(gc_val);
				}
				var xm_dt1_val=accAdd(accMul(10,index),10);
				jQuery(xm_dt1+index).val(xm_dt1_val);
				jQuery(xm_dt1+index+"span").text(xm_dt1_val);
				
				 
			  }
   	      }
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
			if( jQuery(gc_dt1+index).length>0){
				var xm_dt1_val=jQuery(xm_dt1+index).val();
				if(xm_dt1_val == xmid_dt2_val ){
					return true;
				}
				
			}
		}
	  return false;
  }
   
  function bindchange(index){
	 jQuery(wlbh_dt1+index).bindPropertyChange(function (){
		 getBomData();
	 });
	 jQuery(gc_dt1+index).bindPropertyChange(function (){
		 getBomData();
	 });
	 jQuery(cgsl_dt1+index).bind('change',function (){
		 getBomData();
	 });
  
  }
  
  function getBomData(){
	   var nodesnum1 = jQuery("#nodesnum1").val();
	   if(nodesnum1 >0){
            jQuery("[name = check_node_1]:checkbox").attr("checked", true);
            adddelid(1,xmid_dt2);
            removeRow0(1);
       }
	    var indexnum0 =jQuery("#indexnum0").val();
		for( var index=0;index<indexnum0;index++){
			 var wlbh_dt1_val=jQuery(wlbh_dt1+index).val();
			 var gc_dt1_val=jQuery(gc_dt1+index).val();
			 var cgsl_dt1_val=jQuery(cgsl_dt1+index).val();
			 var xm_dt1_val =jQuery(xm_dt1+index).val();
			 if(wlbh_dt1_val !="" && gc_dt1_val !="" && cgsl_dt1_val !=""){
				getDetail2Data(wlbh_dt1_val,gc_dt1_val,cgsl_dt1_val,xm_dt1_val);
	         } 
			 
	    }
	 
	  
	  
  }
  //调用后台代码获取bom数据插入明细表2
  function getDetail2Data(wlbh,gc,cgsl,xm){
	  //alert("22");
	  var indexnum1=  jQuery("#indexnum1").val();
     var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
  	   	   	xhr.open("GET","/gvo/displaycenter/get-bom-data.jsp?I_MATNR="+wlbh+"&I_MENGE="+cgsl+"&I_WERKS="+gc, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		var text = xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum1);
		var zjxm_dt2_val=0;
		for(var i=indexnum1;i<length1;i++){
		  addRow1(1);
		  zjxm_dt2_val=accAdd(zjxm_dt2_val,10);
		  var tmp_arr = text_arr[i-indexnum1].split("###");
		  jQuery(xmid_dt2+i).val(xm);
		  jQuery(xmid_dt2+i).attr("readonly", "readonly");
		  jQuery(xmid_dt2+i+"span").html("");
		  jQuery(zjxm_dt2+i).val(zjxm_dt2_val);
		  jQuery(zjxm_dt2+i+"span").text(zjxm_dt2_val);
		  jQuery(zjwlh_dt2+i).val(tmp_arr[0]);
		  jQuery(zjwlh_dt2+i+"span").text(tmp_arr[0]);
		   if(tmp_arr[0] !=""){
			    jQuery(zjwlh_dt2+i+"spanimg").html("");
		   }
		   jQuery(zjwlh_dt2+i+"_browserbtn").attr('disabled',true);	
		  jQuery(zjwlms_dt2+i).val(tmp_arr[1]);
		  jQuery(zjwlms_dt2+i+"span").text(tmp_arr[1]);
		  jQuery(xqsl_dt2+i).val(tmp_arr[2]);
		   if(tmp_arr[2] !=""){
			    jQuery(xqsl_dt2+i+"span").html("");
		   }
		  jQuery(zjdw_dt2+i).val(tmp_arr[3]);
		  jQuery(zjdw_dt2+i+"span").text(tmp_arr[3]);
		
		  
	     }
          }
	  }
	 }
       xhr.send(null);
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









