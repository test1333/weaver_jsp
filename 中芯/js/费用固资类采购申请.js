<script type="text/javascript">
var num_main="#field7042";//主表加个字段记录当前的序号
var oaid_dt2="#field7043_";//明细序号字段
var sfwtgl = "#field7054";//是否为统管类
var cgxmmsxz_dt2 = "field7082_";//采购项目描述选择
var cgxmmsst_dt2 = "field7026_";//采购项目描述手填
jQuery(document).ready(function(){
	jQuery("button[name=addbutton1]").live("click", function () {
		var indexnum00 = jQuery("#indexnum1").val();
		var num_main_val = jQuery(num_main).val();
		if(num_main_val==""){
		   num_main_val=1;	 
		}else{
		   num_main_val=Number(num_main_val)+1;
		}
		var index00= indexnum00-1;
		jQuery(oaid_dt2+index00).val(num_main_val);
		jQuery(num_main).val(num_main_val);
		showhide();
		addremoveCheck();
    });	
	showhide();
	addremoveCheck();
	jQuery(sfwtgl).bind("change",function(){
		showhide();
		addremoveCheck();
	})
	
	   	   
})

function showhide(){
	var sfwtgl_val = jQuery(sfwtgl).val();
	if(sfwtgl_val == "0"){
		jQuery(".cgxmmsxz").show();
        jQuery(".cgxmmsst").hide();
	}
	
	if(sfwtgl_val == "1"){
		jQuery(".cgxmmsxz").hide();
        jQuery(".cgxmmsst").show();
	}
	
	
}

function addremoveCheck(){
	var sfwtgl_val = jQuery(sfwtgl).val();
	if(sfwtgl_val == "0"){
		var indexnum1 = jQuery("#indexnum1").val();
		for(var index = 0;index < indexnum1;index++){
			if(jQuery("#"+cgxmmsxz_dt2+index).length>0){
				var btid = cgxmmsxz_dt2+index;
				var btid2 = cgxmmsst_dt2+index;
				addcheck(btid,'1');
				removecheck(btid2,'0');
				
			}
		}
	}
	if(sfwtgl_val == "1"){
		var indexnum1 = jQuery("#indexnum1").val();
		for(var index = 0;index < indexnum1;index++){
			if(jQuery("#"+cgxmmsxz_dt2+index).length>0){
				var btid = cgxmmsxz_dt2+index;
				var btid2 = cgxmmsst_dt2+index;
				addcheck(btid2,'0');
				removecheck(btid,'1');
				
			}
		}
		
	}
	
}

function addcheck(btid,flag){
    var btid_val = jQuery("#"+btid).val();
    var btid_check=btid;
    if(btid_val==''){
		if(flag=='0'){
			jQuery("#"+btid+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
			
		}else{
			jQuery("#"+btid+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}       

    }
	if(flag=='0'){
		jQuery("#"+btid).attr("viewtype","1");
	}
    var needcheck = document.all("needcheck");
    if(needcheck.value.indexOf(","+btid_check)<0){
		if(needcheck.value!='') needcheck.value+=",";
            needcheck.value+=btid_check;
    }
  }
  function removecheck(btid,flag){
    if(flag=='0'){
        jQuery("#"+btid+"span").html("");
		jQuery("#"+btid).attr("viewtype","0");
    }else{
        jQuery("#"+btid+"spanimg").html("");
    }
    var parastr = document.all('needcheck').value;
    parastr = parastr.replace(","+btid,"");
    document.all('needcheck').value=parastr;
  }


</script>













