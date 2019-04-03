<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    /*
    *  TODO
     *  请在此处编写javascript代码
     */
jQuery(document).ready(function(){
		     
	checkCustomize = function(){
		var flag = false;
		var chkboxs = ["field8010", "field8011", "field8012", "field8013"];
		for(var i = 0; i < chkboxs.length; i++)
		  {
			 if($("#"+chkboxs[i]).is(":checked"))
			   {
				  flag = true; 
				  break;
			   }
		  }
		  
		if(!flag)
		  {
			window.top.Dialog.alert("请至少选择一种印章用印类型！"); 		
			return false; 
		  }	
		  
		return true;
	}
		
})
</script>

