
var fphm = "field23767_";
var sfcf = "field31065_";
setInterval(fphmcf, 5000);
function fphmcf() {
	for (var i = 0; i < 200; i++) {
		if (jQuery("#" + fphm + i).val() != "") {
			get_some_Times_s(i);

		}
	}
}

function get_some_Times_s(fphp_val) {
	var fphp_val_s = jQuery("#" + fphm + fphp_val).val().trim();
	//window.top.Dialog.alert(fphp_val_s);
	jQuery.post("/gvo/HRworkflow/getfphm_305.jsp", {
		'fphm': fphp_val_s
	}, function (data) {
		//window.top.Dialog.alert(data);
		if (data > 0) {
			jQuery("#" + fphm + fphp_val).val("");
			jQuery("#" + sfcf + fphp_val).val("与数据库编码重复");
			jQuery("#" + sfcf + fphp_val).attr("style", "color:red;");
		} else {
			if (jQuery("#" + sfcf + fphp_val).val() == "与数据库编码重复") {
				jQuery("#" + sfcf + fphp_val).val("");
			}
		}
	});
}
