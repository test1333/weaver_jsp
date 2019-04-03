
<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var rm_id = "#field6068";       // 获取申请id
	var hw_id = "field5998_"; // 货号
	var mc_id = "field5999_"; // 货物名称
	var xs_id = "field6000_"; // 预估箱数
	var je_id = "field6002_"; // 预估销售金额
	var zffs_id = "field6006_"; // 原支付方式·
                var xzffs_id = "field6007_"; // 新支付方式
                var hd_id = "field6008_"; // 预估活动金额·
                var fy_id = "field6101_"; // 申请费用 

        jQuery(rm_id).bindPropertyChange(function (){ 
        
              testa();
         })

    function testa(){ 

		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var val_id_val = jQuery(rm_id).val();
            //            alert("val_id_val = " + val_id_val);
			xhr.open("GET","/TaiSon/setFinOper.jsp?remindID="+val_id_val, false);    //通过流程按钮选择的值，通过jquery把值传到jsp页面中去。
			xhr.onreadystatechange = function () {

						if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;     //responseText方法是什么作用    
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















