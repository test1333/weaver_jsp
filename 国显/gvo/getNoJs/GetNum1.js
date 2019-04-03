// 项目编号
var projectNo = "field8100_";

var no = 10;

var tem_nowRow;

var tem_str;

var new_no = 0;

// 物料描述
var wlms_str = "field6756_";

function getNo(){	
	var nowRow = parseInt($G("indexnum0").value) - 1;
	if(nowRow == 0){
//		alert(nowRow);
//		alert(no);
		jQuery("#"+projectNo+nowRow).val(no);
		jQuery("#"+projectNo+nowRow+"span").html(no);
		no = Number(no) + 10;
		new_no = no;
	}else{
//		alert(nowRow);
                tem_nowRow = Number(nowRow)-1;
		if(new_no == 0){
			tem_str = jQuery("#"+projectNo+tem_nowRow).val();
			new_no = Number(tem_str)+10;
		}
		jQuery("#"+projectNo+nowRow).val(new_no);
		jQuery("#"+projectNo+nowRow+"span").html(new_no);
		new_no = Number(new_no) + 10;
	}
		jQuery("input[id='"+wlms_str+nowRow+"']").bind("change",function(){
			// 获取必填信息
			var wlbh_val = jQuery("#"+wlms_str+nowRow).val();
			
			if(wlbh_val.length > 40 ){
				window.top.Dialog.alert("物料描述强制要求不超过40位,目前填写"+wlbh_val.length+"位！会清空记录！！");
				document.getElementById(wlms_str+nowRow).value="";
				document.all(wlms_str+nowRow+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			}
        
		});
}