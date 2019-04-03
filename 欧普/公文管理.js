<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var gwlx = "#field9395";
jQuery(document).ready(function(){
showhide();
jQuery(gwlx ).bind("change",function(){	//隐藏方法
			showhide();
		});
		alert("123");
	jQuery("button").each(function(){
		alert(jQuery(this).attr("title"));
	  });
});
function showhide(){
		//alert("隐藏明细");
		var gwlx_val = jQuery(gwlx).val();
		if(gwlx_val== ""){
			jQuery("#ycmx").hide();	 
		}else if(gwlx_val== "0"){
			jQuery("#ycmx").hide();
		}else if(gwlx_val== "1"){
			jQuery("#ycmx").show();
		}
	}
</script>





