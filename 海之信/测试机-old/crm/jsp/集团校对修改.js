<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var lx = "#field13073";
	var jt = "#field13072";
    jQuery(document).ready(function () {
		jQuery(lx).bindPropertyChange(function (){ 
            jQuery(jt).val("");
			jQuery(jt+"span").text("");
		})
	});	
</script>
