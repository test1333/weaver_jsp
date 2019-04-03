
	//alert(22);
	//var qj_id = "#field8428"; // 选择办公设备采购单
	var qj_id = "#field8669"; // 选择办公设备采购单
	var Name_id = "field8438_"; // 商品名称
	var qjxxID_id = "field8457_"; // 计划数量
	var qjxx_id = "field8447_"; // 计划单价
	var ycgsl_id = "field8454_"; // 已采购数量

	var tmp_1 = "1231231";

		//$(qj_id).bindPropertyChange(function (){   这是e8中的格式
        $(qj_id).bindPropertyChange(function (){ 
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var qj_id_val = jQuery(qj_id).val();

		//	alert("qj_id_val= "+qj_id_val);

			//alert("gw_id_val= "+gw_id_val);
			//xhr.open("GET","/gvo/js/GVO_ShangGangZ2.jsp?id="+qj_id_val, false);//通过流程按钮选择的值，通过jquery把值传到jsp页面中去。

			xhr.open("GET","/seahonor/purchase/jsp/EquipPurchaseOrder.jsp?id="+qj_id_val, false);//通过流程按钮选择的值，通过jquery把值传到jsp页面中去。
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;//responseText方法是什么作用    
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);
							//25###签字水笔###63###3.00@@@24###饮水机###222###300.00@@@
							//alert("text= " + text);
							if(text != tmp_1){
								tmp_1 = text;   //这是判断二次触发的方法，

								var text_arr = text.split("@@@");
								//25###签字水笔###63###3.00@@@24###饮水机###222###300.00@@@通过"@@@"分割为25###签字水笔###63###3.00、
								//24###饮水机###222###300.00以及空3组
								//alert("len= " + text_arr.length);
								//alert("text_arr= " + text_arr);

								//var text_arr = text.split("###");

								for(var i=0;i<text_arr.length-1;i++){

									addRow0(0);

									var tmp_arr = text_arr[i].split("###");
									//25###签字水笔###63###3.00通过"###"分为25、签字水笔、63、3.00 四组
									//alert("tmp_arr = "+text_arr[i]);

									jQuery("#"+Name_id+i).val(tmp_arr[0]);
									//document.getElementById(Name_id+i).readOnly=true;
									jQuery("#"+Name_id+i+"span").text(tmp_arr[1]);

									//jQuery("#"+Name_id+i).val(tmp_arr[0]);
									//document.getElementById(Name_id+i).readOnly=true;
									//jQuery("#"+Name_id+i+"span").val(tmp_arr[1]);

									jQuery("#"+qjxxID_id+i).val(tmp_arr[2]);
									jQuery("#"+qjxxID_id+i+"span").text(tmp_arr[2]);
									//document.getElementById(qjxxID_id+i).readOnly=true;
									//jQuery("#"+qjxxID_id+i+"span").val("");

									jQuery("#"+ycgsl_id+i).val(tmp_arr[4]);
									jQuery("#"+ycgsl_id+i+"span").text(tmp_arr[4]);
									//document.getElementById(qjxx_id+i).readOnly=true;
									//除去感叹号，如果是只读也要再复制一次
								    //jQuery("#"+qjxx_id+i+"span").val("");

								    jQuery("#"+qjxx_id+i).val(tmp_arr[3]);
									jQuery("#"+qjxx_id+i+"span").text(tmp_arr[3]);

								/*	jQuery("#"+SS_id+i).val(tmp_arr[2]);
									//alert("SS_id1 = "+SS_id);
									document.getElementById(SS_id+i).readOnly=true;
									//alert("SS_id2 = "+SS_id);
									//除去感叹号，如果是只读也要再复制一次
								    //jQuery("#"+SS_id+i+"span").val("");*/

								}
							}
						}
					}
				}
			xhr.send(null);
		}

		//这是E8中的格式 功能是鼠标失效  这个#field6584_是按钮字段
		//$("#field8428_browserbtn").attr('disabled',true);
		$("#field8669_browserbtn").attr('disabled',true);
		//这是E7中的格式 功能是鼠标失效
		//jQuery(qj_id).parent().find(".Browser").attr('disabled',true);
	});


