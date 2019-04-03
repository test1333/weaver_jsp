jQuery(document).ready(function() {
//alert(123456);
var cq="field12948_";//厂区
var cbje="field12949_";//餐补金额
var cbbz="field12945_";//餐补标准
var cbbzsx="field12950_";//餐补标准上限
checkCustomize = function() {
var result = true;
var nowRow = parseInt($G("indexnum0").value) - 1;
for (var i = 0;i <= nowRow;i++){
var tmp_cq = jQuery("#"+cq+ i).val();
var tmp_cbje = jQuery("#"+cbje+ i).val();
var tmp_cbbz = jQuery("#"+cbbz+ i).val();
var tmp_cbbzsx= jQuery("#"+cbbzsx+ i).val();
//alert("tmp_cq = "+tmp_cq);
if(tmp_cq=="0") {
if(Number(tmp_cbje)>Number(tmp_cbbzsx)){
window.top.Dialog.alert("餐补金额超过餐补标准，不可提交");
result = false;
}
}
return result;
}
}
});