//alert(22);
var purchasenum = "field6599_";//采购数量

//$(qj_id).bindPropertyChange(function (){   这是e8中的格式
	//找明细行
	for(var index = 0; index<200; index++){ 
		//存在明细行
		if(jQuery("#"+purchasenum+index).length>0){
			//获得修改前采购数量的值
			var tmp_1 = jQuery("#"+purchasenum+index).val();
			//把修改前的的值放到方法里面，调用方法。其中把tmp_1的值赋给tmp_x变量
			bindForUpdate(tmp_1,index);
		}else{
			index = 201;
		}
	}	

function bindForUpdate(tmp_x,index){
	//绑定存在的明细行
	$("#"+purchasenum+index).bindPropertyChange(function (){ 
		//获得修改变后的采购数量的值
		var tmp_a = jQuery("#"+purchasenum+index).val();
		//其中tmp_x是tmp_1中的值，是修改前的值，而tmp_a是修改后的值。
		if(Number(tmp_x) < Number(tmp_a)){
			//如果修改前的值（tmp_x）<修改后的值(tmp_a)，就讲修改前的值赋给采购数量，即采购数量还是之前的值。
			jQuery("#"+purchasenum+index).val(tmp_x);
			alert("修改值不能比原值大！");
		}
	});
}


