//alert(12);
	//var qj_id = "#field6955"; // 选择采购单
	var qj_id = "#field8668"; // 选择月度日常消耗品采购相关流程
	var Name_id = "field6938_"; // 商品名称
	var qjxxID_id = "field6953_"; // 计划数量
	var qjxx_id = "field6954_"; // 计划单价
	var ycgsl_id = "field6956_"; // 已采购数量
	var unitname = "field6944_";//单位
	var catename = "field8519_";//所属类别
	var AvailableNumbers = "field9523_";//可采购数量
	var brand= "field6948_";//品牌
	var model = "field6949_";//型号
	var conf = "field6950_";//配置
	var bxfw= "field10653_";//保修范围
	var xbnf = "field8514_";//续保年费
	var ppb = "field10813_";
	var xhb = "field10814_";
	var pzb = "field10815_";
	var bxfwb = "field10816_";
	var xbnfb = "field10817_";	
	var sfyxjyz = "field10672_";


	var tmp_1 = "1231231";//tmp_1 = "1231231"随便是什么值，空字符串也行

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

			xhr.open("GET","/seahonor/purchase/jsp/PlanPurchaseOrder.jsp?id="+qj_id_val, false);//通过流程按钮选择的值，通过jquery把值传到jsp页面中去。
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

								jQuery("#"+Name_id+i).val(tmp_arr[0]);//存放id
								//document.getElementById(Name_id+i).readOnly=true;
								jQuery("#"+Name_id+i+"span").text(tmp_arr[1]);//存放名称

								//jQuery("#"+Name_id+i).val(tmp_arr[0]);
								//document.getElementById(Name_id+i).readOnly=true;
								//jQuery("#"+Name_id+i+"span").val(tmp_arr[1]);

								jQuery("#"+qjxxID_id+i).val(tmp_arr[2]);
								jQuery("#"+qjxxID_id+i+"span").text(tmp_arr[2]);
								//document.getElementById(qjxxID_id+i).readOnly=true;
								//jQuery("#"+qjxxID_id+i+"span").val("");

								jQuery("#"+ycgsl_id+i).val(tmp_arr[8]);
								jQuery("#"+ycgsl_id+i+"span").text(tmp_arr[8]);
								//document.getElementById(qjxx_id+i).readOnly=true;
								//除去感叹号，如果是只读也要再复制一次
							    //jQuery("#"+qjxx_id+i+"span").val("");
							    //alert("tmp_arr[2]="+tmp_arr[2]);
							    //alert("tmp_arr[8]="+tmp_arr[8]);
                                                            
							    var AvailableNumbers_val = Number(tmp_arr[2])-Number(tmp_arr[8]);

							    //alert("AvailableNumbers_val="+AvailableNumbers_val);

							    jQuery("#"+AvailableNumbers+i).val(AvailableNumbers_val);
							    jQuery("#"+AvailableNumbers+i+"span").text(AvailableNumbers_val);

							    jQuery("#"+qjxx_id+i).val(tmp_arr[3]);
								jQuery("#"+qjxx_id+i+"span").text(tmp_arr[3]);

								jQuery("#"+unitname+i).val(tmp_arr[5]);
								jQuery("#"+unitname+i+"span").text(tmp_arr[4]); 
  
                                                       jQuery("#"+catename+i).val(tmp_arr[7]);
								jQuery("#"+catename+i+"span").text(tmp_arr[6]);
								
								jQuery("#"+brand+i).val(tmp_arr[9]);
									jQuery("#"+brand+i+"span").text(tmp_arr[9]);
									jQuery("#"+ppb+i).val(tmp_arr[9]);
									jQuery("#"+ppb+i+"span").text(tmp_arr[9]);
								jQuery("#"+model+i).val(tmp_arr[10]);
									jQuery("#"+model+i+"span").text(tmp_arr[10]);
										jQuery("#"+xhb+i).val(tmp_arr[10]);
									jQuery("#"+xhb+i+"span").text(tmp_arr[10]);
								jQuery("#"+conf+i).val(tmp_arr[11]);
								jQuery("#"+conf+i+"span").text(tmp_arr[11]);
									jQuery("#"+pzb+i).val(tmp_arr[11]);
								jQuery("#"+pzb+i+"span").text(tmp_arr[11]);
								jQuery("#"+bxfw+i).val(tmp_arr[12]);
									jQuery("#"+bxfw+i+"span").text(tmp_arr[12]);
										jQuery("#"+bxfwb+i).val(tmp_arr[12]);
									jQuery("#"+bxfwb+i+"span").text(tmp_arr[12]);
								jQuery("#"+xbnf+i).val(tmp_arr[13]);
									jQuery("#"+xbnf+i+"span").text(tmp_arr[13]);
										jQuery("#"+xbnfb+i).val(tmp_arr[13]);
									jQuery("#"+xbnfb+i+"span").text(tmp_arr[13]);
        
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
		//$("#field6955_browserbtn").attr('disabled',true);
		$("#field8668_browserbtn").attr('disabled',true);

		//这是E7中的格式 功能是鼠标失效
		//jQuery(qj_id).parent().find(".Browser").attr('disabled',true);
	});
