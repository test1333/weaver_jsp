<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
     var hswrmbje="#field8483";//核算为人民币金额
    
    var sfcg ="#field8446";//是否超过5000W
    var sfyy="#field8457";//是否用印
    var gz="#field8458";//公章
    var htz="#field8459";//合同章
    var frz="#field8460";//法人章
    var frqz="#field8461";//法人签字
    var bhsj="#field8501"//变更时间
    var htksrq="#field8484";//合同开始日期
    var htjsrq="#field11196";//合同结束日期
     jQuery(document).ready(function(){
      jQuery(hswrmbje).bindPropertyChange(function () {
         var hswrmbje_val= jQuery(hswrmbje).val();
          if(Number(hswrmbje_val)>50000000){
                jQuery(sfcg).val("0");
             }else{
                jQuery(sfcg).val("1");
             }
       })
        var sfyy_val=jQuery(sfyy).val();
         if(sfyy_val == "1"){
         	jQuery(gz).attr("disabled", "disabled");
             jQuery(htz).attr("disabled", "disabled");
            jQuery(frz).attr("disabled", "disabled");
            jQuery(frqz).attr("disabled", "disabled");
         }   
       jQuery(sfyy).bind("change",function(){
        var sfyy_val=jQuery(sfyy).val();
          if(sfyy_val == "1"){
        	jQuery("span").removeClass("jNiceChecked");
        	jQuery(gz).val("0");
        	jQuery(htz).val("0");
        	jQuery(frz).val("0");
        	jQuery(frqz).val("0");
        	jQuery(gz).attr("disabled", "disabled");
             jQuery(htz).attr("disabled", "disabled");
            jQuery(frz).attr("disabled", "disabled");
            jQuery(frqz).attr("disabled", "disabled");
          }else{
          	  	jQuery(gz).attr("disabled", "");
             jQuery(htz).attr("disabled", "");
            jQuery(frz).attr("disabled", "");
            jQuery(frqz).attr("disabled", "");
       }
       });
          checkCustomize = function () {
        	      var sfyy_val=jQuery(sfyy).val();
        	      if(sfyy_val == "0"){
        	        var gz_val=jQuery(gz).is(':checked') ;
        	        var htz_val=jQuery(htz).is(':checked') ;
        	        var frz_val=jQuery(frz).is(':checked') ;
        	        var frqz_val=jQuery(frqz).is(':checked') ;
        	          if(gz_val == false && htz_val== false && frz_val== false  && frqz_val== false  ){
			       alert("用印名称，请至少勾选1项！");
			      return false;
			    }
   		
        	      }
        	      var bhsj_val=jQuery(bhsj).val();
        	      var htksrq_val=jQuery(htksrq).val();
        	      var htjsrq_val=jQuery(htjsrq).val();
        	     if(bhsj_val=="0"){
        	      if(htjsrq_val<htksrq_val){
        	      	   Dialog.alert("合同结束日期必须大于等于开始日期");
        	      	   return false;
        	     }
        	} 
        	      return true;
        }   
         
     });
</script>



