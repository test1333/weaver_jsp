<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    var zffs = "#field10594"; //֧����ʽ
    var fkzh = "field9885"; //�����˺�
    var fkzhmc = "field9824"; //�����˺�����
    jQuery(zffs).bindPropertyChange(function () {
        var zffs_val = jQuery(zffs).val();
        if (zffs_val == "O") {
            jQuery("#" + fkzh).val("");
            jQuery("#" + fkzh + "span").text("");
            jQuery("#out" + fkzh + "div").hide();
            jQuery("#" + fkzh + "_browserbtn").hide();
            jQuery("#" + fkzh + "spanimg").html("");

            jQuery("#" + fkzhmc).val("");
            jQuery("#" + fkzhmc + "span").text("");
            jQuery("#" + fkzhmc).hide();

            var parastr = document.all('needcheck').value;
            parastr = parastr.replace("," + fkzh, "");
            parastr = parastr.replace("," + fkzhmc, "");
            document.all('needcheck').value = parastr;

        } else {
            jQuery("#" + fkzh).val("");
            jQuery("#" + fkzh + "span").text("");
            jQuery("#out" + fkzh + "div").show();
            jQuery("#" + fkzh + "_browserbtn").show();
            jQuery("#" + fkzh + "spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

            jQuery("#" + fkzhmc).val("");
            jQuery("#" + fkzhmc + "span").text("");
            jQuery("#" + fkzhmc).show();

            var needcheck = document.all("needcheck");
            if (needcheck.value.indexOf("," + fkzh) < 0) {
                if (needcheck.value != '') needcheck.value += ",";
                needcheck.value += fkzh;
            }
            if (needcheck.value.indexOf("," + fkzhmc) < 0) {
                if (needcheck.value != '') needcheck.value += ",";
                needcheck.value += fkzhmc;
            }


        }
    })

    /*
    ����һ��
    ��1��������ɣ����ֶ���ϳ����������·�+�ͻ����+����˰����Ҫ�Զ����������ܳ���50���ַ��� 
    ��2����ϸ���������ѡ��Ŀͻ��Զ���������δ�տ�����ڻ�û���ջص�Ӧ���˿������Դ������ECC��

    */

    var id_ddsj = "#field11190"; //����˰��
    var id_khjc = "#field11803"; //�ͻ����
    var id_qkrq = "#field9820"; //�������
    var id_qkly = "#field10453"; //�������
    var khbh = "#field9887_"; // �ͻ����
    var pzbh = "#field9837_"; // ƾ֤���
    var pzrq = "#field9838_"; // ƾ֤����
    var dqr = "#field10889_"; // ������
    var je = "#field14081_"; //���
    var bz = "#field9839_"; // ����
    var wb = "#field9841_"; //�ı�
    var khbm = "#field10811";
    var gsdm = "#field12443";
    var qkrq = "#field9820";
    //var khmc = "#field10812";
    var ysksfcq = "#field14121"; //Ӧ�տ��Ƿ���

    jQuery(document).ready(function () {

        $(ysksfcq).hide();
        $(ysksfcq + "span").hide();
        $(ysksfcq).closest("td").append("<span id='ysksfcq'></span>")
        $("#ysksfcq").text($(ysksfcq).val() == "0" ? "��" : "��");
//�ͻ����뷢���仯ʱɾ���ͻ�����δ�տ�����¼���δ�տ���
        jQuery(khbm).bindPropertyChange(function () {
            var indexnum1 = jQuery("#nodesnum1").val();
            if (indexnum1 > 0) {
                jQuery("[name = check_node_1]:checkbox").attr("checked", true);
                deleteRow1(1);
            }
            var xhr = null;
            if (window.ActiveXObject) {//IE�����
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xhr = new XMLHttpRequest();
            }
            if (null != xhr) {
                var khbm_val = jQuery(khbm).val();
                var gsdm_val = jQuery(gsdm).val();
                var qkrq_val = jQuery(qkrq).val();
                indexnum1 = jQuery("#indexnum1").val();
                xhr.open("GET", "/feilida/finance/getFI03Info.jsp?id=" + khbm_val + "&custom=" + gsdm_val + "&qkrq=" + qkrq_val, false);
                xhr.onreadystatechange = function () {

                    if (xhr.readyState == 4) {
                        if (xhr.status == 200) {
                            var text = xhr.responseText;
                            text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                            var text_arr = text.split("@@@");
                            var length1 = Number(text_arr.length) - 1 + Number(indexnum1);
                            for (var i = indexnum1; i < length1; i++) {
                                addRow1(1);
                                var tmp_arr = text_arr[i - indexnum1].split("###");
                                jQuery(khbh + i).val(tmp_arr[0]);
                                jQuery(khbh + i + "span").text(tmp_arr[0]);
                                jQuery(pzbh + i).val(tmp_arr[1]);
                                jQuery(pzbh + i + "span").text(tmp_arr[1]);
                                jQuery(pzrq + i).val(tmp_arr[2]);
                                jQuery(pzrq + i + "span").text(tmp_arr[2]);
                                jQuery(dqr + i).val(tmp_arr[3]);
                                jQuery(dqr + i + "span").text(tmp_arr[3]);
                                jQuery(je + i).val(tmp_arr[4]);
                                jQuery(je + i + "span").text(tmp_arr[4]);
                                jQuery(bz + i).val(tmp_arr[5]);
                                jQuery(bz + i + "span").text(tmp_arr[5]);
                                jQuery(wb + i).val(tmp_arr[6]);
                                jQuery(wb + i + "span").text(tmp_arr[6]);
                            }
                            var vt = $("#oTable1 tr").length > 3 ? "��" : "��";
                            var vv = $("#oTable1 tr").length > 3 ? "1" : "0";
                            $(ysksfcq).val(vv);
                            $(ysksfcq + "span").val(vv);
                            $("#ysksfcq").text(vt);
                        }
                    }
                }
                xhr.send(null);
            }
        })

        checkCustomize = function () {

            var isSuccess = true;
            var mon = new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");
            var khjc = $(id_khjc).val();
            var ddsj = $(id_ddsj).val();
            $(id_qkly).val(mon + "��" + khjc + ddsj);



            return isSuccess;
        }
    });

 
    

</script>

