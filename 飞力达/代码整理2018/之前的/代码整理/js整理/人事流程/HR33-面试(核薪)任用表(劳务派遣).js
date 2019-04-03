<script type="text/javascript" src="/js/feiliks/IdCardValidate.js"></script>
<script type="text/javascript">
    /*
    输入姓，名后自动拼接为姓名显示在表单上的“录用人员姓名”字段,谢谢。
    */
    var id_x = "#field11197"; //姓 
    var id_m = "#field11198"; //名
    var id_xm = "#field11101"; //姓名


    var id_csrq = "#field11071"; //出生日期
    var id_xb = "#field11215"; //性别
    var id_xbwb = "#field11216"; //性别文本
    var id_xbbm = "#field11073"; //性别编码

    var id_zjhm = "#field11037"; //证件号码
    var id_zjlxbm = "#field11070"; //证件类别编码 01

    var setXM = function () {
        $(id_xm).val($(id_x).val() + $(id_m).val());
    }

    var handleZJChange = function () {
        var v_zjhm = $(id_zjhm).val();
        if ($(id_zjlxbm).val() == "01" && v_zjhm != "") {
            //身份证

            if (idCard_IdCardValidate(v_zjhm) == false) {
                window.top.Dialog.alert("身份证号不合法！");
                return false;
            } else {
                $(id_csrq).val(idCard_birthdayByIdCard(v_zjhm));
                $(id_csrq + "span").text(idCard_birthdayByIdCard(v_zjhm));

                var v_xbbm = idCard_maleOrFemalByIdCard(v_zjhm) == "male" ? "1" : "2";
                var v_xbwb = idCard_maleOrFemalByIdCard(v_zjhm) == "male" ? "男" : "女";
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

        jQuery(id_zjlxbm).bindPropertyChange(function () { handleZJChange(); }); //证件类别编码
        $(id_zjhm).change(function () { handleZJChange(); }); //证件号码

    }); 
</script>

