jQuery(document).ready(function() {
//alert(123456);
	  var htzje="field13306_";//合同总金额
          var bcfke="field13329_";//本次付款额（OC）
          var ljyfk="field13307_";//累计已付款
 
checkCustomize = function() {
var result = true;
var nowRow = parseInt($G("indexnum0").value) - 1;
for (var i = 0;i <= nowRow;i++){
var tmp_htzje = jQuery("#"+htzje+ i).val();
             var tmp_bcfke = jQuery("#"+bcfke+ i).val();
             var tmp_ljyfk = jQuery("#"+ljyfk+ i).val();
             
//alert("tmp_htzje = "+tmp_htzje);
if(tmp_htzje!=null&&tmp_htzje!=0){
if(Number(tmp_bcfke)+Number(tmp_ljyfk)>Number(tmp_htzje)){
window.top.Dialog.alert("已超合同总额，不可提交");
result = false;
}
}


return result;
}
}
});