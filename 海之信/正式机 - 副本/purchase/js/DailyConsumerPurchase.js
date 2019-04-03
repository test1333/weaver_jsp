
	//alert(1212);
	var Name_id = "field6903_"; // 商品名称
	var sum_id = "field6905_";//库存量
	var qjxxID_id = "field6904_"; // 商品数量
	var price_id = "field6915_";//平均单价
	
	var val_id = "#field7924";//传值
	
	//String val = Util.null2String(rs.getString("val"));

	// 延迟加载1000s
	setTimeout("testa()",1000);

		//$(qj_id).bindPropertyChange(function (){   这是e8中的格式
    //    $(qj_id).bindPropertyChange(function (){ 

    function testa(){ 

		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			//var qj_id_val = jQuery(qj_id).val();
			var val_id_val = jQuery(val_id).val();
			//alert("val_id_val="+val_id_val);

			xhr.open("GET","/seahonor/purchase/jsp/DailyConsumPurchase.jsp?val="+val_id_val, false);//通过流程按钮选择的值，通过jquery把值传到jsp页面中去。
			xhr.onreadystatechange = function () {

						if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;//responseText方法是什么作用    
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);

							var text_arr = text.split("@@@");

							for(var i=0;i<text_arr.length-1;i++){

								addRow0(0);

								var tmp_arr = text_arr[i].split("###");
							
								jQuery("#"+Name_id+i).val(tmp_arr[0]);
								//document.getElementById(Name_id+i).readOnly=true;
								jQuery("#"+Name_id+i+"span").text(tmp_arr[1]);
							

								jQuery("#"+sum_id+i).val(tmp_arr[2]);
								jQuery("#"+sum_id+i+"span").text(tmp_arr[2]);

								jQuery("#"+qjxxID_id+i).val(tmp_arr[3]);
								jQuery("#"+qjxxID_id+i+"span").text(tmp_arr[3]);

								jQuery("#"+price_id+i).val(tmp_arr[4]);
								jQuery("#"+price_id+i+"span").text(tmp_arr[4]);


							/*	jQuery("#"+ActualFee_id+i).val(tmp_arr[4]);
								//这是去掉必填号的
								jQuery("#"+ActualFee_id+i+"span").text("");
*/
							}	
						}
					}
				}
			xhr.send(null);
		}
	}

			//这是E8中的格式 功能是鼠标失效  这个#field6584_是按钮字段
		//$("#field6272_browserbtn").attr('disabled',true);

		//这是E7中的格式 功能是鼠标失效
		//jQuery(qj_id).parent().find(".Browser").attr('disabled',true);
	//});


