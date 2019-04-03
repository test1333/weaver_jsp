jQuery(document).ready(function() {
//alert(123456);
	  var grqk = "#field13222";//个人欠款
          var grhkje = "#field13227";//个人还款金额
 
checkCustomize = function() {
var result = true;

var grqk_val = jQuery(grqk).val();
var grhkje_val = jQuery(grhkje).val();


//alert("grhkje_val = "+grhkje_val);

if(grqk_val!=null&&grhkje_val!=0){
if(Number(grhkje_val)>Number(grqk_val)){
window.top.Dialog.alert("已超个人欠款，不可提交");
result = false;
}


return result;
}
}
});