
<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var rm_id = "#field6068";       // ��ȡ����id
	var hw_id = "field5998_"; // ����
	var mc_id = "field5999_"; // ��������
	var xs_id = "field6000_"; // Ԥ������
	var je_id = "field6002_"; // Ԥ�����۽��
	var zffs_id = "field6006_"; // ԭ֧����ʽ��
                var xzffs_id = "field6007_"; // ��֧����ʽ
                var hd_id = "field6008_"; // Ԥ�����
                var fy_id = "field6101_"; // ������� 

        jQuery(rm_id).bindPropertyChange(function (){ 
        
              testa();
         })

    function testa(){ 

		var xhr = null;
		if (window.ActiveXObject) {//IE�����
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var val_id_val = jQuery(rm_id).val();
            //            alert("val_id_val = " + val_id_val);
			xhr.open("GET","/TaiSon/setFinOper.jsp?remindID="+val_id_val, false);    //ͨ�����̰�ťѡ���ֵ��ͨ��jquery��ֵ����jspҳ����ȥ��
			xhr.onreadystatechange = function () {

						if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;     //responseText������ʲô����    
						//	alert("text= " + text );

                                                        text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							
							var text_arr = text.split("@@@");
							var sum = 0;
						//	alert("text_arr.length = " + text_arr.length);

							for(var i=0;i<text_arr.length-1;i++){
								
								addRow0(0);

								var tmp_arr = text_arr[i].split("###");
								
							//	alert("0 = " + tmp_arr[0]);
							//	alert("1 = " + tmp_arr[1]);
							//	alert("2 = " + tmp_arr[2]);
							//	alert("3 = " + tmp_arr[3] );
							//	alert("4 = " + tmp_arr[4] );
							//	alert("5 = " + tmp_arr[5] );
							//	alert("6 = " + tmp_arr[6]);
							
								jQuery("#"+hw_id+i).val(tmp_arr[0]);
								jQuery("#"+hw_id+i+"span").text(tmp_arr[1]);

								jQuery("#"+mc_id+i).val(tmp_arr[2]);
								jQuery("#"+mc_id+i+"span").text(tmp_arr[2]);

								jQuery("#"+xs_id +i).val(tmp_arr[3]);			
								jQuery("#"+xs_id +i+"span").text(tmp_arr[3]);

								jQuery("#"+je_id +i).val(tmp_arr[4]);
								jQuery("#"+je_id +i+"span").text(tmp_arr[4]);

								jQuery("#"+zffs_id +i).val(tmp_arr[5]);	
							//	jQuery("#d"+zffs_id +i+"span").text(tmp_arr[5]);
								jQuery("#dis"+zffs_id +i).val(tmp_arr[5]);
								jQuery("#dis"+xzffs_id +i).val(tmp_arr[5]);
								jQuery("#"+xzffs_id +i).val(tmp_arr[5]);
      
								jQuery("#"+hd_id +i).val(tmp_arr[6]);
								jQuery("#"+hd_id +i+"span").text(tmp_arr[6]);

								jQuery("#"+fy_id +i).val(tmp_arr[7]);
								jQuery("#"+fy_id +i+"span").text(tmp_arr[8]);

							}	
							calSum(0);
						}
					}
				}
			xhr.send(null);
		}
	}

</script>















