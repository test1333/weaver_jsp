
<script type="text/javascript">
    var zffs = "#field10511"; //֧����ʽ
    var fkzh = "field9888"; //�����˺�
    var fkzhmc = "field9759"; //�����˺�����
    var kh = "field11290"; //�ͻ�
    var pjh = "field11292"; //֧ƱƱ�ݺ�

    var hzje = "field10762"; //���ܽ��


 /*
��֧����ʽ=B ʱ���������˺š�Ϊ����������ͻ�����λΪ�����ֻ�д����Ρ��ͻ����Ż���䣬����������ֶβ����䣩��ͬʱ���֧����ʽѡ�����гжһ�Ʊ��֧Ʊ/Ʊ�ݺš��������һ�������˴����䣻
��֧����ʽ=O ʱ���������˺š�Ϊ�������
��֧����ʽ=P ʱ���������˺š�Ϊ�����
��֧����ʽ=S ʱ���������˺š�Ϊ�������֧Ʊ/Ʊ�ݺš������һ���ύ�˴����䣻
    */
    jQuery(zffs).bindPropertyChange(function () {
        var zffs_val = jQuery(zffs).val();
        if (zffs_val == "B") {
            jQuery("#" + fkzh).val("");
            jQuery("#" + fkzh + "span").text("");
            jQuery("#out" + fkzh + "div").hide();
            jQuery("#" + fkzh + "_browserbtn").hide();
            jQuery("#" + fkzh + "spanimg").html("");

            jQuery("#" + fkzhmc).val("");
            jQuery("#" + fkzhmc + "span").text("");
            jQuery("#" + fkzhmc).hide();

            jQuery("#" + kh).val("");
            jQuery("#" + kh + "span").text("");
            jQuery("#out" + kh + "div").show();
            jQuery("#" + kh + "_browserbtn").show();
            jQuery("#" + kh + "spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

            jQuery("#" + pjh).val("");
            jQuery("#" + pjh + "span").text("");
            jQuery("#" + pjh).show();
            jQuery("#" + pjh + "span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

            var needcheck = document.all("needcheck");
            if (needcheck.value.indexOf("," + kh) < 0) {
                if (needcheck.value != '') needcheck.value += ",";
                needcheck.value += kh;
            }
            if (needcheck.value.indexOf("," + pjh) < 0) {
                if (needcheck.value != '') needcheck.value += ",";
                needcheck.value += pjh;
            }

            var parastr = document.all('needcheck').value;
            parastr = parastr.replace("," + fkzh, "");
            parastr = parastr.replace("," + fkzhmc, "");
            document.all('needcheck').value = parastr;

        }   else if (zffs_val == "N") {
            jQuery("#" + fkzh).val("");
            jQuery("#" + fkzh + "span").text("");
            jQuery("#out" + fkzh + "div").hide();
            jQuery("#" + fkzh + "_browserbtn").hide();
            jQuery("#" + fkzh + "spanimg").html("");

            jQuery("#" + fkzhmc).val("");
            jQuery("#" + fkzhmc + "span").text("");
            jQuery("#" + fkzhmc).hide();

            jQuery("#" + kh).val("");
            jQuery("#" + kh + "span").text("");
            jQuery("#out" + kh + "div").hide();
            jQuery("#" + kh + "_browserbtn").hide();
            jQuery("#" + kh + "spanimg").html("");

            jQuery("#" + pjh).val("");
            jQuery("#" + pjh + "span").text("");
            jQuery("#" + pjh).hide();
            jQuery("#" + pjh + "span").html("");

            var parastr = document.all('needcheck').value;
            parastr = parastr.replace("," + fkzh, "");
            parastr = parastr.replace("," + fkzhmc, "");
            parastr = parastr.replace("," + kh, "");
            parastr = parastr.replace("," + pjh, "");
            document.all('needcheck').value = parastr;

        } else if (zffs_val == "O") {
            jQuery("#" + fkzh).val("");
            jQuery("#" + fkzh + "span").text("");
            jQuery("#out" + fkzh + "div").hide();
            jQuery("#" + fkzh + "_browserbtn").hide();
            jQuery("#" + fkzh + "spanimg").html("");

            jQuery("#" + fkzhmc).val("");
            jQuery("#" + fkzhmc + "span").text("");
            jQuery("#" + fkzhmc).hide();

            jQuery("#" + kh).val("");
            jQuery("#" + kh + "span").text("");
            jQuery("#out" + kh + "div").hide();
            jQuery("#" + kh + "_browserbtn").hide();
            jQuery("#" + kh + "spanimg").html("");

            jQuery("#" + pjh).val("");
            jQuery("#" + pjh + "span").text("");
            jQuery("#" + pjh).hide();
            jQuery("#" + pjh + "span").html("");

            var parastr = document.all('needcheck').value;
            parastr = parastr.replace("," + fkzh, "");
            parastr = parastr.replace("," + fkzhmc, "");
            parastr = parastr.replace("," + kh, "");
            parastr = parastr.replace("," + pjh, "");
            document.all('needcheck').value = parastr;

        } else if (zffs_val == "P") {
            jQuery("#" + fkzh).val("");
            jQuery("#" + fkzh + "span").text("");
            jQuery("#out" + fkzh + "div").show();
            jQuery("#" + fkzh + "_browserbtn").show();
            jQuery("#" + fkzh + "spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

            jQuery("#" + fkzhmc).val("");
            jQuery("#" + fkzhmc + "span").text("");
            jQuery("#" + fkzhmc).show();

            jQuery("#" + kh).val("");
            jQuery("#" + kh + "span").text("");
            jQuery("#out" + kh + "div").hide();
            jQuery("#" + kh + "_browserbtn").hide();
            jQuery("#" + kh + "spanimg").html("");

            jQuery("#" + pjh).val("");
            jQuery("#" + pjh + "span").text("");
            jQuery("#" + pjh).hide();
            jQuery("#" + pjh + "span").html("");

            var needcheck = document.all("needcheck");
            if (needcheck.value.indexOf("," + fkzh) < 0) {
                if (needcheck.value != '') needcheck.value += ",";
                needcheck.value += fkzh;
            }

            var parastr = document.all('needcheck').value;
            parastr = parastr.replace("," + kh, "");
            parastr = parastr.replace("," + pjh, "");
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

            jQuery("#" + kh).val("");
            jQuery("#" + kh + "span").text("");
            jQuery("#out" + kh + "div").hide();
            jQuery("#" + kh + "_browserbtn").hide();
            jQuery("#" + kh + "spanimg").html("");

            jQuery("#" + pjh).val("");
            jQuery("#" + pjh + "span").text("");
            jQuery("#" + pjh).show();
            jQuery("#" + pjh + "span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

            var needcheck = document.all("needcheck");
            if (needcheck.value.indexOf("," + fkzh) < 0) {
                if (needcheck.value != '') needcheck.value += ",";
                needcheck.value += fkzh;
            }
            if (needcheck.value.indexOf("," + pjh) < 0) {
                if (needcheck.value != '') needcheck.value += ",";
                needcheck.value += pjh;
            }

            var parastr = document.all('needcheck').value;
            parastr = parastr.replace("," + kh, "");
            document.all('needcheck').value = parastr;
        }
    })

    var gysbh = "#field9891_"; //��Ӧ�̱��
    var pzbh = "#field9772_"; //ƾ֤���
    var pzgzrq = "#field9773_"; //ƾ֤��������
    var ybje = "#field11324_"; //ԭ�ҽ��
    var bwbje = "#field11289_"; // ��λ�ҽ��
    var bz = "#field9774_"; // ����
    var fprq = "#field10887_"; // ��Ʊ����
    var fphm = "#field10888_"; // ��Ʊ����
    var cn = "#field11461_"; //����
    var pzhxms = "#field11462_"; // ƾ֤����Ŀ��
    var wb = "#field9776_"; //�ı�
    var bh = "#field9889_"; //��ϸ1��Ӧ�̱��
    var gsdm = "#field12447";
    var qran = "#field12301span";
    var xz = "#field12302_";
    var ybfkje = "#field11881_"; //��ϸ1ԭ�Ҹ�����
    var bwbfkje = "#field11323_"; //��ϸ1��λ�Ҹ�����
    var xlkbz = "#field10225";
    //������ϸ1ʱ���¼�
    jQuery("button[name=addbutton0]").live("click", function () {
        var indexnum0 = jQuery("#indexnum0").val();
        for (var index = 0; index < indexnum0; index++) {
            if (jQuery(bh + index).length > 0) {
                bindchange(index);
            }
        }

    });
    //�����ϸ1����ʱ���¼�����ϸ2
    jQuery("button[name=delbutton0]").live("click", function () {
        var indexnum1 = jQuery("#nodesnum1").val();
        if (indexnum1 > 0) {
            jQuery("[name = check_node_1]:checkbox").attr("checked", true);
            deleteRow1(1);
        }
        getData1();
    });

    jQuery(document).ready(function () {

        var nodesnum0 = jQuery("#nodesnum0").val();
        var indexnum0 = jQuery("#indexnum0").val();
        if (nodesnum0 > 0) {

            for (var index = 0; index < indexnum0; index++) {
                if (jQuery(bh + index).length > 0) {

                    bindchange(index)
                }
            }
        }
        setTimeout(' doData()', 500);

    });
  //ȷ�ϰ�ť
    function doData() {
        jQuery(qran).html("<input type=button   style='width:70px' value='ȷ��' onclick='checkdata2()' >");
    }
/*
	���ض�Ӧ��Ӧ�̵�δ����·���ϸ���У�������ԴSAP��.��ѡ��Ҫ�����δ������ϸ��
	�����ȷ�ϡ���ť���ѹ�ѡ��δ����ġ�ԭ�ҽ��ۼƸ�ֵ����Ӧ�̸�����ϸ���еĶ�Ӧ��Ӧ�̵ġ�ԭ�Ҹ�����ֶΣ���
	��λ�ҽ��ۼƸ�ֵ����Ӧ�̸�����ϸ���еĶ�Ӧ��Ӧ�̵ġ���λ�Ҹ�����ֶ�
	*/
    function checkdata2() {

        var indexnum0 = jQuery("#indexnum0").val();
        for (var index1 = 0; index1 < indexnum0; index1++) {
            if (jQuery(bh + index1).length > 0) {
                jQuery(ybfkje + index1).val("");
                jQuery(bwbfkje + index1).val("");
                jQuery(ybfkje + index1 + "span").text("");
                jQuery(bwbfkje + index1 + "span").text("");

            }
        }

        var indexnum1 = jQuery("#indexnum1").val();
        for (var index = 0; index < indexnum1; index++) {

            if (jQuery(gysbh + index).length > 0) {
                if (jQuery(xz + index).attr("checked")) {
                    var ybje_val = jQuery(ybje + index).val();
                    var bwbje_val = jQuery(bwbje + index).val();
                    var gysbh_val = jQuery(gysbh + index).val();
                    checkdata1(ybje_val, bwbje_val, gysbh_val);

                }
            }
        }
        calSum(0);
    }

    function checkdata1(ybje2, bwbje2, gysbh2) {
        var indexnum0 = jQuery("#indexnum0").val();
        for (var index1 = 0; index1 < indexnum0; index1++) {
            if (jQuery(bh + index1).length > 0) {
                if (jQuery(bh + index1).val() == gysbh2) {
                    var ybfkje_val = jQuery(ybfkje + index1).val();
                    var bwbfkje_val = jQuery(bwbfkje + index1).val();
                    var sum11 = Number(ybfkje_val) + Number(ybje2);
                    var sum22 = Number(bwbfkje_val) + Number(bwbje2);
                    jQuery(ybfkje + index1).val(Number(sum11).toFixed(2));
                    jQuery(ybfkje + index1 + "span").text(Number(sum11).toFixed(2));
                    jQuery(bwbfkje + index1).val(Number(sum22).toFixed(2));
                    jQuery(bwbfkje + index1 + "span").text(Number(sum22).toFixed(2));
                }
            }
        }
    }
    //����ϸ1��Ӧ�̷����仯ʱɾ����ϸ�����ݣ���������ϸ1�Ĺ�Ӧ�̴�����ϸ������
    function bindchange(index) {
        jQuery(bh + index).bindPropertyChange(function () {
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
        var gysid = '';
        var falgg = '';
        for (var index1 = 0; index1 < indexnum0; index1++) {
            if (jQuery(bh + index1).length > 0) {
                jQuery(ybfkje + index1).val("");
                jQuery(bwbfkje + index1).val("");
                jQuery(ybfkje + index1 + "span").text("");
                jQuery(bwbfkje + index1 + "span").text("");
                var bh_val = jQuery(bh + index1).val();
                if (bh_val != '') {
                    gysid = gysid + falgg + bh_val;
                    falgg = ',';
                }
            }

        }
        if (gysid != '') {
            getdetail2(gysid);
        }
    }
   //������ϸ1��Ӧ����Ϣ������ϸ2����
    function getdetail2(gysid) {
        var indexnum1 = jQuery("#indexnum1").val();
        var xhr = null;
        if (window.ActiveXObject) {//IE�����
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            xhr = new XMLHttpRequest();
        }
        if (null != xhr) {
            var gsdm_val = jQuery(gsdm).val();
            var xlkbz_val = jQuery(xlkbz).find("option:selected").text();
            xlkbz_val = xlkbz_val.substring(0, 3);
            xhr.open("GET", "/feilida/finance/getFI05Info.jsp?id=" + gysid + "&custom=" + gsdm_val + "&xlkbz=" + xlkbz_val, false);
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
                            jQuery(gysbh + i).val(tmp_arr[0]);
                            jQuery(gysbh + i + "span").text(tmp_arr[0]);
                            jQuery(pzbh + i).val(tmp_arr[1]);
                            jQuery(pzbh + i + "span").text(tmp_arr[1]);
                            jQuery(pzgzrq + i).val(tmp_arr[2]);
                            jQuery(pzgzrq + i + "span").text(tmp_arr[2]);
                            jQuery(ybje + i).val(tmp_arr[3]);
                            jQuery(ybje + i + "span").text(tmp_arr[3]);
                            jQuery(bwbje + i).val(tmp_arr[4]);
                            jQuery(bwbje + i + "span").text(tmp_arr[4]);
                            jQuery(bz + i).val(tmp_arr[5]);
                            jQuery(bz + i + "span").text(tmp_arr[5]);
                            jQuery(fprq + i).val(tmp_arr[6]);
                            jQuery(fprq + i + "span").text(tmp_arr[6]);
                            jQuery(fphm + i).val(tmp_arr[7]);
                            jQuery(fphm + i + "span").text(tmp_arr[7]);
                            jQuery(cn + i).val(tmp_arr[8]);
                            jQuery(cn + i + "span").text(tmp_arr[8]);
                            jQuery(pzhxms + i).val(tmp_arr[9]);
                            jQuery(pzhxms + i + "span").text(tmp_arr[9]);
                            jQuery(wb + i).val(tmp_arr[10]);
                            jQuery(wb + i + "span").text(tmp_arr[10]);
                        }
                    }
                }
            }
            xhr.send(null);
        }
    }

    checkCustomize = function () {
        var isSuccess = true;
        if ($("#" + hzje).val() == 0) {
            window.top.Dialog.alert("���ܽ��Ϊ0���������ύ��");
            isSuccess = false;
            return false;
        }
        return isSuccess;
    }


</script>



