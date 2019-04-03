<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function() {
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

     jQuery("#"+identity).bindPropertyChange(function (){
                var index=0;    
                if( times != 0){
                  index = times -1;
                }
                if(jQuery("#field6687_"+index).length>0){
                      jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                      deleteRow0(0);                                                               
                }
                  if(jQuery("#field6687_"+index).length>0){
                    alert("aa");
                     return;
                 }
                  if(times == 0){
                           times = jQuery("#"+num1).val();
                       }
                 //明细2
                if( times_dt2 != 0){
                 index = times_dt2 -1;
           }
                if(jQuery("#field6944_"+index).length>0){
                      jQuery("[name = check_node_1]:checkbox").attr("checked", true);
                    deleteRow1(0);                                                               
                }  
                  if(times_dt2 == 0){
                           times_dt2 = jQuery("#"+num1).val();
                    }
                 
              
		var xhr = null;
		if (window.ActiveXObject) {
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var identity_val = jQuery("#"+identity).val();
                        alert("identity_val="+identity_val);
			xhr.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=1",false);
			xhr.onreadystatechange =function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                        alert("times1="+times);
							for(var i=times;i<eval(text_arr.length+"-"+1+"+"+times);i++){
								addRow0(0);
								var tmp_arr = text_arr[eval(i+"-"+times)].split("###");
                                                                alert("tmp_arr[0]"+tmp_arr[0]);
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
                                                         alert("times2="+times);
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
                        alert("identity_val="+identity_val);
				xhr2.open("GET","/feilida/jsp/PersonEmploy.jsp?identity="+identity_val+"&type=2",false);
			xhr2.onreadystatechange =function () {
					if (xhr2.readyState == 4) {
						if (xhr2.status == 200) {
							var text = xhr2.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g,'');
							var text_arr = text.split("@@@");
                                                        alert("times_dt2="+times_dt2);
							for(var i=times_dt2;i<eval(text_arr.length+"-"+1+"+"+times_dt2);i++){
								alert("aa");
								addRow1(0);
								var tmp_arr = text_arr[eval(i+"-"+times_dt2)].split("###");
                                                                alert("tmp_arr[0]"+tmp_arr[0]);
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
                                                         times = eval(times_dt2+"+"+text_arr.length+"-"+1)
                                                         alert("times_dt2="+times_dt2);
						}
					}
				}
			xhr2.send(null);
		}
	});
});

</script>

















