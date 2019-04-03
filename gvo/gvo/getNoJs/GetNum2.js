// 项目编号
var projectNo = "field8101_";

var no = 10;

var tem_nowRow;

var tem_str;

var new_no = 0;

// 是否仓库收货
var sfsh_str = "field6711_";
// 是否列管资产
var sfzc_str = "field7629_";
// 科目分类码
var kmlm_str = "field8109_";


// 物料描述
var wlms_str = "field6714_";

for(var i=0;i<200;i++){
    if(jQuery("#"+sfsh_str+i).length>0){
         checkNo(i);
    }else{
    	i = 200;
    }
}


function getNo(){	
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
	checkNo(nowRow);
}

function checkNo(nowRow){
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
	
	jQuery("#"+sfsh_str+nowRow).bindPropertyChange(function () {
//	jQuery("#"+sfsh_str+nowRow).bind("propertychange",function(){
		var sfsh_val = jQuery("#"+sfsh_str+nowRow).val();
		var sfzc_val = jQuery("#"+sfzc_str+nowRow).val();
		if(sfsh_val.length>0&&sfzc_val.length>0){
			if(sfsh_val=='0'&&sfzc_val=='0'){
				document.getElementById(kmlm_str+nowRow).value = "Y";
			}else if(sfsh_val=='0'&&sfzc_val=='1'){
				document.getElementById(kmlm_str+nowRow).value = "K";
			}else{
				document.getElementById(kmlm_str+nowRow).value = "Z";
			}
			document.getElementById(kmlm_str+nowRow).readOnly = true;
		}
	})

	jQuery("#"+sfzc_str+nowRow).bindPropertyChange(function () {
//	jQuery("#"+sfzc_str+nowRow).bind("propertychange",function(){
		var sfsh_val = jQuery("#"+sfsh_str+nowRow).val();
		var sfzc_val = jQuery("#"+sfzc_str+nowRow).val();
		if(sfsh_val.length>0&&sfzc_val.length>0){
			if(sfsh_val=='0'&&sfzc_val=='0'){
				document.getElementById(kmlm_str+nowRow).value = "Y";
			}else if(sfsh_val=='0'&&sfzc_val=='1'){
				document.getElementById(kmlm_str+nowRow).value = "K";
			}else{
				document.getElementById(kmlm_str+nowRow).value = "Z";
			}
			document.getElementById(kmlm_str+nowRow).readOnly = true;
		}
	})
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