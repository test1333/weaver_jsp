var fphm = "field23767_";
var sfcf = "field31065_";
setInterval(fphmcf, 4000);
function fphmcf() {
	
	for (var i=0; i < 100; i++) {
		if (jQuery("#" + fphm + i).val() != "") {
			for (var j = i + 1; j < 101; j++) {
				if (jQuery("#" + fphm + j).val()!="") {
					//window.top.Dialog.alert(jQuery("#" + fphm + i).val().trim());
					//window.top.Dialog.alert(jQuery("#" + fphm + j).val().trim());
					if (jQuery("#" + fphm + i).val().trim() == jQuery("#" + fphm + j).val().trim()) {
						
						var cf = "与表单编码重复";
						jQuery("#" + fphm + j).val("");
						jQuery("#" + sfcf + j).val(cf);
						jQuery("#" + sfcf + j).attr("style", "color:red;");
					} else {
						if (jQuery("#" + sfcf + j).val().trim() == "与表单编码重复" && jQuery("#" + sfcf + j).val().trim()!="") {
							jQuery("#" + sfcf + j).val("");
						}
					}
				}
			}
		}
	}
}
