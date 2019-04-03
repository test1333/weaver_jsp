<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var wlglfw="#field51010";//物料管理范围
var wlglfw_dt1="#field51011_";//明细1 物料管理范围
var je_dt1 = "#field50755_";//明细1 金额
var kmkyje_dt1 = "#field54027_";//明细1 科目可用金额
var djje_dt1 = "#field54028_";//明细1 冻结金额
jQuery(document).ready(function(){
    jQuery(wlglfw).attr("readonly","readonly");
	jQuery("button[name=addbutton0]").live("click",function(){
		var index0 = jQuery('#indexnum0').val()-1;
		jQuery(kmkyje_dt1+index0).attr("readonly","readonly");
		jQuery(djje_dt1+index0).attr("readonly","readonly");
    });
	checkCustomize = function () {
		jQuery(wlglfw).val("");
		var indexnum0 = jQuery('#indexnum0').val();
		for(var index =0;index <indexnum0;index++){
			if(jQuery(wlglfw_dt1+index).length>0){	
				var wlglfw_dt1_val = jQuery(wlglfw_dt1+index).val();
				if(wlglfw_dt1_val == "集团"){
					jQuery(wlglfw).val(wlglfw_dt1_val);
					break;
				}
				
				
			}
			
		}
		for(var index =0;index <indexnum0;index++){
			if(jQuery(kmkyje_dt1+index).length>0){	
				var je_dt1_val = jQuery(je_dt1+index).val();
				var kmkyje_dt1_val = jQuery(kmkyje_dt1+index).val();
				var djje_dt1_val = jQuery(djje_dt1+index).val();
				if(je_dt1_val==""){
					je_dt1_val = "0";	
				}
				if(kmkyje_dt1_val==""){
					kmkyje_dt1_val = "0";	
				}
				if(djje_dt1_val==""){
					djje_dt1_val = "0";	
				}
				if(accAdd(kmkyje_dt1_val,djje_dt1_val)<Number(je_dt1_val)){
					Dialog.alert("明细存在申请金额大于科目可用金额+冻结金额，请检查");
					return false;
				}
			}
			
		}
		return true;
	}
	dodetail();
})

function dodetail(){
	var indexnum0 = jQuery('#indexnum0').val();
	for(var index =0;index <indexnum0;index++){
		if(jQuery(kmkyje_dt1+index).length>0){		
			jQuery(kmkyje_dt1+index).attr("readonly","readonly");
			jQuery(djje_dt1+index).attr("readonly","readonly");		
		}
			
	}
}
function accAdd(arg1,arg2){
		var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
		try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
			m=Math.pow(10,Math.max(r1,r2))
			return (arg1*m+arg2*m)/m
}
</script>
