<script type="text/javascript" src="/js/feiliks/IdCardValidate.js"></script>
<script type="text/javascript">
    /*
    �����գ������Զ�ƴ��Ϊ������ʾ�ڱ��ϵġ�¼����Ա�������ֶ�,лл��
    */
    var id_x = "#field11197"; //�� 
    var id_m = "#field11198"; //��
    var id_xm = "#field11101"; //����


    var id_csrq = "#field11071"; //��������
    var id_xb = "#field11215"; //�Ա�
    var id_xbwb = "#field11216"; //�Ա��ı�
    var id_xbbm = "#field11073"; //�Ա����

    var id_zjhm = "#field11037"; //֤������
    var id_zjlxbm = "#field11070"; //֤�������� 01

    var setXM = function () {
        $(id_xm).val($(id_x).val() + $(id_m).val());
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
    checkCustomize = function () {
        var isSuccess = true;


        isSuccess = handleZJChange();

        return isSuccess;
    }

    jQuery(document).ready(function () {
        jQuery(id_x).bindPropertyChange(function () { setXM(); });
        jQuery(id_m).bindPropertyChange(function () { setXM(); });

        jQuery(id_zjlxbm).bindPropertyChange(function () { handleZJChange(); }); //֤��������
        $(id_zjhm).change(function () { handleZJChange(); }); //֤������

    }); 
</script>

