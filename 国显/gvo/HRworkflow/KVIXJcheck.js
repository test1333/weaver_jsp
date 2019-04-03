jQuery(document).ready(
		function() {

			var qjlx = "#field8202";// 请假类型：L_001年假、L_002调休假、L_003事假、L_005婚假、L_007陪产假、L_012丧假
			var sjqjxss = "#field5886";// 预计请假小时数
			var njwxxsh = "#field5933";// 年假未休小时数
			var tsjwxxsh = "#field5938";// 调休假未休小时数

			checkCustomize = function() {
				var qjlx_val = jQuery(qjlx).val();
				var sjqjxss_val = jQuery(sjqjxss).val();
				var njwxxsh_val = jQuery(njwxxsh).val();
				var tsjwxxsh_val = jQuery(tsjwxxsh).val();
				var result = true;
				// alert(tszt_val);
				if (qjlx_val == "L_001" || qjlx_val == "L_002"
						|| qjlx_val == "L_003" || qjlx_val == "L_005"
						|| qjlx_val == "L_007" || qjlx_val == "L_012") {
					// L_002调休假
					if (qjlx_val == "L_002") {
						if (Number(sjqjxss_val) > Number(tsjwxxsh_val)) {
							window.top.Dialog.alert("实际请假小时数大于剩余调休假！");
							result = false;
						}
					}
					// L_001年假
					if (qjlx_val == "L_001") {
						if (Number(sjqjxss_val) > Number(njwxxsh_val)) {
							window.top.Dialog.alert("实际请假小时数大于剩余年假！");
							result = false;
						}
					}
					// L_003事假
					if (qjlx_val == "L_003") {
						if (Number(sjqjxss_val) > 120) {
							window.top.Dialog.alert("实际请假小时数超出规定！");
							result = false;
						}
					}
					// L_005婚假、L_007陪产假
					if (qjlx_val == "L_005" || qjlx_val == "L_007") {
						if (Number(sjqjxss_val) > 80) {
							window.top.Dialog.alert("实际请假小时数超出规定！");
							result = false;
						}
					}
					//L_012丧假
					if (qjlx_val == "L_012") {
						if (Number(sjqjxss_val) > 40) {
							window.top.Dialog.alert("实际请假小时数超出规定！");
							result = false;
						}
					}
				}

				return result;
			}
		});