<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var xjhksrq = "#field21853";//新计划开始日期
var xjhwcrq = "#field21854";//新计划完成日期
jQuery(document).ready(function(){
	changerqdata(xjhksrq);
	changerqdata(xjhwcrq);
	addcolor(xjhksrq);	
	addcolor(xjhwcrq);	
});
function addcolor(fieldid){
	var fieldvalue = jQuery(fieldid).val();
	if(fieldvalue != ""){
		jQuery(fieldid+"span").css("background-color","yellow");
	}
}
function changerqdata(fieldid){
	var fieldvalue = jQuery(fieldid).val();
	if(fieldvalue == "0000-00-00"){
		jQuery(fieldid).val("");
		jQuery(fieldid+"span").text("");
		
	}
}
</script>
