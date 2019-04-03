var zhu_cb = "#field13271";
var mingx_cb = "field13489_";
var dis_zhucb = "#disfield13271";
var max_res = 0;


setTimeout('myFunction()',1000);

function myFunction(){
	for(var i=0;i<200;i++){
	    if(jQuery("#"+mingx_cb+i).length>0){
	         checkM(i);
	    }
	}
}


for(var i=0;i<10;i++){
    if(jQuery("#"+mingx_cb+i).length>0){
         max_res++;
    }
}

function checkM(){
	var nowRow = parseInt($G("indexnum1").value) - 1;
	
	
	checkM1(nowRow);
	
}




function checkM1(index){
	jQuery("#"+mingx_cb+index).bind("propertychange",function(){ 	
		check();
	});

       
}

jQuery(zhu_cb).bind("change",function(){ 	
	check();
});

function check(){
	var tmp_val = "2";
//	alert("11")
	for(var i=0;i<100;i++){
		if(jQuery("#"+mingx_cb+i).length>0){
			var tmp_1 = jQuery("#"+mingx_cb+i).val();
//			alert("22")	
			if(tmp_1 == "1"){
				tmp_val = "1";
				i=101;
				jQuery(dis_zhucb).val("1");
				jQuery(zhu_cb+"span").val("标准外");
				jQuery(zhu_cb).val("1");
			}
		}else{
			i=101;
		}
	}
//	alert("33 = " + tmp_val)
	if(tmp_val == "2"){
		jQuery(dis_zhucb).val("0");
		jQuery(zhu_cb+"span").val("标准内");
		jQuery(zhu_cb).val("0");
	}
}