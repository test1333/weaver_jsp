<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    网络打卡需求:
   1.   因为SAP对接接口中上,下班只认代码。
      所以表单中刷卡类型选择”上班”的时候，则带出上班类型代码为P10.
       表单中刷卡类型选择”下班”的时候，则带出上班类型代码为P20.
         
    */
    var id_sklx = "#field10197";//刷卡类型 
    var id_sxbsklx = "#field10734"; //上下班刷卡类型
    
    var setNX = function () {
        var i_sklx = $(id_sklx + " option:selected"); //刷卡类型 

        if (i_sklx.text() == "上班") {
            $(id_sxbsklx).val("P10").attr("value","P10");
        } else if (i_sklx.text() == "下班") {
            $(id_sxbsklx).val("P20").attr("value","P20");
        } else {
            $(id_sxbsklx).val("").attr("value","");
        }
       // alert($(id_sxbsklx).val() )
    } 

    checkCustomize = function () {
        var isSuccess = true;
        setNX();
        return isSuccess;
    }


    jQuery(document).ready(function () {
        $(id_sklx).change(setNX);
        jQuery(id_sklx).bindPropertyChange(function () { setNX(); });
        setNX();
    }); 
</script>


