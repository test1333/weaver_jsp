
	//alert(22);
	//var qj_id = "#field8428"; // ѡ��칫�豸�ɹ���
	var qj_id = "#field8669"; // ѡ��칫�豸�ɹ���
	var Name_id = "field8438_"; // ��Ʒ����
	var qjxxID_id = "field8457_"; // �ƻ�����
	var qjxx_id = "field8447_"; // �ƻ�����
	var ycgsl_id = "field8454_"; // �Ѳɹ�����

	var tmp_1 = "1231231";

		//$(qj_id).bindPropertyChange(function (){   ����e8�еĸ�ʽ
        $(qj_id).bindPropertyChange(function (){ 
		var xhr = null;
		if (window.ActiveXObject) {//IE�����
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var qj_id_val = jQuery(qj_id).val();

		//	alert("qj_id_val= "+qj_id_val);

			//alert("gw_id_val= "+gw_id_val);
			//xhr.open("GET","/gvo/js/GVO_ShangGangZ2.jsp?id="+qj_id_val, false);//ͨ�����̰�ťѡ���ֵ��ͨ��jquery��ֵ����jspҳ����ȥ��

			xhr.open("GET","/seahonor/purchase/jsp/EquipPurchaseOrder.jsp?id="+qj_id_val, false);//ͨ�����̰�ťѡ���ֵ��ͨ��jquery��ֵ����jspҳ����ȥ��
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;//responseText������ʲô����    
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);
							//25###ǩ��ˮ��###63###3.00@@@24###��ˮ��###222###300.00@@@
							//alert("text= " + text);
							if(text != tmp_1){
								tmp_1 = text;   //�����ж϶��δ����ķ�����

								var text_arr = text.split("@@@");
								//25###ǩ��ˮ��###63###3.00@@@24###��ˮ��###222###300.00@@@ͨ��"@@@"�ָ�Ϊ25###ǩ��ˮ��###63###3.00��
								//24###��ˮ��###222###300.00�Լ���3��
								//alert("len= " + text_arr.length);
								//alert("text_arr= " + text_arr);

								//var text_arr = text.split("###");

								for(var i=0;i<text_arr.length-1;i++){

									addRow0(0);

									var tmp_arr = text_arr[i].split("###");
									//25###ǩ��ˮ��###63###3.00ͨ��"###"��Ϊ25��ǩ��ˮ�ʡ�63��3.00 ����
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
									//��ȥ��̾�ţ������ֻ��ҲҪ�ٸ���һ��
								    //jQuery("#"+qjxx_id+i+"span").val("");

								    jQuery("#"+qjxx_id+i).val(tmp_arr[3]);
									jQuery("#"+qjxx_id+i+"span").text(tmp_arr[3]);

								/*	jQuery("#"+SS_id+i).val(tmp_arr[2]);
									//alert("SS_id1 = "+SS_id);
									document.getElementById(SS_id+i).readOnly=true;
									//alert("SS_id2 = "+SS_id);
									//��ȥ��̾�ţ������ֻ��ҲҪ�ٸ���һ��
								    //jQuery("#"+SS_id+i+"span").val("");*/

								}
							}
						}
					}
				}
			xhr.send(null);
		}

		//����E8�еĸ�ʽ ���������ʧЧ  ���#field6584_�ǰ�ť�ֶ�
		//$("#field8428_browserbtn").attr('disabled',true);
		$("#field8669_browserbtn").attr('disabled',true);
		//����E7�еĸ�ʽ ���������ʧЧ
		//jQuery(qj_id).parent().find(".Browser").attr('disabled',true);
	});


