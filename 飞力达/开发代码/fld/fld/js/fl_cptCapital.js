//控制明细选择物品名称
jQuery(document).ready(function () {
    var _subcompany = "#field13260"; // 资产所属公司
    var _type = "#field13258"; // 类别
    var _prop = "#field13259"; // 性质

    jQuery(_subcompany).bindPropertyChange(function () {
        adoreFunction();
    });

    jQuery(_type).bindPropertyChange(function () {
        jQuery(_prop).val("");
        jQuery(_prop + "span").html("");
        document.getElementById("field13259spanimg").innerHTML = "<img src='/images/BacoError_wev8.gif' align='absMiddle'></img>";

        adoreFunction();
    });

    jQuery(_prop).bindPropertyChange(function () {
        adoreFunction();
    });

    function adoreFunction() {
        var _indexnum0 = jQuery("#indexnum0").val();
        var _nodesnum0 = jQuery("#nodesnum0").val();
        //alert("_indexnum0=" + _indexnum0);
        //alert("_nodesnum0=" + _nodesnum0);
        if (_nodesnum0 > 0) {
            for (var i = _indexnum0 - _nodesnum0; i < _indexnum0; i++) {
                var _cptName = "field13057_"; //物品名称
                var _cptName_val = jQuery("#" + _cptName + i).val();
                if (_cptName_val.length > 0) {
                    //alert("length=" + _cptName_val.length);
                    jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                    deleteRow0(0);
                }
            }
        }
    } //要注意的是，页面删除，明细的下标 将不复用
});