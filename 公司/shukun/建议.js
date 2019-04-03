<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var cnqk = "#field7360";//采纳情况
var cnrq = "#field7365";//采纳日期
var cnsm = "#field7367";//采纳说明
var zxqk = "#field7362";//执行情况
var zxrq = "#field7366";//执行日期
var zxsm = "#field7364";//执行说明
var bjlx = "#field7372";//编辑类型
jQuery(document).ready(function () {
	var bjlx_val = jQuery(bjlx).val();
	if(bjlx_val == "0"){
		jQuery(zxqk).attr("disabled",'disabled');
		jQuery(zxrq+"browser").attr('disabled',true);
		jQuery(zxsm).attr("readonly", "readonly");
		
	}
	if(bjlx_val == "1"){
		jQuery(cnqk).attr("disabled",'disabled');
		jQuery(cnrq+"browser").attr('disabled',true);
		jQuery(cnsm).attr("readonly", "readonly");
		
	}
})
</script>
