<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    "��ѡ����������ͺ�ҳ���Զ�������ѵ�����ͣ��������ʲ���
    ��������Ϊ������ʾ��ѵ��Ϣ
    ��������Ϊ������ʾ������Ϣ
    ��������Ϊ������ʾ�������ʲ�����Ϣ"

    
    �����������ȼ�: ������N��1��������N��1;
    ����ǰ�������: ��������Ϊ����ְ����ʾ;
    ��������Ϊ����ְ����ʾ�������ݵ�����������ȼ���SAPץȡ��Ӧ�������

    ����������Ϊ01(����),�����������1Ϊ3000;
    ����������Ϊ02(����),�����������1Ϊ4000
    "
    */

    var arr_xzdj = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "C", "B", "A"];

    checkCustomize = function () {
        var isSuccess = true;

        return isSuccess;
    }

    var setLX = function () {
        var id_tzlx = "#field8572"; //��������
        var id_tzlx1 = "#field10897"; ; //��������1 field10897
        var v_tzlx = $(id_tzlx).val();

        var id_tzqxzdj = "#field9562"; //����ǰ�����ȼ�
        var id_tzhxzdj = "#field8636"; //�����������ȼ�
        var id_zwxl = "#field8580"; //ְλ����

        var v_tzqxzdj = -1; // parseInt($(id_tzqxzdj).val());


        for (i = 0; i < arr_xzdj.length; i++) {
            if (arr_xzdj[i] == $(id_tzqxzdj).val()) {
                v_tzqxzdj = i;
            }
        }


        var tr_gljt = $("#field6664").closest("tr"); //�������tr


        if ($(id_zwxl + "span").text().indexOf("����") > -1) {
            //����ְ��
            tr_gljt.show();
        } else {
            //�ǹ���ְ��
            tr_gljt.hide();

        }

        if (v_tzlx != "") {
            //01 ������02 ����
            var idx_xzdj = -1;
            for (i = 0; i < arr_xzdj.length; i++) {
                if (arr_xzdj[i] == v_tzqxzdj) {
                    idx_xzdj = i;
                }
            }
            if (v_tzlx == "01") {
                if (idx_xzdj == arr_xzdj.length - 1) {
                    window.top.Dialog.alert("��ǰ��߼����޷�������");
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
                   alert( "��ǰ��߼����޷�������")
                }
               // $(id_tzhxzdj).val(parseInt($(id_tzqxzdj).val()) + 1);
               // $(id_tzhxzdj + "span").text(parseInt($(id_tzqxzdj).val()) + 1);
                $(id_tzlx1).val(3000);

            } else if (v_tzlx == "02") {
                //if (idx_xzdj < 1) {
                //    window.top.Dialog.alert("��ǰ��ͼ����޷�������");
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
{window.top.Dialog.alert("��ǰ��ͼ����޷�������");}
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



