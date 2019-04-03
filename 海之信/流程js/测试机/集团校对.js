<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var lx = "#field11727";
	var jt = "#field11726";
	    var yjdzt="field11745";
    var xjdzt="field11746";
    	var nameCheck = "field13747";  // 集团名称验证
		var jtname = "field11728";  // 集团名称
	
    jQuery(document).ready(function () {
	jQuery(lx).bindPropertyChange(function (){ 
                jQuery(jt).val("");
		jQuery(jt+"span").text("");
	})
	checkCustomize = function () {
		 var yjdzt_val=jQuery("#"+yjdzt).val();
		  var xjdzt_val=jQuery("#"+xjdzt).val();
		  if(yjdzt_val == '0' && xjdzt_val=='0'){
		      alert("请修改新校对状态后再提交。");
		       return false;
		     }
		       var name_val = jQuery("#"+nameCheck).val();
                     var jtname_val = jQuery("#"+jtname).val();
                     	if(name_val=="重复"){
					alert(jtname_val+"已存在，请查询确认！");
					return false;
					}
	      	return true;
             }
    });	
</script>





