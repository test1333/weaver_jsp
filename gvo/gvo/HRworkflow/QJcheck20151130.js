jQuery(document).ready(function(){
	
	var qjlx = "#field8202";// 请假类型
	var yjqjxss = "#field5881";//预计请假小时数
	var njwxxsh = "#field5933";//年假未休小时数
	var tsjwxxsh = "#field5938";//调休假未休小时数
	
	
	checkCustomize = function(){ 
		var qjlx_val = jQuery(qjlx).val();
		var yjqjxss_val = jQuery(yjqjxss).val();
		var njwxxsh_val = jQuery(njwxxsh).val();
		var tsjwxxsh_val = jQuery(tsjwxxsh).val();
		var result = true; 
//		alert(tszt_val);
        if (Number(yjqjxss_val)<=0) {
					alert("预计请假小时数要大于0！");
					result = false;
				}
		if(qjlx_val == "L_001" || qjlx_val == "L_002"){
			if(qjlx_val == "L_002"){
				if(Number(yjqjxss_val)>Number(tsjwxxsh_val)){
					//alert("当前请假小时数大于剩余调休假");
					result = true;
				}
			}
			if(qjlx_val == "L_001"){
				if(Number(yjqjxss_val)>Number(njwxxsh_val)){
					//alert("当前请假小时数大于剩余年假");
					result = true;
				}else if(Number(yjqjxss_val)<0){
					alert("当前请假小时数小于2小时")			;
					result = false;
				}
			}
			
			
		}
		return result;
	}
});
