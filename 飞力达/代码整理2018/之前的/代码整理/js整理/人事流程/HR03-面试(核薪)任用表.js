<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var yzryx="#field6284";
var yzrym="#field6285";
var yzryxm="#field7084";
jQuery(document).ready(function() {
		jQuery("#field10843").bindPropertyChange(function () {
                         var ygz=jQuery("#field10843").val();
			jQuery("#field9045").val(ygz);
          		//jQuery("#field9045"+"span").text(ygz);
                })     
	checkCustomize = function() {
             var yzryx_val=jQuery(yzryx).val();
             var yzrym_val=jQuery(yzrym).val();
             var yzryxm_val=yzryx_val+yzrym_val;
             jQuery(yzryxm).val(yzryxm_val);
jQuery(yzryxm+"span").text(yzryxm_val);

              var result=true;                  
             var ygz=jQuery("#field8221").val();
             if(ygz=='正式工'){
                   var ygz=jQuery("#field6250").val();
                         if(ygz==''){
                         alert("员工组为正式工，参加工作日期不能为空，请检查！");  
                          result=true;                           
                                          }      
               }
    return result;
}
var identity = "field9021";

var num1 = "field9077";
var num2 = "field9078";
var num3 = "field9079";
var num4 = "field9080";
var num5 = "field9081";
var num6 = "field9082";
var num7 = "field9083";
//明细1
var XXQR = "field6687_";
var XXZR = "field6688_";
var BYYX = "field6689_";
var ZY = "field6690_";
var XL = "field8663_";
var XLBM = "field8664_";
var XW = "field8665_";
var XWBM = "field8666_";
var DD = "field8686_";
var RXZK = "field8667_";
var RXZKBM = "field8668_";
var BYZK = "field8669_";
var BYZKBM = "field8670_";
var times=0;

//明细2
var ybrgx_dt2 = "field6944_";
var xm_dt2 = "field6945_";
var zjlb_dt2 = "field8684_";
var zjhm_dt2 = "field6947_";
var csrq_dt2 = "field6948_";
var xl_dt2 = "field8685_";
var zy_dt2 = "field6950_";
var gzdw_dt2 = "field6951_";
var zjlbbm_dt2 = "field8687_";
var xlbm_dt2 = "field8688_";
var lxdh_dt2 = "field6952_";
var times_dt2=0;

//明细3
var GZQR3="field6953_";
var GZZR3="field6954_";
var GSMC3="field6955_";
var DD3="field6956_";
var ZW3="field6957_";
var XZ3="field9102_";
var ZGXM3="field6959_";
var ZGZW3="field6960_";
var LXDH3="field6961_";
var LZYY3="field6962_";
var times3=0;

//明细4
var PXQS4="field6963_";
var PXQZ4="field6964_";
var PXJG4="field6965_";
var PXNR4="field6966_";
var ZGZS4="field6967_";
var ZGZSDJ4="field6968_";
var ZYZS4="field6969_";
var ZYZSDJ4="field6970_";
var PFRQ4="field6971_";
var ZSYXQ4="field6972_";
var times4=0;

//明细5
var ZSYXQ5="field6973_";
var WYDJ5="field6974_";
var ZSMC5="field6975_";
var HZSJ5="field6977_";
var MQSLD5="field8682_";
var MQSLDBM5="field8981_";
var ZSMCBM5="field8683_";
var WYDJBM5="field8982_";
var times5=0;


//明细6
var JSJCZRJ6="field6982_";
var ZSMC6="field6983_";
var ZSDJ6="field6984_";
var HZSJ6="field6985_";
var times6=0;


//明细7
var QTZS7="field6989_";
var ZSMC7="field6986_";
var ZSDJ7="field6987_";
var HZSJ7="field6988_";
var times7=0;

//根据证件号码带出人力需求申请单时填写各个明细信息数据
     jQuery("#"+identity).bindPropertyChange(function (){
                var index=0;    
                if( times != 0){
                  index = times -1;
                }
                if(jQuery("#field6687_"+index).length>0){
                      //alert(1);
                      jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                      deleteRow0(0);                                                               
                }
                if(times == 0){
                    times = jQuery("#"+num1).val();
                }

                //明细2
                var index2=0;
                if( times_dt2 != 0){
                 index2 = times_dt2 -1;
           		}
                if(jQuery("#field6944_"+index2).length>0){
                     // alert(2);
                      jQuery("[name = check_node_1]:checkbox").attr("checked", true);
                    deleteRow1(1);                                                               
                }  

                if(times_dt2 == 0){
                    times_dt2 = jQuery("#"+num2).val();
                }

               //明细3
                var index3=0;
                if( times3!= 0){
                 index3= times3-1;
           		}
                if(jQuery("#field6953_"+index3).length>0){
                     // alert(3);
                      jQuery("[name = check_node_2]:checkbox").attr("checked", true);
                    deleteRow2(2);                                                               
                }  

                if(times3== 0){
                    times3= jQuery("#"+num3).val();
                }

               //明细4
                var index4=0;
                if( times4!= 0){
                 index4= times4-1;
           		}
                if(jQuery("#field6963_"+index4).length>0){
                     // alert(3);
                      jQuery("[name = check_node_3]:checkbox").attr("checked", true);
                    deleteRow3(3);                                                               
                }  

                if(times4== 0){
                    times4= jQuery("#"+num4).val();
                }

               //明细5
                var index5=0;
                if( times5!= 0){
                 index5= times5-1;
           		}
                if(jQuery("#field6973_"+index5).length>0){
                     // alert(5);
                      jQuery("[name = check_node_4]:checkbox").attr("checked", true);
                    deleteRow4(4);                                                               
                }  

                if(times5== 0){
                    times5= jQuery("#"+num5).val();
                }

               //明细6
                var index6=0;
                if( times6!= 0){
                 index6= times6-1;
           		}
                if(jQuery("#field6982_"+index6).length>0){
                     // alert(6);
                      jQuery("[name = check_node_5]:checkbox").attr("checked", true);
                    deleteRow5(5);                                                               
                }  

                if(times6== 0){
                    times6= jQuery("#"+num6).val();
                }

               //明细7
                var index7=0;
                if( times7!= 0){
                 index7= times7-1;
           		}
                if(jQuery("#field6989_"+index7).length>0){
                     // alert(7);
                      jQuery("[name = check_node_6]:checkbox").attr("checked", true);
                    deleteRow6(6);                                                               
                }  

                if(times7== 0){
                    times7= jQuery("#"+num7).val();
                }


              
		var xhr = null;
		if (window.ActiveXObject) {
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var identity_val = jQuery("#"+identity).val();
                        //alert("identity_val="+identity_val);
			xhr.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=1",false);
			xhr.onreadystatechange =function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                        //alert("times1="+times);
							for(var i=times;i<eval(text_arr.length+"-"+1+"+"+times);i++){
								addRow0(0);
								var tmp_arr = text_arr[eval(i+"-"+times)].split("###");
                                                                //alert("tmp_arr[0]"+tmp_arr[0]);
								jQuery("#"+XXQR+i).val(tmp_arr[0]);
								jQuery("#"+XXQR+i+"span").text(tmp_arr[0]);

								jQuery("#"+XXZR +i).val(tmp_arr[1]);
								jQuery("#"+XXZR +i+"span").text(tmp_arr[1]);

								jQuery("#"+BYYX +i).val(tmp_arr[2]);
								jQuery("#"+BYYX +i+"span").text(tmp_arr[2]);

								jQuery("#"+ZY +i).val(tmp_arr[3]);
								jQuery("#"+ZY +i+"span").text(tmp_arr[3]);

								jQuery("#"+XL +i).val(tmp_arr[4]);
								jQuery("#"+XL +i+"span").text(tmp_arr[4]);

								jQuery("#"+XLBM +i).val(tmp_arr[5]);
								jQuery("#"+XLBM +i+"span").text(tmp_arr[5]);

								jQuery("#"+XW +i).val(tmp_arr[6]);
								jQuery("#"+XW +i+"span").text(tmp_arr[6]);

								jQuery("#"+XWBM +i).val(tmp_arr[7]);
								jQuery("#"+XWBM +i+"span").text(tmp_arr[7]);

								jQuery("#"+DD +i).val(tmp_arr[8]);
								jQuery("#"+DD +i+"span").text(tmp_arr[8]);

								jQuery("#"+RXZK +i).val(tmp_arr[9]);
								jQuery("#"+RXZK +i+"span").text(tmp_arr[9]);

								jQuery("#"+RXZKBM +i).val(tmp_arr[10]);
								jQuery("#"+RXZKBM +i+"span").text(tmp_arr[10]);

								jQuery("#"+BYZK +i).val(tmp_arr[11]);
								jQuery("#"+BYZK +i+"span").text(tmp_arr[11]);

								jQuery("#"+BYZKBM +i).val(tmp_arr[12]);
								jQuery("#"+BYZKBM +i+"span").text(tmp_arr[12]);
                                                                
							}
                            times = eval(times+"+"+text_arr.length+"-"+1)
                            //alert("times2="+times);
						}
					}
				}
			xhr.send(null);
		}
		var xhr2 = null;
		if (window.ActiveXObject) {
			xhr2 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr2= new XMLHttpRequest();
		}
		if (null != xhr2) {
			var identity_val = jQuery("#"+identity).val();
                        //alert("identity_val="+identity_val);
			xhr2.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=2",false);
			xhr2.onreadystatechange =function () {
					if (xhr2.readyState == 4) {
						if (xhr2.status == 200) {
							var text = xhr2.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                         //alert("times_dt2="+times_dt2);
							for(var i=times_dt2;i<eval(text_arr.length+"-"+1+"+"+times_dt2);i++){
								addRow1(1);
								var tmp_arr = text_arr[eval(i+"-"+times_dt2)].split("###");
                                                                //alert("tmp_arr[0]"+tmp_arr[0]);
                                                               // alert("#"+ybrgx_dt2+i);
								jQuery("#"+ybrgx_dt2+i).val(tmp_arr[0]);
								jQuery("#"+ybrgx_dt2+i+"span").text(tmp_arr[0]);

								jQuery("#"+xm_dt2 +i).val(tmp_arr[1]);
								jQuery("#"+xm_dt2 +i+"span").text(tmp_arr[1]);

								jQuery("#"+zjlb_dt2 +i).val(tmp_arr[2]);
								jQuery("#"+zjlb_dt2 +i+"span").text(tmp_arr[2]);

								jQuery("#"+zjhm_dt2  +i).val(tmp_arr[3]);
								jQuery("#"+zjhm_dt2 +i+"span").text(tmp_arr[3]);

								jQuery("#"+csrq_dt2  +i).val(tmp_arr[4]);
								jQuery("#"+csrq_dt2  +i+"span").text(tmp_arr[4]);

								jQuery("#"+xl_dt2  +i).val(tmp_arr[5]);
								jQuery("#"+xl_dt2  +i+"span").text(tmp_arr[5]);

								jQuery("#"+zy_dt2  +i).val(tmp_arr[6]);
								jQuery("#"+zy_dt2  +i+"span").text(tmp_arr[6]);

								jQuery("#"+gzdw_dt2  +i).val(tmp_arr[7]);
								jQuery("#"+gzdw_dt2  +i+"span").text(tmp_arr[7]);

								jQuery("#"+zjlbbm_dt2  +i).val(tmp_arr[8]);
								jQuery("#"+zjlbbm_dt2  +i+"span").text(tmp_arr[8]);

								jQuery("#"+xlbm_dt2  +i).val(tmp_arr[9]);
								jQuery("#"+xlbm_dt2  +i+"span").text(tmp_arr[9]);

								jQuery("#"+lxdh_dt2  +i).val(tmp_arr[10]);
								jQuery("#"+lxdh_dt2  +i+"span").text(tmp_arr[10]);
						                                                           
							}
                            times_dt2 = eval(times_dt2+"+"+text_arr.length+"-"+1)
                           // alert("times_dt2="+times_dt2);
						}
					}
				}
			xhr2.send(null);
		}

		var xhr3 = null;
		if (window.ActiveXObject) {
			xhr3 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr3= new XMLHttpRequest();
		}
		if (null != xhr3) {
			var identity_val = jQuery("#"+identity).val();
                        //alert("identity_val="+identity_val);
			xhr3.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=3",false);
			xhr3.onreadystatechange =function () {
					if (xhr3.readyState == 4) {
						if (xhr3.status == 200) {
							var text = xhr3.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                         //alert("times3="+times3);
							for(var i=times3;i<eval(text_arr.length+"-"+1+"+"+times3);i++){
								addRow2(2);
								var tmp_arr = text_arr[eval(i+"-"+times3)].split("###");
							        jQuery("#"+GZQR3+i).val(tmp_arr[0]);
								jQuery("#"+GZQR3+i+"span").text(tmp_arr[0]);

								jQuery("#"+GZZR3+i).val(tmp_arr[1]);
								jQuery("#"+GZZR3+i+"span").text(tmp_arr[1]);

								jQuery("#"+GSMC3+i).val(tmp_arr[2]);
								jQuery("#"+GSMC3+i+"span").text(tmp_arr[2]);

								jQuery("#"+DD3+i).val(tmp_arr[3]);
								jQuery("#"+DD3+i+"span").text(tmp_arr[3]);

								jQuery("#"+ZW3+i).val(tmp_arr[4]);
								jQuery("#"+ZW3+i+"span").text(tmp_arr[4]);

								jQuery("#"+XZ3+i).val(tmp_arr[5]);
								jQuery("#"+XZ3+i+"span").text(tmp_arr[5]);

								jQuery("#"+ZGXM3+i).val(tmp_arr[6]);
								jQuery("#"+ZGXM3+i+"span").text(tmp_arr[6]);

								jQuery("#"+ZGZW3+i).val(tmp_arr[7]);
								jQuery("#"+ZGZW3+i+"span").text(tmp_arr[7]);

								jQuery("#"+LXDH3+i).val(tmp_arr[8]);
								jQuery("#"+LXDH3+i+"span").text(tmp_arr[8]);

								jQuery("#"+LZYY3+i).val(tmp_arr[9]);
								jQuery("#"+LZYY3+i+"span").text(tmp_arr[9]);
						                                                           
							}
                          times3= eval(times3+"+"+text_arr.length+"-"+1)
                          // alert("times3="+times3);
						}
					}
				}
			xhr3.send(null);
		}

var xhr4 = null;
		if (window.ActiveXObject) {
			xhr4 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr4= new XMLHttpRequest();
		}
		if (null != xhr4) {
			var identity_val = jQuery("#"+identity).val();
                        //alert("identity_val="+identity_val);
			xhr4.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=4",false);
			xhr4.onreadystatechange =function () {
					if (xhr4.readyState == 4) {
						if (xhr4.status == 200) {
							var text = xhr4.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                         //alert("times4="+times4);
							for(var i=times4;i<eval(text_arr.length+"-"+1+"+"+times4);i++){
								addRow3(3);
								var tmp_arr = text_arr[eval(i+"-"+times4)].split("###");
                                                                //alert("tmp_arr[0]="+tmp_arr[0]);
                                                                //alert("#"+PXQS4+i);
							        jQuery("#"+PXQS4+i).val(tmp_arr[0]);
								jQuery("#"+PXQS4+i+"span").text(tmp_arr[0]);  

								jQuery("#"+PXQZ4+i).val(tmp_arr[1]);
								jQuery("#"+PXQZ4+i+"span").text(tmp_arr[1]);

								jQuery("#"+PXJG4+i).val(tmp_arr[2]);
								jQuery("#"+PXJG4+i+"span").text(tmp_arr[2]);

								jQuery("#"+PXNR4+i).val(tmp_arr[3]);
								jQuery("#"+PXNR4+i+"span").text(tmp_arr[3]);

								jQuery("#"+ZGZS4+i).val(tmp_arr[4]);
								jQuery("#"+ZGZS4+i+"span").text(tmp_arr[4]);

								jQuery("#"+ZGZSDJ4+i).val(tmp_arr[5]);
								jQuery("#"+ZGZSDJ4+i+"span").text(tmp_arr[5]);

								jQuery("#"+ZYZS4+i).val(tmp_arr[6]);
								jQuery("#"+ZYZS4+i+"span").text(tmp_arr[6]);

								jQuery("#"+ZYZSDJ4+i).val(tmp_arr[7]);
								jQuery("#"+ZYZSDJ4+i+"span").text(tmp_arr[7]);

								jQuery("#"+PFRQ4+i).val(tmp_arr[8]);
								jQuery("#"+PFRQ4+i+"span").text(tmp_arr[8]);

								jQuery("#"+ZSYXQ4+i).val(tmp_arr[9]);
								jQuery("#"+ZSYXQ4+i+"span").text(tmp_arr[9]);                                                
							}
                         times4= eval(times4+"+"+text_arr.length+"-"+1)
                         //alert("times4="+times4);
						}
					}
				}
			xhr4.send(null);
		}

var xhr5 = null;
		if (window.ActiveXObject) {
			xhr5 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr5= new XMLHttpRequest();
		}
		if (null != xhr5) {
			var identity_val = jQuery("#"+identity).val();
                        //alert("identity_val="+identity_val);
			xhr5.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=5",false);
			xhr5.onreadystatechange =function () {
					if (xhr5.readyState == 4) {
						if (xhr5.status == 200) {
							var text = xhr5.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                         //alert("times5="+times5);
							for(var i=times5;i<eval(text_arr.length+"-"+1+"+"+times5);i++){
								addRow4(4);
								var tmp_arr = text_arr[eval(i+"-"+times5)].split("###");
                                                                //alert("tmp_arr[0]="+tmp_arr[0]);
							        jQuery("#"+ZSYXQ5+i).val(tmp_arr[0]);
								jQuery("#"+ZSYXQ5+i+"span").text(tmp_arr[0]);  

								jQuery("#"+WYDJ5+i).val(tmp_arr[1]);
								jQuery("#"+WYDJ5+i+"span").text(tmp_arr[1]);

								jQuery("#"+ZSMC5+i).val(tmp_arr[2]);
								jQuery("#"+ZSMC5+i+"span").text(tmp_arr[2]);

								jQuery("#"+HZSJ5+i).val(tmp_arr[3]);
								jQuery("#"+HZSJ5+i+"span").text(tmp_arr[3]);

								jQuery("#"+MQSLD5+i).val(tmp_arr[4]);
								jQuery("#"+MQSLD5+i+"span").text(tmp_arr[4]);

								jQuery("#"+MQSLDBM5+i).val(tmp_arr[5]);
								jQuery("#"+MQSLDBM5+i+"span").text(tmp_arr[5]);

								jQuery("#"+ZSMCBM5+i).val(tmp_arr[6]);
								jQuery("#"+ZSMCBM5+i+"span").text(tmp_arr[6]);

								jQuery("#"+WYDJBM5+i).val(tmp_arr[7]);
								jQuery("#"+WYDJBM5+i+"span").text(tmp_arr[7]);                                         
							}
                         times5= eval(times5+"+"+text_arr.length+"-"+1)
                         //alert("times5="+times5);
						}
					}
				}
			xhr5.send(null);
		}


var xhr6 = null;
		if (window.ActiveXObject) {
			xhr6 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr6= new XMLHttpRequest();
		}
		if (null != xhr6) {
			var identity_val = jQuery("#"+identity).val();
                        //alert("identity_val="+identity_val);
			xhr6.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=6",false);
			xhr6.onreadystatechange =function () {
					if (xhr6.readyState == 4) {
						if (xhr6.status == 200) {
							var text = xhr6.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                         //alert("times6="+times6);
							for(var i=times6;i<eval(text_arr.length+"-"+1+"+"+times6);i++){
								addRow5(5);
								var tmp_arr = text_arr[eval(i+"-"+times6)].split("###");
                                                                //alert("tmp_arr[0]="+tmp_arr[0]);
							        jQuery("#"+JSJCZRJ6+i).val(tmp_arr[0]);
								jQuery("#"+JSJCZRJ6+i+"span").text(tmp_arr[0]);  

								jQuery("#"+ZSMC6+i).val(tmp_arr[1]);
								jQuery("#"+ZSMC6+i+"span").text(tmp_arr[1]);

								jQuery("#"+ZSDJ6+i).val(tmp_arr[2]);
								jQuery("#"+ZSDJ6+i+"span").text(tmp_arr[2]);

								jQuery("#"+HZSJ6+i).val(tmp_arr[3]);
								jQuery("#"+HZSJ6+i+"span").text(tmp_arr[3]);
                                    
							}
                         times6= eval(times6+"+"+text_arr.length+"-"+1)
                         //alert("times6="+times6);
						}
					}
				}
			xhr6.send(null);
		}

var xhr7 = null;
		if (window.ActiveXObject) {
			xhr7 = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr7= new XMLHttpRequest();
		}
		if (null != xhr7) {
			var identity_val = jQuery("#"+identity).val();
                        //alert("identity_val="+identity_val);
			xhr7.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=7",false);
			xhr7.onreadystatechange =function () {
					if (xhr7.readyState == 4) {
						if (xhr7.status == 200) {
							var text = xhr7.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                         //alert("times7="+times7);
							for(var i=times7;i<eval(text_arr.length+"-"+1+"+"+times7);i++){
								addRow6(6);
								var tmp_arr = text_arr[eval(i+"-"+times7)].split("###");
                                                                //alert("tmp_arr[0]="+tmp_arr[0]);
							        jQuery("#"+QTZS7+i).val(tmp_arr[0]);
								jQuery("#"+QTZS7+i+"span").text(tmp_arr[0]);  

								jQuery("#"+ZSMC7+i).val(tmp_arr[1]);
								jQuery("#"+ZSMC7+i+"span").text(tmp_arr[1]);

								jQuery("#"+ZSDJ7+i).val(tmp_arr[2]);
								jQuery("#"+ZSDJ7+i+"span").text(tmp_arr[2]);

								jQuery("#"+HZSJ7+i).val(tmp_arr[3]);
								jQuery("#"+HZSJ7+i+"span").text(tmp_arr[3]);
                                    
							}
                         times7= eval(times7+"+"+text_arr.length+"-"+1)
                         //alert("times7="+times7);
						}
					}
				}
			xhr7.send(null);
		}
	});
});

</script>
















































































