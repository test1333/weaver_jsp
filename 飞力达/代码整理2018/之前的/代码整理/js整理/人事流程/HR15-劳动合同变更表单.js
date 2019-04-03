<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    ������ǩ����Ϊ����,�������ʼ��ǩ����
    �ͽ�ֹ��ǩ���ڡ�������ǩ����Ϊ�޹̶�����,�������ֹ��ǩ����Ϊ99991231 ת�޹̶���

    20160912
    1.���ѡ���ͬ���ڲ���ǩ,����Ҫ�������е�1,2,4�����ء����߽����趨Ϊ�������롣

    2.�������,����Ҫ�������е�1,3,4�����ء����߽����趨Ϊ�������롣

    3.���ѡ���ͬ��ǩ,����Ҫ�������е�2,3,4�����ء����߽����趨Ϊ�������롣

    4.���ѡ�����ݻ����ݷ�Ƹ,����Ҫ�������е�1,2,3�����ء����߽����趨Ϊ�������롣


    20160914
    �Ͷ���ͬ������ж���4:���ݷ�Ƹ���� �м�������ʼ��ǩ����,��ֹ��ǩ���ڡ�
    �����������ֶεļ��㷽ʽ������ʾ:
    ��ʼ��ǩ����:�Ͷ���ͬ��������+1
    ��ֹ����Ϊ����1-14������Ϊ�������һ��
    ��ֹ���ڴ���14������Ϊ�����µ�

    20160930
    �Ͷ���ͬ���������JS��������:����������ѡ��:4,��������Ľ�����趨Ϊ�������롣
         
    */


    checkCustomize = function () {
        var isSuccess = true;
        return isSuccess;
    }

    var id_bgbm = "#field8539"; //�������
    var id_bgms = "#field8540"; //�������

    //����
    var id_tyxqnx = "#field6675"; //ͬ����ǩ����
    var id_qsxqrq = "#field7181"; //��ʼ��ǩ����
    var id_jzxqrq = "#field7182"; //��ֹ��ǩ���� 

    var id_jjbcj1 = "#field7183"; //���ò�����1
    var id_jjbcj2 = "#field7184"; //���ò�����2
    var id_txfpkh = "#field9001"; //���ݷ�Ƹ���� 
    var id_txfpksrq = "#field10082"; //���ݷ�Ƹ��ʼ����
    var id_txfpjsrq = "#field10083"; //���ݷ�Ƹ��������

    var id_ldhtjsrq = "#field6763"; //�Ͷ���ͬ��������
    var setNX = function () {
        var i_tyxqnx = $(id_tyxqnx + " option:selected"); //ͬ����ǩ����
        var i_qsxqrq = $(id_qsxqrq); //��ʼ��ǩ����
        var i_jzxqrq = $(id_jzxqrq); //��ֹ��ǩ����
        var s_qsxqrq = $(id_qsxqrq + "span"); //��ʼ��ǩ����
        var s_jzxqrq = $(id_jzxqrq + "span"); //��ֹ��ǩ����

        var i_txfpksrq = $(id_txfpksrq); //���ݷ�Ƹ��ʼ����
        var i_txfpjsrq = $(id_txfpjsrq); //���ݷ�Ƹ��������
        var s_txfpksrq = $(id_txfpksrq + "span"); //���ݷ�Ƹ��ʼ����
        var s_txfpjsrq = $(id_txfpjsrq + "span"); //���ݷ�Ƹ��������


        var i_ldhtjsrq = $(id_ldhtjsrq); //�Ͷ���ͬ��������
        var v_ldhtjsrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/"));

        var v_qsxqrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/")).addDays(1).Format("yyyy-MM-dd");
        i_qsxqrq.val(v_qsxqrq);
        s_qsxqrq.text(v_qsxqrq);

        if (i_tyxqnx.text() == "�޹̶���") {
            i_jzxqrq.val("9999-12-31");
            s_jzxqrq.text("9999-12-31");
        } else if (i_tyxqnx.text().indexOf("��") > 0) {
            var v_nian = parseInt(i_tyxqnx.text().substr(0, i_tyxqnx.text().indexOf("��")));
            var v_jzxqrq = v_ldhtjsrq.addYears(v_nian).Format("yyyy-MM-dd");
            i_jzxqrq.val(v_jzxqrq);
            s_jzxqrq.text(v_jzxqrq);

        } else {
            i_qsxqrq.val("");
            i_jzxqrq.val("");
            s_qsxqrq.text("");
            s_jzxqrq.text("");

        }

    }

    var setFPNX = function () {
        var i_tyxqnx = $(id_txfpkh + " option:selected"); //���ݷ�Ƹ����

        var i_txfpksrq = $(id_txfpksrq); //���ݷ�Ƹ��ʼ����
        var i_txfpjsrq = $(id_txfpjsrq); //���ݷ�Ƹ��������
        var s_txfpksrq = $(id_txfpksrq + "span"); //���ݷ�Ƹ��ʼ����
        var s_txfpjsrq = $(id_txfpjsrq + "span"); //���ݷ�Ƹ��������


        var i_ldhtjsrq = $(id_ldhtjsrq); //�Ͷ���ͬ��������
        var v_ldhtjsrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/"));

        var v_qsxqrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/")).addDays(1).Format("yyyy-MM-dd");
        var v_jsxqrq = new Date(i_ldhtjsrq.val().replace(/-/g, "/")).addYears(1);

        if (i_tyxqnx.val() == "1") {
            var tmp_date;

            if (v_jsxqrq.getDate() > 14) {
                //����Ϊ�����µ�
                v_jsxqrq.addMonths(1);
            }
            tmp_date = new Date(v_jsxqrq.Format("yyyy/MM/01"));
            tmp_date.addDays(-1);
            v_jsxqrq = tmp_date;

            i_txfpksrq.val(v_qsxqrq);
            i_txfpjsrq.val(v_jsxqrq.Format("yyyy-MM-dd"));
            s_txfpksrq.text(v_qsxqrq);
            s_txfpjsrq.text(v_jsxqrq.Format("yyyy-MM-dd"));
        } else {
            i_txfpksrq.val("");
            i_txfpjsrq.val("");
            s_txfpksrq.text("");
            s_txfpjsrq.text("");

        }

    }

    var handleBGBM = function () {
        $(id_tyxqnx).attr("disabled", null);
        $(id_qsxqrq).attr("disabled", null);
        $(id_jzxqrq).attr("disabled", null);
        $(id_jjbcj1).attr("disabled", null);
        $(id_jjbcj2).attr("disabled", null);
        $(id_txfpkh).attr("disabled", null);
        $(id_txfpksrq).attr("disabled", null);
        $(id_txfpjsrq).attr("disabled", null);
        $(id_qsxqrq + "_tdwrap>div").show();
        $(id_jzxqrq + "_tdwrap>div").show();
        $(id_txfpksrq + "_tdwrap>div").show();
        $(id_txfpjsrq + "_tdwrap>div").show();


        var v_bgbm = $(id_bgbm).val();
        if (v_bgbm == "1") {
            //��ͬ���ڲ���ǩ

            $(id_tyxqnx).val("").attr("disabled", "disabled");
            $(id_qsxqrq).val("").attr("disabled", "disabled");
            $(id_jzxqrq).val("").attr("disabled", "disabled");
            $(id_jjbcj1).val("").attr("disabled", "disabled");
            $(id_txfpkh).val("").attr("disabled", "disabled");

            $(id_qsxqrq + "span").text("");
            $(id_jzxqrq + "span").text("");
            $(id_qsxqrq + "_tdwrap>div").hide();
            $(id_jzxqrq + "_tdwrap>div").hide();

            $(id_txfpksrq).val("").attr("disabled", "disabled");
            $(id_txfpjsrq).val("").attr("disabled", "disabled");
            $(id_txfpksrq + "span").text("");
            $(id_txfpjsrq + "span").text("");
            $(id_txfpksrq + "_tdwrap>div").hide();
            $(id_txfpjsrq + "_tdwrap>div").hide();



        } else if (v_bgbm == "2") {
            //����
            $(id_tyxqnx).val("").attr("disabled", "disabled");
            $(id_qsxqrq).val("").attr("disabled", "disabled");
            $(id_jzxqrq).val("").attr("disabled", "disabled");
            $(id_jjbcj2).val("").attr("disabled", "disabled");
            $(id_txfpkh).val("").attr("disabled", "disabled");

            $(id_qsxqrq + "span").text("");
            $(id_jzxqrq + "span").text("");
            $(id_qsxqrq + "_tdwrap>div").hide();
            $(id_jzxqrq + "_tdwrap>div").hide();

            $(id_txfpksrq).val("").attr("disabled", "disabled");
            $(id_txfpjsrq).val("").attr("disabled", "disabled");
            $(id_txfpksrq + "span").text("");
            $(id_txfpjsrq + "span").text("");
            $(id_txfpksrq + "_tdwrap>div").hide();
            $(id_txfpjsrq + "_tdwrap>div").hide();

        } else if (v_bgbm == "3") {
            //��ͬ��ǩ
            $(id_jjbcj1).val("").attr("disabled", "disabled");
            $(id_jjbcj2).val("").attr("disabled", "disabled");
            $(id_txfpkh).val("").attr("disabled", "disabled");

            $(id_txfpksrq).val("").attr("disabled", "disabled");
            $(id_txfpjsrq).val("").attr("disabled", "disabled");
            $(id_txfpksrq + "span").text("");
            $(id_txfpjsrq + "span").text("");
            $(id_txfpksrq + "_tdwrap>div").hide();
            $(id_txfpjsrq + "_tdwrap>div").hide();


        } else if (v_bgbm == "4") 
        {
        
        //������趨Ϊ��������
        $(id_tyxqnx).val("").attr("disabled","disabled");  
        $(id_qsxqrq).val("").attr("disabled","disabled");
        $(id_jzxqrq).val("").attr("disabled","disabled");
        
        $(id_jjbcj1).val("").attr("disabled","disabled"); 
        $(id_jjbcj2).val("").attr("disabled","disabled"); 
        $(id_txfpkh).val("").attr("disabled","disabled"); 
        $(id_txfpksrq).val("").attr("disabled","disabled");
        $(id_txfpjsrq).val("").attr("disabled", "disabled");
        $(id_qsxqrq + "span").text("");
        $(id_jzxqrq + "span").text("");
        $(id_qsxqrq + "_tdwrap>div").hide();
        $(id_jzxqrq + "_tdwrap>div").hide();

        $(id_txfpksrq + "span").text("");
        $(id_txfpjsrq + "span").text("");
        $(id_txfpksrq + "_tdwrap>div").hide();
        $(id_txfpjsrq + "_tdwrap>div").hide();
        } 
        else if (  v_bgbm == "5") {
            //���ݷ�Ƹ
            $(id_tyxqnx).val("").attr("disabled", "disabled");
            $(id_qsxqrq).val("").attr("disabled", "disabled");
            $(id_jzxqrq).val("").attr("disabled", "disabled");
            $(id_jjbcj1).val("").attr("disabled", "disabled");
            $(id_jjbcj2).val("").attr("disabled", "disabled");

            $(id_qsxqrq + "span").text("");
            $(id_jzxqrq + "span").text("");
            $(id_qsxqrq + "_tdwrap>div").hide();
            $(id_jzxqrq + "_tdwrap>div").hide();


        }
    }

    jQuery(document).ready(function () {
        $(id_tyxqnx).change(setNX);
        $(id_txfpkh).change(setFPNX);
        //        $(".width400 input").each(function () { $(this).attr("style", "width:400px;"); });
        //        $(".width1000 input").each(function () { $(this).attr("style", "width:1000px;"); });

        //        $(".width400 textarea").each(function () { $(this).attr("style", "width:400px;"); });
        //        $(".width1000 textarea").each(function () { $(this).attr("style", "width:1000px;"); });
        jQuery(id_bgbm).bindPropertyChange(function () { handleBGBM(); });
    });

</script>


