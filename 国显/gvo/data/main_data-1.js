// 价格控制 
var price = "field7505_";
// 价格确定
var price_1 = "field7486_";

// 最小剩余货架寿命
var s_sm = "field7612_";
// 总货架寿命
var all_sm = "field7673_";


function test1(){	
	var nowRow = parseInt($G("indexnum0").value) - 1;
	
	var tmp_price = price + nowRow;

	jQuery("input[id='"+tmp_price+"']").bind("propertychange",function(){
	    var price_val = jQuery("#"+tmp_price).val();
            if(price_val=="V"){
                // 文本赋值
		// jQuery("#"+price_1+nowRow).val("2");

                // 按钮赋值
                 jQuery("#"+price_1+nowRow).val("2");    // 后台值  隐藏文本框
		 jQuery("#"+price_1+nowRow+"span").html("xxxxx");  // 显示值
	    }else if(price_val=="S"){
                jQuery("#"+price_1+nowRow).val("3");
            }
	});

	jQuery("input[id='"+s_sm+nowRow+"']").bind("propertychange",function(){
	    var s_sm_val = jQuery("#"+s_sm+nowRow).val();
	    var all_sm_val = jQuery("#"+all_sm+nowRow).val();
	    if(s_sm_val.length>0&&all_sm_val.length>0){
		// 出错 
		if(Number(s_sm_val)>all_sm_val){
		    window.top.Dialog.alert("最小货架寿命需小于总货架寿命");
		    jQuery("#"+s_sm+nowRow).val("");
                }
            }
	});
	
	jQuery("input[id='"+all_sm+nowRow+"']").bind("propertychange",function(){
	    var price_val = jQuery("#"+tmp_price).val();
            
	});
	
}