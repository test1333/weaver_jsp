//alert(1);
jQuery(document).ready(function(){
	//alert(2);
	var supplierStatus = "#field16545";//供应商状态0,1
	var supplierKind = "#field16546";//供应商性质0,1
	var supplierAccount = "#field16547";//供应商账户组
	
	jQuery(supplierKind).bindPropertyChange(function () {
	//jQuery(supplierKind).bind("propertychange",function(){
//	alert("3");
		var supplierStatus_val = jQuery(supplierStatus).val();
		var supplierKind_val = jQuery(supplierKind).val();
		//alert("supplierKind_val="+supplierKind_val);
	//alert("4");
		if(Number(supplierStatus_val)==0&&Number(supplierKind_val)==0){
			jQuery(supplierAccount).val("Z001");	
			jQuery(supplierAccount+"span").text("Z001");
		}

		else if(Number(supplierStatus_val)==0&&Number(supplierKind_val)==1){
			jQuery(supplierAccount).val("Z002");
			jQuery(supplierAccount+"span").text("Z002");	
		}

		else if(Number(supplierStatus_val)==1&&Number(supplierKind_val)==0){
			jQuery(supplierAccount).val("Z007");
			jQuery(supplierAccount+"span").text("Z007");	
		}

		else if(Number(supplierStatus_val)==1&&Number(supplierKind_val)==1){
			jQuery(supplierAccount).val("Z008");
			jQuery(supplierAccount+"span").text("Z008");		
		}
		else{
			jQuery(supplierAccount).val("");
			jQuery(supplierAccount+"span").text("");	
		}
	});
	jQuery(supplierStatus).bindPropertyChange(function () {
//	jQuery(supplierStatus).bind("propertychange",function(){
	//alert("3");
		var supplierStatus_val = jQuery(supplierStatus).val();
		var supplierKind_val = jQuery(supplierKind).val();
		//alert("supplierKind_val="+supplierKind_val);
	//alert("4");
		if(Number(supplierStatus_val)==0&&Number(supplierKind_val)==0){
			jQuery(supplierAccount).val("Z001");
			jQuery(supplierAccount+"span").text("Z001");	
		}

		else if(Number(supplierStatus_val)==0&&Number(supplierKind_val)==1){
			jQuery(supplierAccount).val("Z002");	
			jQuery(supplierAccount+"span").text("Z002");
		}

		else if(Number(supplierStatus_val)==1&&Number(supplierKind_val)==0){
			jQuery(supplierAccount).val("Z007");
			jQuery(supplierAccount+"span").text("Z007");	
		}

		else if(Number(supplierStatus_val)==1&&Number(supplierKind_val)==1){
			jQuery(supplierAccount).val("Z008");
			jQuery(supplierAccount+"span").text("Z008");	
		}
		else{
			jQuery(supplierAccount).val("");
			jQuery(supplierAccount+"span").text("");
		}
	});
});