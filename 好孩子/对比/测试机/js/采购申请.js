<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">

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
});
jQuery(document).ready(function () {
    var cgzl = '#field13625';// 采购种类
    var wlmc = '#field13670_';// 物料名称

    jQuery('#field13625').bindPropertyChange(function () {
        var indexnum0 = jQuery('#indexnum0').val();
        for (var i = 0; i < indexnum0; i++) {
            if (jQuery(wlmc + i).length > 0) {
                jQuery(wlmc + i).val('');
                jQuery(wlmc + i + 'span').text('');
            }
        }
    });
});


</script>








