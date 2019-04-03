var zhu_zs = "#field10926";
var mingx_zs = "field10872_";
var dis_zhuzs = "#disfield10926";


//  函数绑定到 mingx_zs 值上
for(var j=0;j<100;j++){
	if(jQuery("#"+mingx_zs+j).length>0){
		checkM1(j);
	}else{
		j = 101;
	}
}

function checkM(){
	var nowRow=parseInt($G("indexnum0").value)-1;
	checkM1(nowRow);
}


function checkM1(index){
	jQuery("#"+mingx_zs+index).bind("propertychange",function(){ 	
		cal_check();
	});
}


 // 主表下拉框值改变，也是重新判断的
jQuery(zhu_zs).bind("change",function(){ 	
	cal_check();
});

function cal_check(){
	var tmp_val = "0";
	for(var i=0;i<100;i++){
		// alert("length = " + jQuery("#"+mingx_zs+i).length);
		if(jQuery("#"+mingx_zs+i).length>0){
			var tmp_1 = jQuery("#"+mingx_zs+i).val();
		//	alert("values = " + tmp_1);
			if(tmp_1 == "0"){
				tmp_val = "1";
				
		
				i=101;
				jQuery(dis_zhuzs).val("0");
				jQuery(zhu_zs+"span").val("是");
				jQuery(zhu_zs).val("0");
			}
		}else{
			i=101;
		}
	}
	
	if(tmp_val == "0"){
	jQuery(dis_zhuzs).val("1");
		jQuery(zhu_zs+"span").val("否");
		jQuery(zhu_zs).val("1");
	}
}
