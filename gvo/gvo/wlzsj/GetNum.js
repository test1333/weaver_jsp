// 行项目编号
var projectNo = "field8071_";

var no = 10;

var tem_nowRow;

var tem_str;

var new_no = 0;

// 物料编号
var wlbh = "field6833_";
// 是否委外
//var pro_old = "field7370_";
// 物料描述
var wl_old = "field6886_";
// 物料描述
var wlms_str = "field6886_";
var plgl_str = "field7672_";

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
	
//	jQuery("input[id='"+pro_old+nowRow+"']").bind("propertychange",function(){
		// 获取必填信息
//		var needcheck = document.all("needcheck");
		// 获取委外值
//	    var s_sm_val = jQuery("#"+pro_old+nowRow).val();
	    // 如果为0   物料描述 改为变编辑
//	    if(s_sm_val=='0'){
//	        if(needcheck.value.indexOf(wl_old+nowRow)>=0){
//				needcheck.value.replace(","+wl_old+nowRow,"");  //可编辑
//				document.all(wl_old+nowRow+"span").innerHTML = "";
	//    }
//    }
        // 如果为1  物料描述 改为变必填
//	    if(s_sm_val=='1'){
//	    	document.all(wl_old+nowRow+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
//		    if(needcheck.value.indexOf(wl_old+nowRow)<0){  //如果非必填项，则加入必填项判断
//	            if(needcheck.value!='') needcheck.value+=",";
//	            needcheck.value+=wl_old+nowRow;
    //	}
//    }
        
//	});
	
	jQuery("input[id='"+wlbh+nowRow+"']").bind("change",function(){
		// 获取必填信息
		var wlbh_val = jQuery("#"+wlbh+nowRow).val();
		
			
		if(wlbh_val.substring(0,1) != "G"){
			alert("SAP物料编码要求G开头！");
			jQuery("#"+plgl_str+nowRow).val("");
			jQuery("#"+plgl_str+nowRow+"span").text("");
		}
		if(wlbh_val.length !=16 ){
			alert("SAP物料编码要求16位,目前填写"+wlbh_val.length+"位！");
			jQuery("#"+plgl_str+nowRow).val("");
			jQuery("#"+plgl_str+nowRow+"span").text("");
		}
		else
		{
		    //SAP物料编码第5位赋值批次管理 字符为A则批次管理为空 否则为X  2016/11/14
	        var sapbm_len = wlbh_val.length;
	        var checkstr = wlbh_val.substr(Number(sapbm_len)-5,1);		
	        if (checkstr=="A")
	        {
		        jQuery("#"+plgl_str+nowRow).val(" ");
			    jQuery("#"+plgl_str+nowRow+"span").text(" ");
	        }
	        else
	        { 
		        jQuery("#"+plgl_str+nowRow).val("X");
		        jQuery("#"+plgl_str+nowRow+"span").text("X");
            }				
		}
        
	});
	
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