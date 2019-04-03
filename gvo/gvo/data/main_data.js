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

	jQuery("input[id='"+s_sm+nowRow+"']").bind("blur",function(){
//alert("test1");
	    var s_sm_val = jQuery("#"+s_sm+nowRow).val();
	    var all_sm_val = jQuery("#"+all_sm+nowRow).val();
	    if(s_sm_val.length>0&&all_sm_val.length>0){
		// 出错 
		if(Number(s_sm_val)>=Number(all_sm_val)){
		    window.top.Dialog.alert("最小货架寿命需小于总货架寿命");
		    jQuery("#"+s_sm+nowRow).val("");
                }
            }
	});
        jQuery("input[id='"+all_sm+nowRow+"']").bind("blur",function(){
//alert("test2");
	    var all_sm_val = jQuery("#"+all_sm+nowRow).val();
	    var s_sm_val = jQuery("#"+s_sm+nowRow).val();
            //alert(all_sm_val);
            //alert(s_sm_val);
	    if(s_sm_val.length>0&&all_sm_val.length>0){
		// 出错 
		if(Number(s_sm_val)>=Number(all_sm_val)){
		    window.top.Dialog.alert("最小货架寿命需小于总货架寿命");
		    jQuery("#"+all_sm+nowRow).val("");
                }
            }
	});
	
}