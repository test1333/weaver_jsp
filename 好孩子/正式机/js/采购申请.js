<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
var cgzl = '#field13625';// �ɹ�����
var wlmc = '#field13670_';// ��������
var cgdl = "#field13671";//�ɹ�����
var fykm = "field14319";//���ÿ�Ŀ
var xglc = "#field13676";//�������
jQuery(document).ready(function () {
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
				alert("Ͷ����ɹ�����������������̣��̶��ʲ����뵥���̣�");
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








