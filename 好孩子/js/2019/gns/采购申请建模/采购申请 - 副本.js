<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cgzl = '#field13625';// 采购种类
var wlmc = '#field13670_';// 物料名称
var cgdl = "#field13671";//采购大类
var fykm = "field14319";//费用科目
var xglc = "#field13676";//相关流程
var wlmctj = "#field15265"; //物料名称
var wlmctj_id = "#field15267_"; //物料名称id
//主表多选物料名称自动添加明细


function matteradd(checkids){
    var indexnum0=jQuery("#indexnum0").val();
    
    var text_arr = checkids.split(",");
    for(var index=0;index<text_arr.length;index++){
        //alert(text_arr[index]);
        addRow0(0);
        var temp_num=Number(indexnum0)+index;
        jQuery(wlmctj_id+temp_num).val(text_arr[index]);
        jQuery(wlmctj_id+temp_num).trigger("change");
    }
}


jQuery(document).ready(function () {
	jQuery("#xzwl").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='选择物料' onclick='showxx()'>");
    var yckz = '#field13677';
    jQuery('#yu').hide();
    jQuery('#yu1').hide();
    jQuery('#yu2').hide();
    jQuery(yckz).bind('change', function () {
        var yckz_val = jQuery(yckz + ' option:selected').val();
        // alert(yckz_val);
        if (yckz_val == '0') {
            jQuery('#yu').show();
            jQuery('#yu1').show();
            jQuery('#yu2').show();
        }else {
            jQuery('#yu').hide();
            jQuery('#yu1').hide();
            jQuery('#yu2').hide();
        }
    });
	jQuery(cgzl).bindPropertyChange(function () {
        var indexnum0 = jQuery('#indexnum0').val();
        for (var i = 0; i < indexnum0; i++) {
            if (jQuery(wlmc + i).length > 0) {
                jQuery(wlmc + i).val('');
                jQuery(wlmc + i + 'span').text('');
            }
        }
    });
	changekm();
	jQuery(cgdl).bindPropertyChange(function () {
        changekm();
    });
	checkCustomize = function (){
		var cgdl_val = jQuery(cgdl).val();
		if(cgdl_val == '1'){
			var xglc_val = jQuery(xglc).val();
			if(xglc_val == ""){
				alert("投资类采购申请必须关联相关流程（固定资产申请单流程）");
				return false;
			}
		}
		return true;
		
		
	}
});
function getwlids(){
	var wlids = "";
	var flag = "";
	var indexnum0 = jQuery('#indexnum0').val();
    for (var i = 0; i < indexnum0; i++) {
        if (jQuery(wlmc + i).length > 0) {
            var wlmcid=jQuery(wlmc + i).val();
			if(wlmcid != ""){
				wlids = wlids + flag +wlmcid;
				flag=","				   
			}
               
        }
    }
	return wlids;
}
function showxx() {  
	var wlids = getwlids();
	var cgzl_val = jQuery(cgzl).val();
	if(cgzl_val == ""){
		alert("请先选择采购类型");
		return;
	}
	var title = "";
	var url = "/goodbaby/gb2019/cgsq/show-cgwljgk-info-url.jsp?wlids="+wlids+"&wllx="+cgzl_val;
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
	setTimeout("matteradd('"+checkids+"')",300);
}
function changekm(){
	var cgdl_val = jQuery(cgdl).val();
	if(cgdl_val == "2"){
		jQuery("#"+fykm+"_browserbtn").attr('disabled',true);
		jQuery("#"+fykm).val("");
		jQuery("#"+fykm+"span").html("");
		removecheck(fykm,"1");
	}else{
		jQuery("#"+fykm+"_browserbtn").removeAttr('disabled');
		addcheck(fykm,"1");
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
