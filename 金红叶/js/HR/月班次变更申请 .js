<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var sfjj_dt1="#field17670_";//是否拒绝明细1
	jQuery(document).ready(function(){
		setTimeout('hideDetail()',10);
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
