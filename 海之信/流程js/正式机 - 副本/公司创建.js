<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var nameCheck = "field13218_";  // 客户名称验证
		var gsname = "field11595_";  // 客户名称
    var kh="field11611_";
    var gys="field11612_";
    var hzhb="field11613_";
 	checkCustomize = function () {
        		 var indexnum0=  jQuery("#indexnum0").val();
        		 for(index=0;index<indexnum0;index++){
		     	if(jQuery("#"+kh+index).length>0){
		                  var tmp_kh = jQuery("#"+kh+index).attr("checked");
                               var tmp_gys = jQuery("#"+gys+index).attr("checked")
                               var tmp_hzhb = jQuery("#"+hzhb+index).attr("checked")
                                if(tmp_kh == false && tmp_gys == false && tmp_hzhb == false){
                				alert("请选择与本公司的关系。")
               					return false;
                                 }
                                 var name_val = jQuery("#"+nameCheck+index).val();
                                 var gsname_val = jQuery("#"+gsname+index).val();
		
					if(name_val=="重复"){
					alert(gsname_val+"已存在，请查询确认！");
					return false;
					}
		              }
		          }
	      
	      	return true;
             }
</script>








