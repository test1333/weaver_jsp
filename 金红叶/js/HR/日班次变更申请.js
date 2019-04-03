<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var sfjj_dt1="#field17058_";//是否拒绝明细1
	var xz_dt1 ="#field17043_";//选择明细1
	jQuery(document).ready(function(){
		setTimeout('hideDetail()',10);
		checkCustomize = function () {
			//alert(languageid);
			var flag ="0";
			var indexnum0 = jQuery("#indexnum0").val();
			for(var index = 0;index < indexnum0;index++){
				if(jQuery(xz_dt1+index).length>0){
					 if (jQuery(xz_dt1+index).is(':checked') == true) {
						 flag="1";
						 break;
					 }
				}
			}
			if(flag == "0"){
				if(languageid != 7){
					alert("Please confirm that at least one item is selected, otherwise, please choose to return or reject it!");
				}else{
					alert("批准请确认至少有一条明细被选中,否则请选择退回或拒绝!");					
				}
				return false;
			}
			return true;
		}
		
	})
	
	function hideDetail(){
		var indexnum0=  jQuery("#indexnum0").val();
		
		var oTable = document.getElementById("oTable0");
		 for(var i=0;i<indexnum0;i++){
			if(jQuery(sfjj_dt1+i).length>0){			 
			 var sfjj_dt1_val = jQuery(sfjj_dt1+i).val();
			 if(sfjj_dt1_val == "1"){
				oTable.rows[i+3].style.display = "none";
			 }		  
			}
		}

		
    }



    
</script>
