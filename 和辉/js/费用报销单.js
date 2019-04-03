<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">

var ysfabm = "#field9041";//预算方案编码
var bmbm = "#field9045";//部门编码
var ysye_dt1 = "#field9034_";//预算余额
var ysxmbh_dt1 = "#field9488_";//预算项目编号
 jQuery(document).ready(function() {
	//alert(111)
var amount = 'field8946_'//含税金额
var cost = 'field11347_'//已发生费用
var left = 'field11298_'//预算余额
  jQuery("#indexnum0").bindPropertyChange(function(){  
	   var indexnum0 =jQuery("#indexnum0").val()-1;
		binddt2(indexnum0);
		bindamount(1);
	});
	dodetailonLoad();
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
	
	function dodetailonLoad(){
		var indexnum0 =jQuery("#indexnum0").val();
		for(var index=0;index<=indexnum0;index++){ 
			if(jQuery(ysye_dt1+index).length>0){
				binddt2(index);
				
			}
		}
		
	}
	function binddt2(index){
		jQuery(ysye_dt1+index).attr("readonly", "readonly");
		 jQuery(ysxmbh_dt1+index).bindPropertyChange(function(){
			var ysfabm_val = jQuery(ysfabm).val();
			var bmbm_val = jQuery(bmbm).val();
			var ysxmbh_dt1_val = jQuery(ysxmbh_dt1+index).val();
			getDetailData(bmbm_val,ysfabm_val,ysxmbh_dt1_val,index);
		 })
	}
	
	function getDetailData(I_DEPNUM,I_FANUM,I_PPNUM,index){
     var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
  	   	   	xhr.open("GET","/hhgd/sap/get-budget-amount.jsp?I_DEPNUM="+I_DEPNUM+"&I_FANUM="+I_FANUM+"&I_PPNUM="+I_PPNUM, false);
			xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
			  if (xhr.status == 200) {
				var text = xhr.responseText;
				text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
				//alert(text);
				jQuery(ysye_dt1+index).val(text);
			   }
			  }
			 }
       xhr.send(null);
     }
  }
</script>




