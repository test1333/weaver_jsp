<script type="text/javascript">
    /*
    3.1)不能晚于合同约定试用期截止日期
    3.2) 基本工资: 默认任用核薪单，可修改(通过面试任用表中的工号=试用考核表工号)
    3.3) 绩效标准: 默认任用核薪单，可修改(通过面试任用表中的工号=试用考核表工号)
    3.4)试用期满总收入=基本工资+管理津贴+专业津贴+绩效标准
    3.5) 试用期满月总收入上涨金额=试用期满月总收入-试用期总收入
    3.6) 基本工资上涨金额=试用期满基本工资-试用期基本工资
    3.7) 管理津贴上涨金额=试用期满管理津贴-试用期管理津贴
    3.8) 试用期满专业津贴-试用期专业津贴
    3.9) 试用期满绩效奖金基数-试用期绩效奖金基数
    */


    var id_syqzsr = "field6842"; //试用期总收入
    var id_syqjbgz = "field7014"; //试用期基本工资
    var id_syqzyjt = "field6845"; //试用期专业津贴
    var id_syqgljt = "field6844"; //试用期管理津贴
    var id_syqjxbz = "field6846"; //试用期绩效标准

    var id_syqmzsr = "field6847"; //试用期满总收入
    var id_syqmjbgz = "field6850"; //试用期满基本工资
    var id_syqmzyjt = "field6852"; //试用期满专业津贴
    var id_syqmgljt = "field6851"; //试用期满管理津贴
    var id_syqmjxbz = "field6853"; //试用期满绩效标准

    var id_syqszzsr = "field6854"; //试用期上涨总收入
    var id_syqszjbgz = "field6855"; //试用期上涨基本工资
    var id_syqszzyjt = "field6857"; //试用期上涨专业津贴
    var id_syqszgljt = "field6856"; //试用期上涨管理津贴
    var id_syqszjxbz = "field6858"; //试用期上涨绩效标准


    checkCustomize = function () {
        var isSuccess = true;


        return isSuccess;
    }
    //计算试用期满总收入
    var calcSYQMZSR = function () {
        //试用期
        var i_syqzsr = $("#" + id_syqzsr); //试用期总收入
        var i_syqjbgz = $("#" + id_syqjbgz); //试用期基本工资
        var i_syqzyjt = $("#" + id_syqzyjt); //试用期专业津贴
        var i_syqgljt = $("#" + id_syqgljt); //试用期管理津贴
        var i_syqjxbz = $("#" + id_syqjxbz); //试用期绩效标准

        var s_syqzsr = $("#" + id_syqzsr + "span"); //试用期总收入
        var s_syqjbgz = $("#" + id_syqjbgz + "span"); //试用期基本工资
        var s_syqzyjt = $("#" + id_syqzyjt + "span"); //试用期专业津贴
        var s_syqgljt = $("#" + id_syqgljt + "span"); //试用期管理津贴
        var s_syqjxbz = $("#" + id_syqjxbz + "span"); //试用期绩效标准

        var v_syqjbgz = isNaN(i_syqjbgz.val()) || i_syqjbgz.val() == "" ? 0 : parseFloat(i_syqjbgz.val());
        var v_syqgljt = isNaN(i_syqgljt.val()) || i_syqgljt.val() == "" ? 0 : parseFloat(i_syqgljt.val());
        var v_syqzyjt = isNaN(i_syqzyjt.val()) || i_syqzyjt.val() == "" ? 0 : parseFloat(i_syqzyjt.val());
        var v_syqjxbz = isNaN(i_syqjxbz.val()) || i_syqjxbz.val() == "" ? 0 : parseFloat(i_syqjxbz.val());

        s_syqzsr.text(v_syqjbgz + v_syqgljt + v_syqzyjt + v_syqjxbz);
        i_syqzsr.val(v_syqjbgz + v_syqgljt + v_syqzyjt + v_syqjxbz);

        var v_syqzsr = isNaN(i_syqzsr.val()) || i_syqzsr.val() == "" ? 0 : parseFloat(i_syqzsr.val());

        //试用期满
        var i_syqmzsr = $("#" + id_syqmzsr); //试用期满总收入
        var i_syqmjbgz = $("#" + id_syqmjbgz); //试用期满基本工资
        var i_syqmzyjt = $("#" + id_syqmzyjt); //试用期满专业津贴
        var i_syqmgljt = $("#" + id_syqmgljt); //试用期满管理津贴
        var i_syqmjxbz = $("#" + id_syqmjxbz); //试用期满绩效标准

        var s_syqmzsr = $("#" + id_syqmzsr + "span"); //试用期满总收入
        var s_syqmjbgz = $("#" + id_syqmjbgz + "span"); //试用期满基本工资
        var s_syqmzyjt = $("#" + id_syqmzyjt + "span"); //试用期满专业津贴
        var s_syqmgljt = $("#" + id_syqmgljt + "span"); //试用期满管理津贴
        var s_syqmjxbz = $("#" + id_syqmjxbz + "span"); //试用期满绩效标准


        var v_syqmjbgz = isNaN(i_syqmjbgz.val()) || i_syqmjbgz.val() == "" ? 0 : parseFloat(i_syqmjbgz.val());
        var v_syqmgljt = isNaN(i_syqmgljt.val()) || i_syqmgljt.val() == "" ? 0 : parseFloat(i_syqmgljt.val());
        var v_syqmzyjt = isNaN(i_syqmzyjt.val()) || i_syqmzyjt.val() == "" ? 0 : parseFloat(i_syqmzyjt.val());
        var v_syqmjxbz = isNaN(i_syqmjxbz.val()) || i_syqmjxbz.val() == "" ? 0 : parseFloat(i_syqmjxbz.val());

        //s_syqmzsr.text(v_syqmjbgz + v_syqmgljt + v_syqmzyjt + v_syqmjxbz);
        i_syqmzsr.val(v_syqmjbgz + v_syqmgljt + v_syqmzyjt + v_syqmjxbz);
        var v_syqmzsr = isNaN(i_syqmzsr.val()) || i_syqmzsr.val() == "" ? 0 : parseFloat(i_syqmzsr.val());


        //上涨
        var i_syqszzsr = $("#" + id_syqszzsr); //试用期上涨总收入
        var i_syqszjbgz = $("#" + id_syqszjbgz); //试用期上涨基本工资
        var i_syqszzyjt = $("#" + id_syqszzyjt); //试用期上涨专业津贴
        var i_syqszgljt = $("#" + id_syqszgljt); //试用期上涨管理津贴
        var i_syqszjxbz = $("#" + id_syqszjxbz); //试用期上涨绩效标准

        var s_syqszzsr = $("#" + id_syqszzsr + "span"); //试用期上涨总收入
        var s_syqszjbgz = $("#" + id_syqszjbgz + "span"); //试用期上涨基本工资
        var s_syqszzyjt = $("#" + id_syqszzyjt + "span"); //试用期上涨专业津贴
        var s_syqszgljt = $("#" + id_syqszgljt + "span"); //试用期上涨管理津贴
        var s_syqszjxbz = $("#" + id_syqszjxbz + "span"); //试用期上涨绩效标准

        i_syqszzsr.val(v_syqmzsr - v_syqzsr);
        s_syqszzsr.text(v_syqmzsr - v_syqzsr);

        i_syqszjbgz.val(v_syqmjbgz - v_syqjbgz);
        s_syqszjbgz.text(v_syqmjbgz - v_syqjbgz);

        i_syqszgljt.val(v_syqmgljt - v_syqgljt);
        s_syqszgljt.text(v_syqmgljt - v_syqgljt);

        i_syqszzyjt.val(v_syqmzyjt - v_syqzyjt);
        s_syqszzyjt.text(v_syqmzyjt - v_syqzyjt);

        i_syqszjxbz.val(v_syqmjxbz - v_syqjxbz);
        s_syqszjxbz.text(v_syqmjxbz - v_syqjxbz);


    }

    jQuery(document).ready(function () {
        $("#" + id_syqzsr).change(calcSYQMZSR); //试用期满基本工资
        $("#" + id_syqjbgz).change(calcSYQMZSR); //试用期满管理津贴
        $("#" + id_syqzyjt).change(calcSYQMZSR); //试用期满专业津贴
        $("#" + id_syqgljt).change(calcSYQMZSR); //试用期满绩效标准
        $("#" + id_syqjxbz).change(calcSYQMZSR); //试用期满绩效标准




        $("#" + id_syqmzsr).change(calcSYQMZSR); //试用期满基本工资
        $("#" + id_syqmjbgz).change(calcSYQMZSR); //试用期满管理津贴
        $("#" + id_syqmzyjt).change(calcSYQMZSR); //试用期满专业津贴
        $("#" + id_syqmgljt).change(calcSYQMZSR); //试用期满绩效标准
        $("#" + id_syqmjxbz).change(calcSYQMZSR); //试用期满绩效标准



    });


</script>

