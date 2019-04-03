<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var xc="#field31643";//项次
var zz="#field31644";//纸种
var kzc="#field31675";//克重从
var kzd="#field31676";//克重到
var pp="#field31646";//品牌
var yf="#field31647";//月返
var jf="#field31648";//季返
var xc_dt1="#field31650_";//项次 明细1
var zz_dt1="#field31651_";//纸种 明细1
var pp_dt1="#field31652_";//品牌 明细1
var kzc_dt1="#field31653_";//克重从
var kzd_dt1="#field31654_";//克重到
var yf_dt1="#field31660_";//月返
var jf_dt1="#field31659_";//季返

jQuery(document).ready(function () {
	var xc_val=jQuery(xc).val();
	var zz_val=jQuery(zz).val();
	var kzc_val=jQuery(kzc).val();
	var kzd_val=jQuery(kzd).val();
	var pp_val=jQuery(pp).val();
	var yf_val=jQuery(yf).val();
	var jf_val=jQuery(jf).val();
	
	 jQuery("button[name=addbutton0]").live("click", function () {
			var index = jQuery("#indexnum0").val()-1;
			jQuery(xc_dt1+index).val(xc_val);
			jQuery(xc_dt1+index+"span").text(xc_val);
			jQuery(zz_dt1+index).val(zz_val);
			jQuery(pp_dt1+index).val(pp_val);
			jQuery(kzc_dt1+index).val(kzc_val);
			jQuery(kzd_dt1+index).val(kzd_val);
			jQuery(yf_dt1+index).val(yf_val);
			jQuery(jf_dt1+index).val(jf_val);
		});
})
</script>
