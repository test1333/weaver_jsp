var fymc = "field7244_";	 // 费用名称
var fybm = "field6933_";	 // 费用编码
var bxje = "field6932_";     //  金额
var ysje = "field7660_";     //预算金额
var yyys = "field7661_";     //已用预算



var fymc_hj = "field8558_";  // 费用名称合计
var fybm_hj = "field8557_";  // 费用编码合计
var bxje_hj = "field8562_";  // 金额 合计
var ysje_hj = "field8559_";  // 预算金额合计
var yyys_hj = "field8560_";  // 已用预算合计
var kyys_hj = "field8561_";   //   

var zhu_cb = "#field8698";
var mingx_cb = "field8699_";
var dis_zhucb = "#disfield8698";
var max_res_len = 0;

setTimeout('yourFunction()',1000);

function yourFunction(){
	for(var i=0;i<100;i++){
	    if(jQuery("#"+fybm+i).length>0){
	         checkN1(i);
	    }
	}
}


for(var i=0;i<10;i++){
    if(jQuery("#"+fymc_hj+i).length>0){
         max_res_len++;
    }
}

function checkN(){
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
	//alert(4442 + " $ " + nowRow);

	
	checkN1(nowRow);
	
}

function checkN1(index){
//	alert("index = " + index);
	//jQuery("#"+mingx_cb+index).bind("propertychange",function(){ 
	jQuery("#"+mingx_cb+index).bindPropertyChange(function(){ 
		cal_check();
	});

        //jQuery("#"+fybm+index).bind("propertychange",function(){
		jQuery("#"+fybm+index).bindPropertyChange(function(){
			calCheck();
	});

        //jQuery("#"+fymc+index).bind("change",function(){ 
		jQuery("#"+fymc+index).bindPropertyChange(function(){ 
			calCheck();
	});

	//jQuery("#"+bxje+index).bind("change",function(){ 
	jQuery("#"+bxje+index).bindPropertyChange(function(){
			calCheck();
	});
	
	//jQuery("#"+ysje+index).bind("change",function(){ 
	jQuery("#"+ysje+index).bindPropertyChange(function(){
			calCheck();
	});
	
	//jQuery("#"+yyys+index).bind("change",function(){
	jQuery("#"+yyys+index).bindPropertyChange(function(){
			calCheck();
	});
}



 // 主表下拉框值改变，也是重新判断的
//jQuery(zhu_cb).bind("change",function(){ 
jQuery(zhu_cb).bindPropertyChange(function(){ 
	cal_check();
});

function cal_check(){
	var tmp_val = "2";
//	alert("11")
	for(var i=0;i<100;i++){
		if(jQuery("#"+mingx_cb+i).length>0){
			var tmp_1 = jQuery("#"+mingx_cb+i).val();
		//	alert("tmp_1 = " + tmp_1);	
			if(tmp_1 == "1"){
				tmp_val = "1";
				i=101;
				jQuery(dis_zhucb).val("1");
				jQuery(zhu_cb+"span").val("标准外");
				jQuery(zhu_cb).val("1");
			}
		}
	}
//	alert("33 = " + tmp_val)
	if(tmp_val == "2"){
		jQuery(dis_zhucb).val("0");
		jQuery(zhu_cb+"span").val("标准内");
		jQuery(zhu_cb).val("0");
	}
}


// 合计不同类型
function calCheck(){
//	alert(4442);
	var fymc_arr = new Array();
	var fybm_arr = new Array();
	var bxje_arr = new Array();
	var ysje_arr = new Array();
	var yyys_arr = new Array();
	
	
	
	var max_len = 0;
	for(var i=0;i<300;i++){
		if(jQuery("#"+fymc+i).length>0 && max_len<3){
			var tmp_fymc_val = jQuery("#"+fymc+i).val();
			// 重复合计
			var tmp_fybm_val = jQuery("#"+fybm+i).val();
			var tmp_bxje_val = jQuery("#"+bxje+i).val();
			var tmp_ysje_val = jQuery("#"+ysje+i).val();
			var tmp_yyys_val = jQuery("#"+yyys+i).val();
			
			
	//		alert(tmp_fymc_val + " : " + tmp_fybm_val + " : " +  tmp_bxje_val);
	//		if(max_len==0){
	//			fymc_arr[0] = tmp_fymc_val;
	//			fybm_arr[0] = tmp_fybm_val;
	//			bxje_arr[0] = tmp_bxje_val;
	//			max_len = max_len + 1;
//			}else{
				// 是否有重复   0:不重复  1:有重复
				var is_now = 0;
				for(var j=0;j<max_len;j++){
					if(fybm_arr[j]==tmp_fybm_val){
						  // if(bxje_arr[j]!=''&&!isNaN(bxje_arr[j])){
			              	 bxje_arr[j] = Number(bxje_arr[j]) + Number(tmp_bxje_val);
			       // 	}
				//		   alert("bxje_arr["+j+"] = "+bxje_arr[j]);
	//			    bxje_arr[j]=document.write(parseFloat(bxje_arr[j])+parseFloat(tmp_bxje_val));
	//				bxje_arr[j] = parseFloat(Number(bxje_arr[j]) + Number(tmp_bxje_val));
					is_now = 1;
					}
				}
				if(is_now==0){
					fymc_arr[max_len] = tmp_fymc_val;
					fybm_arr[max_len] = tmp_fybm_val;
					bxje_arr[max_len] = tmp_bxje_val;
					ysje_arr[max_len] = tmp_ysje_val;
					yyys_arr[max_len] = tmp_yyys_val;
					
					max_len = max_len + 1;
				}
	//	}
		}
	}
	
	// 放置到合计:  扩展行比数组长度小时才添加
	if(max_res_len<3&&max_res_len<max_len){
		addRow1(1);
		max_res_len =max_res_len+1;
	}
	
	// 清空合计记录
	for(var k=0;k<5;k++){
		if(jQuery("#"+fymc_hj+k).length>0){
			jQuery("#"+fymc_hj+k).val(""); jQuery("#"+fymc_hj+k+"span").text("");
			jQuery("#"+fybm_hj+k).val(""); jQuery("#"+fybm_hj+k+"span").text("");
			jQuery("#"+bxje_hj+k).val(""); jQuery("#"+bxje_hj+k+"span").text("");
			jQuery("#"+ysje_hj+k).val(""); jQuery("#"+ysje_hj+k+"span").text("");
			jQuery("#"+yyys_hj+k).val(""); jQuery("#"+yyys_hj+k+"span").text("");
			jQuery("#"+kyys_hj).val(""); jQuery("#"+kyys_hj+"span").text("");
			
		}
	 }
	
	for(var k=0;k<max_len;k++){
//		alert(k + " : " + fymc_arr[k] + " : " +  fybm_arr[k] + " : " + bxje_arr[k] );
		// field8364_
		var tmp_bxje = Number(bxje_arr[k]).toFixed(2);
		//  转换成浮点2位小数
		//  tmp_bxje=parseFloat(tmp_bxje)*100/100.0;
		  
//		tmp_bxje=function temBxje(){  
//				var tmp_bxje = parseFloat(tmp_bxje);  
//	 		    if (isNaN(tmp_bxje)){  
//					return '0.00';  
		//	}  
//				var tmp_bxje = Math.round(tmp_bxje*100)/100.0;  
//				var bxje_x = tmp_bxje.toString();  
//				var pos_decimal = bxje_x.indexOf('.');  
//				if (pos_decimal < 0){  
//					pos_decimal = bxje_x.length;  
//					bxje_x += '.';  
		//	}  
//				while (bxje_x.length <= pos_decimal + 2){  
//					bxje_x += '0';  
		//	}  
//				return bxje_x;  
		// }  



		jQuery("#"+fymc_hj+k).val(fymc_arr[k]); jQuery("#"+fymc_hj+k+"span").text(fymc_arr[k]);
		jQuery("#"+fybm_hj+k).val(fybm_arr[k]); jQuery("#"+fybm_hj+k+"span").text(fybm_arr[k]);
		jQuery("#"+bxje_hj+k).val(tmp_bxje); jQuery("#"+bxje_hj+k+"span").text(tmp_bxje);
		jQuery("#"+ysje_hj+k).val(ysje_arr[k]); jQuery("#"+ysje_hj+k+"span").text(ysje_arr[k]);
		jQuery("#"+yyys_hj+k).val(yyys_arr[k]); jQuery("#"+yyys_hj+k+"span").text(yyys_arr[k]);
		
		
	}
	
}
