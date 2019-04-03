<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 jQuery(document).ready(function(){
	 jQuery("#sumvalue6531").bindPropertyChange(function (){
		 var sumval = jQuery("#sum6531").text();
		jQuery("#sum6531").text(toqfw(sumval));
		 
		 
	 })
	 
	 
 })
function toqfw(value){
	var r2
	try{r2=value.toString().split(".")[1].length}catch(e){r2=0} 
	  var result=Number(value).toFixed(r2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
	  return result;
}
</script>
