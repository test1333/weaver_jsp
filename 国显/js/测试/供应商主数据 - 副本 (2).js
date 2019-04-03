<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">

var workType="#field34097";//工作类型
var note="#field33994";//文本备注
var noteId="field33994";//文本备注Id
var type_old="";

var payId="#field34238";
var suppCode="#field35068";//供应商代码
var codeId="field35068";//供应商代码Id
var supplier="#outfield35068div";
var supplierbtn="#field35068_browserbtn";
var compId="field34142span";//供应商代码Id

var yhgjdm_dt1="#field34746_";//银行国家代码
var yhdm_dt1="#field34765_";//银行代码
var yhmc_dt1="#field34026_";//银行名称
var yhzh_dt1="#field34766_";//银行账户
var yhhz_dt1="#field34028_";//银行户主
jQuery(document).ready(function(){
	var type_val = jQuery(workType).val();
	showordisable(type_val);	
	 //alert("type_val="+type_val);	
	jQuery(suppCode).bindPropertyChange(function (){
		var workType_val = jQuery(workType).val();
		if(workType_val =="2"||workType_val =="3"){
			getBankDetailData();
		}
	});


	jQuery(workType).bindPropertyChange(function (){

		
		var type_val = jQuery(workType).val();

		 if(type_old==''){
                type_old = type_val; 
              }else{
               jQuery(workType).val(type_old);
               jQuery(workType+"span").text(type_old);	  
            }
		showordisable(type_val);
		if(type_val =="2"||type_val =="3"){
			getBankDetailData();
		}
		
		
	});
	
	jQuery(payId).bindPropertyChange(function (){

		var type_val = jQuery(workType).val();

		if(type_val=='1'){
			var pay_val = jQuery(payId).val();
			jQuery("#field34243span").text(pay_val);
		       jQuery("#field34243").val(pay_val);
		}
		
		//alert("payCode="+pay_val);
	});				
});
function getBankDetailData(){
	var suppCode_val = jQuery(suppCode).val();
	var nodesnum0 = jQuery("#nodesnum0").val();
	if(nodesnum0 >0){
	    jQuery("[name = check_node_0]:checkbox").attr("checked", true);
	    adddelid(0,yhgjdm_dt1);
	     removeRow0(0);
	}
	if(suppCode_val != "" ){
		//alert(suppCode_val);
		getSupplierBankAccount(suppCode_val);
	}
	
}
       function getSupplierBankAccount(suppCode_val){
   var indexnum0=  jQuery("#indexnum0").val();
     var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
  	   	   	xhr.open("GET","/gvo/sap/GetSupplierBankAccount.jsp?I_LIFNR="+suppCode_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		var text = xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum0);
		for(var i=indexnum0;i<length1;i++){
		  addRow0(0);
		  var tmp_arr = text_arr[i-indexnum0].split("###");
		  jQuery(yhgjdm_dt1+i).val(tmp_arr[2]);
		   jQuery(yhgjdm_dt1+i+"span").text(tmp_arr[2]);
		   if(tmp_arr[2] !=""){
			    jQuery(yhgjdm_dt1+i+"spanimg").html("");
		   }
		  jQuery(yhdm_dt1+i).val(tmp_arr[1]);
		   jQuery(yhdm_dt1+i+"span").text(tmp_arr[1]);
		   if(tmp_arr[1] !=""){
			    jQuery(yhdm_dt1+i+"spanimg").html("");
		   }
		  jQuery(yhmc_dt1+i).val(tmp_arr[3]);
		  jQuery(yhzh_dt1+i).val(tmp_arr[0]);
		   if(tmp_arr[0] !=""){
			    jQuery(yhzh_dt1+i+"span").html("");
		   }
		  jQuery(yhhz_dt1+i).val(tmp_arr[4]);
		   if(tmp_arr[4] !=""){
			    jQuery(yhhz_dt1+i+"span").html("");
		   }
		  
	     }
          }
	  }
	 }
       xhr.send(null);
     }
} 
       function showordisable(type_val){
       	   	if(type_val=='1'){					
				
		jQuery("button[name=sapmulbutton0]").css('display','none');			
	        hideCode();	
	        hideType();
	        mustNote(type_val);
	        mustOrgin(type_val);
	        mustCompany();
			mustPayWay();
//			mustSupplier();
	mustTaxy();
			jQuery("#jdfield015").hide();
			jQuery("#jdfield016").hide();
			jQuery("#jdfield017").hide();
			jQuery("#jdfield018").hide();
			jQuery("#jdfield019").hide();
			jQuery("#jdfield020").hide();			
		}else if(type_val=='2'){

		 	jQuery("button[name=sapmulbutton0]").css('display','');	
			hideType();
			showCode();			
			mustCode(type_val);	
			cancelSuppType();				
			jQuery("#jdfield015").hide();
			jQuery("#jdfield016").hide();
			jQuery("#jdfield017").hide();
			jQuery("#jdfield018").hide();
			jQuery("#jdfield019").hide();
			jQuery("#jdfield020").hide();
		}else if(type_val=='3'){
			
				jQuery("button[name=sapmulbutton0]").css('display','');
			showCode();
			hideType();
			mustCode(type_val);
			cancelSuppType();	
			jQuery("#jdfield015").hide();
			jQuery("#jdfield016").hide();
			jQuery("#jdfield017").hide();
			jQuery("#jdfield018").hide();
			jQuery("#jdfield019").hide();
			jQuery("#jdfield020").hide();	
		}else if(type_val=='4'){
				jQuery("button[name=sapmulbutton0]").css('display','');	
			showCode();	
			hideType();
			//hideCompany();	
			mustCode(type_val);	
			mustReason();
			cancelSuppType();
			noneRemind();
			disabledAll();
			
			jQuery("#jdfield015").hide();
			jQuery("#jdfield016").hide();
			jQuery("#jdfield017").hide();
			jQuery("#jdfield018").show();
			jQuery("#jdfield019").show();
			jQuery("#jdfield020").show();
			
		}else if(type_val=='5'){
				jQuery("button[name=sapmulbutton0]").css('display','');
			showCode();
			hideType();
			//hideCompany();
			mustCode(type_val);
			cancelSuppType();
			disabledAll();
			
			jQuery("#jdfield015").show();
			jQuery("#jdfield016").show();
			jQuery("#jdfield017").show();
			jQuery("#jdfield018").hide();
			jQuery("#jdfield019").hide();
			jQuery("#jdfield020").hide();
			
		}
      }

     //冻结其一必填
  function noneRemind(){

     	 //var freeson_val = jQuery("#field34695").val();

 	 	  checkCustomize = function () {
            	var freeze_val1 = jQuery("#field35564").val();
 	 			var freeze_val2 = jQuery("#field35565").val();
 	 			var freeze_val3 = jQuery("#field35566").val();
 	 			var freeze_val4 = jQuery("#field35567").val();


            	if((freeze_val1=="")&&(freeze_val2=="")&&(freeze_val3=="")&&(freeze_val4=="")){

 	 				alert("冻结数据前四选项必须填选一项");

 	 				return false;
 					}

                return true;
			}

				
     }
    //文本备注必填
	function mustNote(type_val){
		var type_val = jQuery(workType).val();
		var note_val = jQuery(note).val();
		
		if(note_val==""){
			jQuery(note+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}
		var needcheck = document.all("needcheck");//设置必填
        if(needcheck.value.indexOf(","+noteId)<0){
            if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+=noteId;
        }
			
	}

	function mustCode(type_val){
		var type_val = jQuery(workType).val();
		var code_val = jQuery(suppCode).val();
		
		if(code_val==""){
			jQuery(suppCode+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}
		var needcheck = document.all("needcheck");//设置必填
        if(needcheck.value.indexOf(","+codeId)<0){
            if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+=codeId;
        }
			
	}
	//公司代码必填
	function mustCompany(){
		
		var comp_val = jQuery("#field34142").val();
		
		if(comp_val==""){
			jQuery("#field34142spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}
		var needcheck = document.all("needcheck");//设置必填
        if(needcheck.value.indexOf(","+"field34142")<0){
            if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+="field34142";
        }
			
	}

	//工作类型不可编辑
	function hideType(){
		//jQuery("#field34097span").attr('disabled',true);	   			
		//jQuery("#field34097_browserbtn").hide();
		jQuery("#outfield34097div").attr('disabled',true);
		jQuery("#field34097_browserbtn").attr('disabled',true);//按钮

	}
	
	//显示供应商代码
	function showCode(){
		jQuery(supplier).attr('disabled',false);	   			
		jQuery(supplierbtn).attr('disabled',false);
		
	}
	//隐藏供应商代码
	function hideCode(){
		jQuery(supplier).attr('disabled',true);
		jQuery(supplierbtn).attr('disabled',true);//按钮	   			
		//jQuery(supplierbtn).hide();

	}
	//公司代码不可填
	function hideCompany(){
		jQuery("#outfield34142div").attr('disabled',true);
		jQuery("#field34142_browserbtn").attr('disabled',true);//按钮	   			
		//jQuery(supplierbtn).hide();

	}


	//取消组织代码必填
	function cancelOrg(){

			jQuery("#field34143spanimg").html("");
			jQuery("#field34143").attr("readonly", "readonly");
			
	}

	function mustOrgin(type_val){
		var type_val = jQuery(workType).val();
		var orgin_val = jQuery("#field34143").val();
		
		if(orgin_val==""){
			jQuery("#field34143spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}
		var needcheck = document.all("needcheck");//设置必填
        if(needcheck.value.indexOf(","+"field34143")<0){
            if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+="field34143";
        }
			
	}

//付款方式必填
	function mustPayWay(){
		
		var pay_val = jQuery("#field34239").val();
		
		if(pay_val==""){
			jQuery("#field34239spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}
		var needcheck = document.all("needcheck");//设置必填
        if(needcheck.value.indexOf(","+"field34239")<0){
            if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+="field34239";
        }
			
	}
//采购组必填
//	function mustSupplier(){
//		var supp_val = jQuery("#field34246").val();		
//		if(supp_val==""){
//			jQuery("#field34246spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
//		}
//		var needcheck = document.all("needcheck");//设置必填
//        if(needcheck.value.indexOf(","+"field34246")<0){
//            if(needcheck.value!='') needcheck.value+=",";
//            needcheck.value+="field34246";
//        }		
//	}
	//冻结原因必填
	function mustReason(){
		
		var freeson_val = jQuery("#field34695").val();
		
		if(freeson_val==""){
			jQuery("#field34695spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}
		var needcheck = document.all("needcheck");//设置必填
        if(needcheck.value.indexOf(","+"field34695")<0){
            if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+="field34695";
        }
			
	}
//增值税必填
	function mustTaxy(){
		
		var freeson_val = jQuery("#field34023").val();
		
		if(freeson_val==""){
			jQuery("#field34023span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}
		var needcheck = document.all("needcheck");//设置必填
        if(needcheck.value.indexOf(","+"field34023")<0){
            if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+="field34023";
        }
			
	}

	
	//供应商不可编辑
	function cancelSuppType(){
		jQuery("#"+"field34145span").html("");
		var parastr = document.all('needcheck').value;//取消必填
		parastr = parastr.replace(","+"field34145","");
		document.all('needcheck').value=parastr;
		document.getElementById("field34145").disabled = true;
	}
	//所有基本不可编辑
	function disabledAll(){
		jQuery("#field35122_browserbtn").attr('disabled',true);//按钮
		jQuery("#field34143_browserbtn").attr('disabled',true);
		jQuery("#field34108_browserbtn").attr('disabled',true);
		jQuery("#field34013").attr("readonly", "readonly");//文本
		jQuery("#field34265_browserbtn").attr('disabled',true);

		jQuery("#field34013").attr("readonly", "readonly");//文本
		jQuery("#field34012").attr("readonly", "readonly");//文本
		jQuery("#field34015").attr("readonly", "readonly");
		jQuery("#field34014").attr("readonly", "readonly");
		jQuery("#field34016").attr("readonly", "readonly");
		jQuery("#field34023").attr("readonly", "readonly");
		jQuery("#field34019").attr("readonly", "readonly");		
		jQuery("#field34020").attr("readonly", "readonly");
		jQuery("#field34021").attr("readonly", "readonly");
		jQuery("#field34022").attr("readonly", "readonly");
		jQuery("#field34241").attr("readonly", "readonly");

		jQuery("#field34237_browserbtn").attr('disabled',true);
		jQuery("#field34238_browserbtn").attr('disabled',true);
		jQuery("#field34239_browserbtn").attr('disabled',true);
		jQuery("#field35086_browserbtn").attr('disabled',true);
		jQuery("#field34786_browserbtn").attr('disabled',true);
		//采购组织数据
		jQuery("#field34244").attr("readonly", "readonly");
		jQuery("#field34245").attr("readonly", "readonly");
		jQuery("#field34847").attr("readonly", "readonly");
		jQuery("#field34247").attr("readonly", "readonly");
		jQuery("#field34249").attr("readonly", "readonly");
		jQuery("#field34251").attr("readonly", "readonly");

		jQuery("#field34875_browserbtn").attr('disabled',true);
		jQuery("#field34243_browserbtn").attr('disabled',true);
//		jQuery("#field34246_browserbtn").attr('disabled',true);
		jQuery("#field34248_browserbtn").attr('disabled',true);
		jQuery("#field34250_browserbtn").attr('disabled',true);

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

