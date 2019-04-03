<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    "当选择完调整类型后页面自动触发培训，奖惩，能力素质测评
    调整类型为晋级显示培训信息
    调整类型为晋级显示奖惩信息
    调整类型为晋级显示能力素质测评信息"

    
    调整后行政等级: 晋级：N＋1；降级：N－1;
    调整前管理津贴: 被申请人为管理职才显示;
    被申请人为管理职才显示，并根据调整后的行政等级从SAP抓取对应管理津贴

    当调整类型为01(晋级),则给调整类型1为3000;
    当调整类型为02(降级),则给调整类型1为4000
    "
    */

    var arr_xzdj = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "C", "B", "A"];

    checkCustomize = function () {
        var isSuccess = true;

        return isSuccess;
    }

    var setLX = function () {
        var id_tzlx = "#field8572"; //调整类型
        var id_tzlx1 = "#field10897"; ; //调整类型1 field10897
        var v_tzlx = $(id_tzlx).val();

        var id_tzqxzdj = "#field9562"; //调整前行政等级
        var id_tzhxzdj = "#field8636"; //调整后行政等级
        var id_zwxl = "#field8580"; //职位序列

        var v_tzqxzdj = -1; // parseInt($(id_tzqxzdj).val());


        for (i = 0; i < arr_xzdj.length; i++) {
            if (arr_xzdj[i] == $(id_tzqxzdj).val()) {
                v_tzqxzdj = i;
            }
        }


        var tr_gljt = $("#field6664").closest("tr"); //管理津贴tr


        if ($(id_zwxl + "span").text().indexOf("管理") > -1) {
            //管理职能
            tr_gljt.show();
        } else {
            //非管理职能
            tr_gljt.hide();

        }

        if (v_tzlx != "") {
            //01 晋级；02 降级
            var idx_xzdj = -1;
            for (i = 0; i < arr_xzdj.length; i++) {
                if (arr_xzdj[i] == v_tzqxzdj) {
                    idx_xzdj = i;
                }
            }
            if (v_tzlx == "01") {
                if (idx_xzdj == arr_xzdj.length - 1) {
                    window.top.Dialog.alert("当前最高级，无法晋升！");
                    return false;
                }

                var idx = 0;
                $(".excelMainTable tr").each(function () {
                    if (idx >= 16) {
                        $(this).show();
                    }
                    idx++;
                });
                
      if (!isNaN($(id_tzqxzdj).val())) {
                    //                    alert($(id_tzqxzdj).val());
                    //                    alert(arr_xzdj[parseInt($(id_tzqxzdj).val())]);
                    $(id_tzhxzdj).val(arr_xzdj[parseInt($(id_tzqxzdj).val())]);
                    $(id_tzhxzdj + "span").text(arr_xzdj[parseInt($(id_tzqxzdj).val())]);
                } else if ($(id_tzqxzdj + "span").text() == "C") {
                    $(id_tzhxzdj).val("B");
                    $(id_tzhxzdj + "span").text("B");
                } else if ($(id_tzqxzdj + "span").text() == "B") {
                    $(id_tzhxzdj).val("A");
                    $(id_tzhxzdj + "span").text("A");
                } else {
                   alert( "当前最高级，无法晋升！")
                }
               // $(id_tzhxzdj).val(parseInt($(id_tzqxzdj).val()) + 1);
               // $(id_tzhxzdj + "span").text(parseInt($(id_tzqxzdj).val()) + 1);
                $(id_tzlx1).val(3000);

            } else if (v_tzlx == "02") {
                //if (idx_xzdj < 1) {
                //    window.top.Dialog.alert("当前最低级，无法降级！");
                 //   return false;
               // }

                var idx = 0;
                $(".excelMainTable tr").each(function () {
                    if (idx >= 16) {
                        $(this).hide();
                    }
                    idx++;
                });

                  if (!isNaN($(id_tzqxzdj).val())) {
                    if (parseInt($(id_tzqxzdj).val()) >= 2) {
                        $(id_tzhxzdj).val(arr_xzdj[parseInt($(id_tzqxzdj).val()) - 2]);
                        $(id_tzhxzdj + "span").text(arr_xzdj[parseInt($(id_tzqxzdj).val()) - 2]);
                    } 
else
{window.top.Dialog.alert("当前最低级，无法降级！");}
                } else if ($(id_tzqxzdj + "span").text() == "C") {
                    $(id_tzhxzdj).val("10");
                    $(id_tzhxzdj + "span").text("10");
                } else if ($(id_tzqxzdj + "span").text() == "B") {
                    $(id_tzhxzdj).val("C");
                    $(id_tzhxzdj + "span").text("C");
                } else if ($(id_tzqxzdj + "span").text() == "A") {
                    $(id_tzhxzdj).val("B");
                    $(id_tzhxzdj + "span").text("B");
                }
                //$(id_tzhxzdj).val(parseInt($(id_tzqxzdj).val()) - 1);
                //$(id_tzhxzdj + "span").text(parseInt($(id_tzqxzdj).val()) - 1);
               // alert($(id_tzqxzdj).val());
                $(id_tzlx1).val(4000);
            }
        }

    }

    jQuery(document).ready(function () {
        jQuery("#field8572").bindPropertyChange(function () { setLX(); });
        jQuery("#field9562").bindPropertyChange(function () { setLX(); });
        jQuery("#field8580").bindPropertyChange(function () { setLX(); });
        setLX();
    });

</script>



