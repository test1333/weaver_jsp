<script type="text/javascript" src="/js/feiliks/IdCardValidate.js"></script>
<script type="text/javascript">
    /*
    ���֤��У��
    ��ȡ����
    ��ȡ�Ա�
    */

    var id_csrq = "#field8822"; //��������
    var id_xb = "#field9048"; //�Ա�
    var id_xbwb = "#field8763"; //�Ա��ı�
    var id_xbbm = "#field8764"; //�Ա����

    var id_zjhm = "#field8813"; //֤������
    var id_zjlxbm = "#field8759"; //֤�������� 01

    checkCustomize = function () {
        var isSuccess = true;


        isSuccess = handleZJChange();

        return isSuccess;
    }

    var handleZJChange = function () {
        var v_zjhm = $(id_zjhm).val();
        if ($(id_zjlxbm).val() == "01" && v_zjhm != "") {
            //���֤

            if (idCard_IdCardValidate(v_zjhm) == false) {
                window.top.Dialog.alert("���֤�Ų��Ϸ���");
                return false;
            } else {
                $(id_csrq).val(idCard_birthdayByIdCard(v_zjhm));
                $(id_csrq + "span").text(idCard_birthdayByIdCard(v_zjhm));

                var v_xbbm = idCard_maleOrFemalByIdCard(v_zjhm) == "male" ? "1" : "2";
                var v_xbwb = idCard_maleOrFemalByIdCard(v_zjhm) == "male" ? "��" : "Ů";
                $(id_xbbm).val(v_xbbm);
                $(id_xbbm + "span").text(v_xbbm);
                $(id_xbwb).val(v_xbwb);
                $(id_xbwb + "span").text(v_xbwb);

                $(id_xb).val(v_xbwb);
                $(id_xb + "span").empty().append($('<span class="e8_showNameClass">' + v_xbwb + '<span id="' + v_xbwb + '" class="e8_delClass" style="opacity: 1; visibility: hidden;" onclick="del(event,this,2,false,{});"> x </span></span>'));


            }


        } else {
            return true;
        }
        return true;
    }

    jQuery(document).ready(function () {
        jQuery(id_zjlxbm).bindPropertyChange(function () { handleZJChange(); }); //֤��������
        $(id_zjhm).change(function () { handleZJChange(); }); //֤������

    });



</script>

