<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
   var xmlx="#field9642";//项目类型
   var xmlx_old="";//项目类型_old
   var dt1yc1="#dt1yc1";
   var dt1yc2="#dt1yc2";
   var dt1yc3="#dt1yc3";
   var dt1yc4="#dt1yc4";
   var ysjeyc="#ysjeyc";
   var lxje="#field9378";//主表立项金额
   var kyje="#field9834";//主表可用预算
   var lxje_dt1="#field9316_";//明细表立项金额
   var kyje_dt1="#field9311_";//明细表可用预算
   var xmsbmc_dt1="#field12184_";//明细表项目设备名称
   var xmjhkssj="#field9119";//项目计划开始时间
   var xmjhjssj="#field9120";//项目计划结束时间
       jQuery(document).ready(function(){
       	   var xmlx_val=jQuery(xmlx).val();
       	  showordiaplaydt1(xmlx_val);
               jQuery(xmlx).bindPropertyChange(function () {
               	    var xmlx_val=jQuery(xmlx).val();
               	    showordiaplaydt1(xmlx_val);
                });
                checkCustomize = function () {
                	var xmjhkssj_val=jQuery(xmjhkssj).val();
                	var xmjhjssj_val=jQuery(xmjhjssj).val();
                	if(xmjhkssj_val !="" && xmjhjssj_val !=""){
                		if(xmjhjssj_val < xmjhkssj_val){
                			Dialog.alert("项目计划结束时间必须大于等于项目计划开始时间");
                			return false;
                	       }
                   }
                	var xmlx_val=jQuery(xmlx).val();
                	if(xmlx_val == '0'||xmlx_val == '2'||xmlx_val == '3'){
                		var lxje_val=jQuery(lxje).val();
                		var kyje_val=jQuery(kyje).val();
                		if(lxje_val ==''){
                			lxje_val = '0';	
                	       }
                	   	if(kyje_val ==''){
                			kyje_val = '0';	
                	       }
                		if(Number(lxje_val)>Number(kyje_val)){
                		   Dialog.alert("立项金额不能超过项目预算可用预算");
                		   return false;	
                	       }
                    }else if(xmlx_val == '1'){
                       var indexnum0=jQuery("#indexnum0").val(); 
                        for( var index=0;index<indexnum0;index++){
                        	   if( jQuery(lxje_dt1+index).length>0){
                        	   	   var lxje_dt1_val=jQuery(lxje_dt1+index).val();
                        	   	   var kyje_dt1_val=jQuery(kyje_dt1+index).val();
                        	   	  if(lxje_dt1_val ==''){
                				lxje_dt1_val = '0';	
                	 	         }
                	   	    	if(kyje_dt1_val ==''){
                				kyje_dt1_val = '0';	
                	       	}
                        	   	   if(Number(lxje_dt1_val)>Number(kyje_dt1_val)){
                		   		Dialog.alert("明细中存在立项金额超过项目预算可用预算的条目，请检查");
                		   		return false;	
                	       	  }
                	       	  var xmsbmc_dt1_val = jQuery(xmsbmc_dt1+index).val();
                	       	  var flag="0";
                	       	  flag=checkxmsbmcdt(xmsbmc_dt1_val,index);
                	       	  if(flag=="1"){
                	       	  	 Dialog.alert("明细中存在项目/设备名称字段重复，请检查");
                	       	  	 return false; 
                	               }
                        	   }
                        }
                   }
                	return true;
                }
      })
      function checkxmsbmcdt(xmsbmc_val,index1){
       var indexnum0=jQuery("#indexnum0").val(); 
       for( var index=index1+1;index<indexnum0;index++){
          	   if( jQuery(xmsbmc_dt1+index).length>0){
          	   	var xmsbmc_dt1_val = jQuery(xmsbmc_dt1+index).val(); 
          	   	if(xmsbmc_dt1_val == xmsbmc_val)  {
          	   		return "1";
          	      }
          	  }
      }
   }  	 
      function showordiaplaydt1(xmlx_val){
      if(xmlx_val == '' || xmlx_val == '0' || xmlx_val == '2' || xmlx_val == '3'){
        	jQuery(dt1yc1).hide();
 	      jQuery(dt1yc2).hide();
 	      jQuery(dt1yc3).hide();
 	      jQuery(dt1yc4).hide();
 	      jQuery(ysjeyc).show();	
       }
        if(xmlx_val == '1' ){
        	jQuery(dt1yc1).show();
 	      jQuery(dt1yc2).show();
 	      jQuery(dt1yc3).show();
 	      jQuery(dt1yc4).show();
 	       jQuery(ysjeyc).hide();		
       }
       
     }
</script>






