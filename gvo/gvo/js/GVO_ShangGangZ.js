
var gw_id = "#field12589"; // 岗位技能
var kvi_cou = "field12336_"; // 培训课程
//alert(123456);


     //jQuery(gw_id).bind("propertychange",function(){
	 jQuery(gw_id).bindPropertyChange(function () {
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var gw_id_val = jQuery(gw_id).val();
			//alert("gw_id_val= "+gw_id_val);
			xhr.open("GET","/gvo/js/GVO_ShangGangZ2.jsp?id="+gw_id_val, false);
			xhr.onreadystatechange =	function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);
							var text_arr = text.split("###");

							for(var i=0;i<text_arr.length-1;i++){

								addRow0(0);

								var tmp_arr = text_arr[i].split("###");

								jQuery("#"+kvi_cou+i).val(tmp_arr[0]);
								document.getElementById(kvi_cou+i).readOnly=true;
								//除去感叹号，如果是只读也要再复制一次
								jQuery("#"+kvi_cou+i+"span").val("");

							}
						}
					}
				}
			xhr.send(null);
		}

		jQuery(gw_id).parent().find(".Browser").attr('disabled',true);
	});


