
var purchaselist = "#field6523"; // 采购单
var goodsname = "field6256_"; // 商品名称
var price = "field5810_"; // 价格
var num = "field5812_"; // 数量

     $(purchaselist).bindPropertyChange(function (){ 
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var purchaselist_val = jQuery(purchaselist).val();
			xhr.open("GET","/seahonor/jsp/PurchaseToAssets.jsp?id="+purchaselist_val, false);
			xhr.onreadystatechange =	function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							var text_arr = text.split("@@@");
							for(var i=0;i<text_arr.length-1;i++){
								addRow0(0);
								var tmp_arr = text_arr[i].split("###");
								jQuery("#"+goodsname+i).val(tmp_arr[0]);
								document.getElementById(goodsname+i).readOnly=true;
								jQuery("#"+goodsname+i+"span").text(tmp_arr[1]);
								$("#"+goodsname+i+"spanimg").css("display", "none");

								jQuery("#"+price+i).val(tmp_arr[2]);
								document.getElementById(price+i).readOnly=true;
								$("#"+price+i+"span").css("display", "none");

								jQuery("#"+num+i).val(tmp_arr[3]);
								document.getElementById(num+i).readOnly=true;
								$("#"+num+i+"span").css("display", "none");
							}
						}
					}
				}
			xhr.send(null);
		}

		$("#field6523_browserbtn").attr('disabled',true);
	});


