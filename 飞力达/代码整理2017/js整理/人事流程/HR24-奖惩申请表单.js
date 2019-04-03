<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    奖惩金额: 根据奖惩类别判断(需要用户定义关系)
    嘉奖、记功、记大功Y1、Y2、Y3
    200、500、1500
    警告、记过、记大过Z1、

    生效日期: 不能早于申请日期

    20160916
    奖惩申请表单中新增管控点:
    奖惩类别编码输入完毕后自动将奖惩类型编码,奖惩类型带出来。
    带出的原则如下:
    1.如果奖惩类别编码第一码是Y,则自动给奖惩类型编码为:2000,奖惩类型:惩戒
    2. .如果奖惩类别编码第一码是Z,则自动给奖惩类型编码为:1000,奖惩类型:奖励
    */


    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $("#field6533"); //申请日期
        var i_sxrq = $("#field6674"); //生效日期

        var d1 = new Date(i_sqrq.val().replace(/-/g, "/"));
        var d2 = new Date(i_sxrq.val().replace(/-/g, "/"));
        if (d1 <= d2) { } else {
            window.top.Dialog.alert("生效日期不能早于申请日期");
            isSuccess = false;
            return false;

        }

        return isSuccess;
    }

    var setJE = function () {
        var id_jclb = "#field8345"; //奖惩类别代码
        var id_jcje = "#field6780"; //奖惩金额

        var id_jclxbm = "#field8346"; //奖惩类型编码
        var id_jclx = "#field8347"; //奖惩类型

        var v_jclb = $(id_jclb).val();
        var v_jcje = 0;
        if (v_jclb == "Y1") {
            v_jcje = 200;
        } else if (v_jclb == "Y2") {
            v_jcje = 500;
        } else if (v_jclb == "Y3") {
            v_jcje = 1500;
        } else if (v_jclb == "Z1") {
            v_jcje = 200;
        } else if (v_jclb == "Z2") {
            v_jcje = 500;
        } else if (v_jclb == "Z3") {
            v_jcje = 1500;
        }
        if (v_jcje > 0) {
            $(id_jcje).val(v_jcje);
            //$(id_jcje + "span").text(v_jcje);
        } else {
            $(id_jcje).val("");
            //$(id_jcje + "span").text("");
        }

        if (v_jclb.indexOf("Y") > -1) {
            $(id_jclxbm).val("2000");
            $(id_jclx).val("惩戒");
            $(id_jclxbm + "span").text("2000");
            $(id_jclx + "span").text("惩戒");

        } else {
            $(id_jclxbm).val("1000");
            $(id_jclx).val("奖励");
            $(id_jclxbm + "span").text("1000");
            $(id_jclx + "span").text("奖励");

        }
    }

    jQuery(document).ready(function () {
        jQuery("#field8345").bindPropertyChange(function () { setJE(); });

    });

</script>

