<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
 jQuery(document).ready(function() {
	//alert(111)
var amount = 'field8946_'//含税金额
var cost = 'field11347_'//已发生费用
var left = 'field11298_'//预算余额
jQuery("#indexnum0").bindPropertyChange(function(){
		bindamount(1);
	});
	bindamount(2);
	function bindamount(value){
		var indexnum0 = 0;    
		if(document.getElementById("indexnum0")){
			indexnum0 = document.getElementById("indexnum0").value - 1;
		}    
		if(indexnum0>=0){  
			if(value==1){ //当前添加的行
				jQuery("#"+amount+indexnum0).bindPropertyChange(function(){ 
					var amountVal = jQuery("#" + amount + indexnum0).val();
					//alert("amountVal ==" + amountVal)
					var costVal = jQuery("#" + cost + indexnum0).val();
					//alert("costVal ==" + costVal)
					var leftVal = jQuery("#" + left + indexnum0).val();
					//alert("leftVal ==" + leftVal)
					var tempval = Number(amountVal) - Number(costVal)
					if (Number(tempval)>Number(leftVal)) {
						alert("不能大于预算");
					}
				});
			}else if(value==2){ 	
				for(var i=0;i<=indexnum0;i++){ 
					jQuery("#"+amount+i).attr("indexno",i); 
					jQuery("#"+amount+i).bindPropertyChange(function(){ 
						var amountVal = jQuery("#" + amount + indexnum0).val();
					//alert("amountVal ==" + amountVal)
					var costVal = jQuery("#" + cost + indexnum0).val();
					//alert("costVal ==" + costVal)
					var leftVal = jQuery("#" + left + indexnum0).val();
					//alert("leftVal ==" + leftVal)
					var tempval = Number(amountVal) - Number(costVal)
					if (Number(tempval)>Number(leftVal)) {
						alert("不能大于预算");
					}              
					});  
						
				}       
			}   
		}	
	}
	})
</script>




