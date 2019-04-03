<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src = "/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	var dj = "#field14075_";
	var shsl = "#field14069_";
	var je = "#field13911_";
	var indexnums = jQuery("#indexnum0").val();
	for(var i=0;i<indexnums;i++){
		if(jQuery(dj+i).length>0){
			var dj_val = jQuery(dj+i).val();			
			var shsl_val = jQuery(shsl+i).val();
			var jesum = Math.round(Number(dj_val)*Number(shsl_val)*100)/100;
			//alert(jesum);
			jQuery(je+i).val(jesum);
			jQuery(je+i+"span").text(jesum);
		}
	}	
})
</script>














