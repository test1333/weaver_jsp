           
	var fphm = "field23765_";
	var sfcf = "field31029_";
       setTimeout('fphmcf()',1200);
       //fphmcf();
function fphmcf() {
		for (var i = 0; i < 200; i++) {
			
			if (jQuery("#" + fphm + i).length > 0) {
				get_some_Times_s(i);
				
//window.top.Dialog.alert(i);
			}
		}
	}

function get_some_Times_s(fphp_val) {
		if (jQuery("#" + fphm + fphp_val).length > 0) {
			var fphp_val_s = jQuery("#" + fphm + fphp_val).val();
			window.top.Dialog.alert(fphp_val_s);
			if (fphp_val_s.length > 0) {
				jQuery.post("/gvo/HRworkflow /getfphm_9.jsp", {'fphm': fphp_val_s}, function (data) {
					     window.top.Dialog.alert(data);
					
					if (data> 0){
						jQuery("#" + fphm + fphp_val).val("");
					      jQuery("#"+sfcf+fphp_val).val("重复");
					}

				});
			}
		}
	}