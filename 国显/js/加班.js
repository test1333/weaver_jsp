<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/gvo/HRworkflow/get_jiaban_1_1.js"></script>
<script type="text/javascript" src="/gvo/HRworkflow/get_jiaban_9.js"></script><script type="text/javascript" src="/gvo/hrm/js/gvo_hrm_jiaban_2.js"></script><script type="text/javascript" src="/gvo/HRworkflow/check_jiabankz.js"></script>
<script type="text/javascript">
	var xm_dt="field5854_";
var  xm_dt2="field27242_";
var gh_dt2="field27241_";
var month1="field27225_";
var month2="field27226_";
var month3="field27227_";
var month4="field27228_";
var month5="field27229_";
var month6="field27230_";
var month7="field27231_";
var month8="field27232_";
var month9="field27233_";
var month10="field27234_";
var month11="field27235_";
var month12="field27236_";
var dyjd="field27237_";
var dejd="field27238_";
var dsjd="field27239_";
var dsjd4="field27240_";
    jQuery("button[name=addbutton0]").live("click", function () {
       getInfo();
       getBC();
       test1();
         var indexnum = jQuery("#indexnum0").val();
         bindchange(indexnum-1);
    });
    jQuery("button[name=delbutton0]").live("click", function () {
          var indexnum3 = jQuery("#nodesnum1").val();
            if (indexnum3 > 0) {
                jQuery("[name = check_node_1]:checkbox").attr("checked", true);
                deleteRow1(1);
            }
            getData1();
    });
       jQuery(document).ready(function () {
       	var indexnum4 = jQuery("#indexnum0").val();
       	  for (var index2= 0; index2 < indexnum4; index2++) {
           		 if (jQuery("#"+xm_dt + index2).length > 0) {
           		 	 bindchange(index2);
        		}
        	}	
       });
        function bindchange(index) {
        jQuery("#"+xm_dt + index).bindPropertyChange(function () {
            var indexnum1 = jQuery("#nodesnum1").val();
            if (indexnum1 > 0) {
                jQuery("[name = check_node_1]:checkbox").attr("checked", true);
                deleteRow1(1);
            }
            getData1();

        })

    }
    function getData1() {
        var indexnum0 = jQuery("#indexnum0").val();
        var xmid = '';
        var falgg = '';
        for (var index1 = 0; index1 < indexnum0; index1++) {
            if (jQuery("#"+xm_dt + index1).length > 0) {
                var bh_val = jQuery("#"+xm_dt + index1).val();
                if (bh_val != '') {
                    var gysall = "," + xmid + ",";
                    var bh_all = "," + bh_val + ",";
                    if (gysall.indexOf(bh_all) >= 0) {
                        continue;
                    } else {
                        xmid = xmid + falgg + bh_val;
                    }
                    falgg = ',';
                }
            }

        }
        if (xmid != '') {
            getdetailinfo(xmid);
        }
    }
    
       function getdetailinfo(xmid){
       	   var indexnum2 = jQuery("#indexnum1").val();
       	 jQuery.post("/gvo/HRworkflow/get_jiaban_hours.jsp", {
                    'id': xmid
                }, function (data) {
                	  var text = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                	  //alert(text);
                       var text_arr = text.split("@@@");
                        var length1 = Number(text_arr.length) - 1 + Number(indexnum2);
                        for (var i = indexnum2; i < length1; i++) {
                            addRow1(1);
                            var tmp_arr = text_arr[i - indexnum2].split("###");
                               jQuery("#"+gh_dt2 + i).val(tmp_arr[0]);
                               jQuery("#"+gh_dt2 + i + "span").text(tmp_arr[0]);
                               jQuery("#"+xm_dt2 + i).val(tmp_arr[1]);
                              jQuery("#"+xm_dt2 + i + "span").text(tmp_arr[2]);
                              jQuery("#"+month1 + i).val(tmp_arr[3]);
                              jQuery("#"+month1 + i + "span").text(tmp_arr[3]);
                              jQuery("#"+month2 + i).val(tmp_arr[4]);
                              jQuery("#"+month2 + i + "span").text(tmp_arr[4]);
                              jQuery("#"+month3 + i).val(tmp_arr[5]);
                              jQuery("#"+month3 + i + "span").text(tmp_arr[5]);
                              jQuery("#"+month4 + i).val(tmp_arr[6]);
                              jQuery("#"+month4 + i + "span").text(tmp_arr[6]);
                              jQuery("#"+month5 + i).val(tmp_arr[7]);
                              jQuery("#"+month5 + i + "span").text(tmp_arr[7]);
                              jQuery("#"+month6 + i).val(tmp_arr[8]);
                              jQuery("#"+month6 + i + "span").text(tmp_arr[8]);
                              jQuery("#"+month7 + i).val(tmp_arr[9]);
                              jQuery("#"+month7 + i + "span").text(tmp_arr[9]);
                              jQuery("#"+month8 + i).val(tmp_arr[10]);
                              jQuery("#"+month8 + i + "span").text(tmp_arr[10]);
                              jQuery("#"+month9 + i).val(tmp_arr[11]);
                              jQuery("#"+month9 + i + "span").text(tmp_arr[11]);
                              jQuery("#"+month10 + i).val(tmp_arr[12]);
                              jQuery("#"+month10 + i + "span").text(tmp_arr[12]);
                              jQuery("#"+month11 + i).val(tmp_arr[13]);
                              jQuery("#"+month11 + i + "span").text(tmp_arr[13]);
                              jQuery("#"+month12 + i).val(tmp_arr[14]);
                              jQuery("#"+month12 + i + "span").text(tmp_arr[14]);
                              jQuery("#"+dyjd + i).val(tmp_arr[15]);
                              jQuery("#"+dyjd + i + "span").text(tmp_arr[15]);
                              jQuery("#"+dejd + i).val(tmp_arr[16]);
                              jQuery("#"+dejd + i + "span").text(tmp_arr[16]);
                              jQuery("#"+dsjd + i).val(tmp_arr[17]);
                              jQuery("#"+dsjd + i + "span").text(tmp_arr[17]);
                              jQuery("#"+dsjd4 + i).val(tmp_arr[18]);
                              jQuery("#"+dsjd4 + i + "span").text(tmp_arr[18]);
                            
                           
                        }
                	    
                 });	   
   	}
</script>