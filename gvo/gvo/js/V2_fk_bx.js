var zhu_ys = "#field24457";
var mingx_ys = "field24485_";
var dis_zhuys = "#disfield24457";
var max_res_len = 0;


setTimeout('yourFunction()',1000);

function yourFunction(){
	for(var i=0;i<100;i++){
	    if(jQuery("#"+mingx_ys+i).length>0){
	         checkN(i);
	    }
	}
}


for(var i=0;i<10;i++){
    if(jQuery("#"+mingx_ys+i).length>0){
         max_res_len++;
    }
}

function checkN(){
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
alert(4442);

	
	checkN1(nowRow);
	
}




function checkN1(index){
	jQuery("#"+mingx_ys+index).bindpropertychange(function(){ 	
		cal_check();
	});

       
}

jQuery(zhu_ys).bind("change",function(){ 	
	cal_check();
});

function cal_check(){
	var tmp_val = "2";
	alert("11")
	for(var i=0;i<100;i++){
		if(jQuery("#"+mingx_ys+i).length>0){
			var tmp_1 = jQuery("#"+mingx_ys+i).val();
			alert("22")	
			if(tmp_1 == "1"){
				tmp_val = "1";
				i=101;
				jQuery(dis_zhuys).val("1");
				jQuery(zhu_ys+"span").val("付款且报销");
				jQuery(zhu_ys).val("1");
			}
		}else{
			i=101;
		}
	}
	alert("33 = " + tmp_val)
	if(tmp_val == "2"){
		jQuery(dis_zhuys).val("0");
		jQuery(zhu_ys+"span").val("付款");
		jQuery(zhu_ys).val("0");
	}
}