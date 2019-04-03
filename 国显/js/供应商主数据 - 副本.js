<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">

var workType="#field34097";//工作类型
var note="#field33994";//文本备注
var noteId="field33994";//文本备注Id
var type_old="";

var suppCode="#field35068";//供应商代码
var codeId="field35068";//供应商代码Id
var supplier="#outfield35068div";
var supplierbtn="#field35068_browserbtn";
var compId="field34142span";//供应商代码Id

jQuery(document).ready(function(){
	var type_val = jQuery(workType).val();
		
	 //alert("type_val="+type_val);	
	jQuery(workType).bindPropertyChange(function (){
		var type_val = jQuery(workType).val();

		 if(type_old==''){
                type_old = type_val; 
              }else{
               jQuery(workType).val(type_old);
               jQuery(workType+"span").text(type_old);	  
            }
		
		if(type_val=='1'){					
						
	        hideCode();	
	        hideType();
	        mustNote(type_val);
	        mustOrgin(type_val);
	        mustCompany();			
			jQuery("#jdfield015").hide();
			jQuery("#jdfield016").hide();
			jQuery("#jdfield017").hide();
			jQuery("#jdfield018").hide();
			jQuery("#jdfield019").hide();
			jQuery("#jdfield020").hide();
						
		}else if(type_val=='2'){

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
			
			showCode();	
			hideType();
			//hideCompany();	
			mustCode(type_val);	
			cancelSuppType();
			disabledAll();
			
			jQuery("#jdfield015").hide();
			jQuery("#jdfield016").hide();
			jQuery("#jdfield017").hide();
			jQuery("#jdfield018").show();
			jQuery("#jdfield019").show();
			jQuery("#jdfield020").show();
			
		}else if(type_val=='5'){
			
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
			
		
	});
		
		
		
});

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
		jQuery("#field34246_browserbtn").attr('disabled',true);
		jQuery("#field34248_browserbtn").attr('disabled',true);
		jQuery("#field34250_browserbtn").attr('disabled',true);


	}


	
</script>	






