
var gw_id = "#field16565"; // 岗位技能
var dn_id = "#field16566"; // 多能工技能
var kvi_cou = "field16509_"; // 培训课程
//alert(123456);
var ids = 0;

     jQuery(gw_id).bind("propertychange",function(){
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var gw_id_val = jQuery(gw_id).val();
			//alert("gw_id_val= "+gw_id_val);
			xhr.open("GET","/gvo/js/GVO_sgz2.jsp?id="+gw_id_val, false);
			xhr.onreadystatechange =	function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);
							var text_arr_i = text.split("###");
							var tmp_i = 0;
							//alert("ids="+ids);
							//alert("length="+text_arr_i.length);
							//var tmp_1=text_arr_i.length+ids-1;
							//alert("tmp_1="+tmp_1);
							for(var i=ids;i<text_arr_i.length-1+ids;i++){

								addRow0(0);
								//alert("i="+i);
								var tmp_arr_i = text_arr_i[tmp_i].split("###");

								jQuery("#"+kvi_cou+i).val(tmp_arr_i[0]);
								document.getElementById(kvi_cou+i).readOnly=true;
								//除去感叹号，如果是只读也要再复制一次
								jQuery("#"+kvi_cou+i+"span").val("");
								tmp_i++;
								//ids++;
							}
							ids=ids+text_arr_i.length-1;
							//alert("ids="+ids);
						}
					}
				}
			xhr.send(null);
		}

		jQuery(gw_id).parent().find(".Browser").attr('disabled',true);
	});



     jQuery(dn_id).bind("propertychange",function(){
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var dn_id_val = jQuery(dn_id).val();
			//alert("gw_id_val= "+gw_id_val);
			xhr.open("GET","/gvo/js/GVO_sgz2.jsp?id="+dn_id_val, false);
			xhr.onreadystatechange =	function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);
							var text_arr_j = text.split("###");
							var tmp_j = 0;
							//alert("ids="+ids);
							//alert("length="+text_arr_j.length);
							//var tmp_2=text_arr_j.length+ids-1;
							//alert("tmp_2="+tmp_2);
							for(var j=ids;j<text_arr_j.length-1+ids;j++){

								addRow0(0);
								//alert("j="+j);
								var tmp_arr_j = text_arr_j[tmp_j].split("###");
								jQuery("#"+kvi_cou+j).val(tmp_arr_j[0]);
								document.getElementById(kvi_cou+j).readOnly=true;
								//除去感叹号，如果是只读也要再复制一次
								jQuery("#"+kvi_cou+j+"span").val("");
								tmp_j++;
								//ids++;
							}
							ids=ids+text_arr_j.length-1;
							//alert("ids="+ids);
						}
					}
				}
			xhr.send(null);
		}

		jQuery(dn_id).parent().find(".Browser").attr('disabled',true);
	});



