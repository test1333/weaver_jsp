<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var yywjlb = '#field11377';//用印文件类别
var dyjzj = '#field11380';//低于基准价
var sjyjxxxs = '#field11381';//涉及佣金协议销售
var kjht = '#field11382';//框架合同
var fbztkdxsht = '#field11383';//有非标准条款的销售合同
var xykhxht = '#field11384';//下游客户新合同
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
		  
		var yywjlb_val = jQuery(yywjlb).val();
		if(yywjlb_val == "5"){
			var dyjzj_val=jQuery(dyjzj).is(':checked') ;
        	var sjyjxxxs_val=jQuery(sjyjxxxs).is(':checked') ;
        	var kjht_val=jQuery(kjht).is(':checked') ;
        	var fbztkdxsht_val=jQuery(fbztkdxsht).is(':checked') ;
			if(dyjzj_val == false && sjyjxxxs_val== false && kjht_val== false  && fbztkdxsht_val== false  ){
				 window.top.Dialog.alert("请在关键内同审核至少选择一项非标准合同的选项"); 		
				 return false; 
			}
			
		}
		  
		return true;
	}
		
})
</script>

