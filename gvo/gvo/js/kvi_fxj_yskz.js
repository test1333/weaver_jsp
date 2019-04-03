jQuery(document).ready(function() {
//alert(123456);
var yslx="field13309_";//预算类型
          var je="field13263_";//金额
	  var bnsyys="field13337_";//本年剩余预算
          var jzdqsyys="field13338_";//截止当前剩余预算
checkCustomize = function() {
var result = true;
var nowRow = parseInt($G("indexnum0").value) - 1;
for (var i = 0;i <= nowRow;i++){
var tmp_yslx = jQuery("#"+yslx+ i).val();
             var tmp_je = jQuery("#"+je+ i).val();
             var tmp_jzdqsyys = jQuery("#"+jzdqsyys+ i).val();
             var tmp_bnsyys= jQuery("#"+bnsyys+ i).val();
//alert("tmp_yslx = "+tmp_yslx);
//alert("tmp_je = "+tmp_je);

if(tmp_yslx=="0") {
if(Number(tmp_je)>Number(tmp_bnsyys)){
window.top.Dialog.alert("超出本年剩余预算，不可提交");
result = false;
}
}
return result;
}
}
});