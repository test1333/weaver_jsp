<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var splx_main="#field6864";        //审批类型
var splx_dt ="#field6578_";  //明细审批类型
var kmbm_dt1="#field6413_";//科目编码
jQuery(document).ready(function() {
   checkCustomize = function() {
      var indexnum0=jQuery("#indexnum0").val();
      var nodesnum0=jQuery("#nodesnum0").val();
	  var countnum=0;
	  for(var i=0;i<indexnum0;i++){
		if(jQuery(kmbm_dt1+i).length>0){	
			countnum = countnum+1;	
			var kmbm_dt1_val=jQuery(kmbm_dt1+i).val();
			if(kmbm_dt1_val == ""){
			  alert("明细第"+countnum+"行的暂支科目暂时没有建立，暂时无法暂支，请联系财务人员");
			  return false;
			}
					
		}
	}
      for(var x=0;x<indexnum0;x++){
         for(var y=x+1;y<indexnum0;y++){
           if(jQuery(splx_dt+y).length>0){
                var d_val_val = jQuery(splx_dt+x).val();
                var d_val_val2 = jQuery(splx_dt+y).val();
                var num1=x+1;var num2=y+1;
                if(d_val_val!=d_val_val2){
                  window.top.Dialog.alert("提交失败:明细"+num1+"和明细"+num2+"审批类型不一致，请检查后重新提交!");
                  return false;
                }         
             }
          }
      }
       var tmp=jQuery(splx_dt +"0").val();
       jQuery(splx_main).val(tmp);
       jQuery(splx_main).text(tmp);
       return true;
   }
})

</script>




























































