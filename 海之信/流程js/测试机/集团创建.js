<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var nameCheck = "field13746_";  // 集团名称验证
		var jtname = "field11638_";  // 集团名称
 	checkCustomize = function () {
        		 var indexnum0=  jQuery("#indexnum0").val();
        		 for(index=0;index<indexnum0;index++){
		     	if(jQuery("#"+jtname+index).length>0){
		                  
                                 var name_val = jQuery("#"+nameCheck+index).val();
                                 var jtname_val = jQuery("#"+jtname+index).val();
		
					if(name_val=="重复"){
					alert(jtname_val+"已存在，请查询确认！");
					return false;
					}
		              }
		          }
	      
	      	return true;
             }
</script>








