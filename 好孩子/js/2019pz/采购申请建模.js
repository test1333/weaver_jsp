<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">

var yckz = '#field14990';
var cgzl = '#field14710';// 采购种类
var wlmc = '#field14756_';// 物料名称
var cgdl = "#field14983";//采购大类
var fykm = "field16236";//费用科目
var xglc = "#field14984";//相关流程
jQuery(document).ready(function () {
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
		if(cgdl_val == '3'){
			var xglc_val = jQuery(xglc).val();
			if(xglc_val == ""){
				alert("投资类采购申请必须关联相关流程（固定资产申请单流程）");
				return false;
			}
		}
		return true;
		
		
	}
});

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





