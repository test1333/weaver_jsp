<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
     var bgce="#field_lable9341";//变更差额
    var kyys="#field9342";//可用预算
    var bglx="#field9337";//变更类型
    var bgce1="#field9341";//变更差额
    var xmjhkssj="#field9338";//新项目计划开始时间
   var xmjhjssj="#field9339";//新项目计划结束时间
     jQuery(document).ready(function(){
       jQuery(bgce).attr("readonly", "readonly");
         jQuery(kyys).attr("readonly", "readonly");
        checkCustomize = function () {
        	      var xmjhkssj_val=jQuery(xmjhkssj).val();
                	var xmjhjssj_val=jQuery(xmjhjssj).val();
                	if(xmjhkssj_val !="" && xmjhjssj_val !=""){
                		if(xmjhjssj_val < xmjhkssj_val){
                			alert("项目计划结束时间必须大于等于项目计划开始时间");
                			return false;
                	       }
                   }
        	      var bglx_val=jQuery(bglx).val();
        		var kyys_val=jQuery(kyys).val();
        		var bgce_val=jQuery(bgce1).val();
        		if(bglx_val == '1'){
        		    	if(kyys_val ==''){
                			kyys_val = '0';	
                	       }
                	   	if(bgce_val ==''){
                			bgce_val = '0';	
                	       }
                	      if(Number(bgce_val)>Number(kyys_val)){
          	      	  alert("变更差额大于可用预算,请检查");
          	      	  return false;
          	           }
        	      }
        	      return true;
        }
     });
</script>
