jQuery(document).ready(function(){
	
	var qjlx = "#field8202";// 请假类型
	var yjqjxss = "#field5881";//预计请假小时数
	var njwxxsh = "#field5933";//年假未休小时数
	var tsjwxxsh = "#field5938";//调休假未休小时数
	var sjqjxss = "#field5886";//实际请假小时数
	var gzxz = "#field16785";//工作性质等于A或B
	//alert(11111);
	checkCustomize = function(){ 
		var qjlx_val = jQuery(qjlx).val();
		var yjqjxss_val = jQuery(yjqjxss).val();
		var njwxxsh_val = jQuery(njwxxsh).val();
		var tsjwxxsh_val = jQuery(tsjwxxsh).val();
		var sjqjxss_val = jQuery(sjqjxss).val();
		var gzxz_val = jQuery(gzxz).val();
		var result = true; 
//		alert(tszt_val);
        if (Number(sjqjxss_val)<=0) {
					window.top.Dialog.alert("实际请假小时数要大于0！");
					result = false;
				}
		if(qjlx_val == "L_001" || qjlx_val == "L_002"
						|| qjlx_val == "L_003" || qjlx_val == "L_005"
						|| qjlx_val == "L_007" || qjlx_val == "L_012"
						|| gzxz_val == "A" || gzxz_val == "B"){
			if(qjlx_val == "L_002"){
				if(Number(sjqjxss_val)>Number(tsjwxxsh_val)){
					window.top.Dialog.alert("当前请假小时数大于剩余调休假");
					result = false;
				}
			}
			if(qjlx_val == "L_001"){
				if(Number(sjqjxss_val)>Number(njwxxsh_val)){
					window.top.Dialog.alert("当前请假小时数大于剩余年假");
					result = false;
				}else if(Number(sjqjxss_val)<3.5){
					window.top.Dialog.alert("当前请假小时数小于3.5小时")			;
					result = false;
				}
			}
			// L_003事假
			if (qjlx_val == "L_003") {
				if (Number(sjqjxss_val) > 120) {
					 //alert("当前请假小时数超出规定！");
					 result = true;
				}else if(Number(sjqjxss_val)<1){
					window.top.Dialog.alert("当前事假请假小时数小于1小时")			;
					result = false;
			    }
			}
			
			
		}
		return result;
	}
});
