//alert(12);
	//var qj_id = "#field6955"; // ѡ��ɹ���
	var qj_id = "#field8668"; // ѡ���¶��ճ�����Ʒ�ɹ��������
	var Name_id = "field6938_"; // ��Ʒ����
	var qjxxID_id = "field6953_"; // �ƻ�����
	var qjxx_id = "field6954_"; // �ƻ�����
	var ycgsl_id = "field6956_"; // �Ѳɹ�����
	var unitname = "field6944_";//��λ
	var catename = "field8519_";//�������
	var AvailableNumbers = "field9523_";//�ɲɹ�����
	var brand= "field6948_";//Ʒ��
	var model = "field6949_";//�ͺ�
	var conf = "field6950_";//����
	var bxfw= "field10653_";//���޷�Χ
	var xbnf = "field8514_";//�������
	var ppb = "field10813_";
	var xhb = "field10814_";
	var pzb = "field10815_";
	var bxfwb = "field10816_";
	var xbnfb = "field10817_";	
	var sfyxjyz = "field10672_";


	var tmp_1 = "1231231";//tmp_1 = "1231231"�����ʲôֵ�����ַ���Ҳ��

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

			xhr.open("GET","/seahonor/purchase/jsp/PlanPurchaseOrder.jsp?id="+qj_id_val, false);//ͨ�����̰�ťѡ���ֵ��ͨ��jquery��ֵ����jspҳ����ȥ��
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

								jQuery("#"+Name_id+i).val(tmp_arr[0]);//���id
								//document.getElementById(Name_id+i).readOnly=true;
								jQuery("#"+Name_id+i+"span").text(tmp_arr[1]);//�������

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
								//��ȥ��̾�ţ������ֻ��ҲҪ�ٸ���һ��
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
		//$("#field6955_browserbtn").attr('disabled',true);
		$("#field8668_browserbtn").attr('disabled',true);

		//����E7�еĸ�ʽ ���������ʧЧ
		//jQuery(qj_id).parent().find(".Browser").attr('disabled',true);
	});
