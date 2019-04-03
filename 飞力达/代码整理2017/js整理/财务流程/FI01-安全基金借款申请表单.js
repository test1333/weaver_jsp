<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    需求一： 
凭证摘要栏位自动生成：
生成规则：凭证摘要=日期“月份”+事故责任人姓名+安全基金借款（明细表循环取值，用”/”隔开，不能超过50个字符）

    */

    var id_qkrq = "#field9406"; //请款日期
    var id_pzzy = "#field10841";//凭证摘要
    var id_lk = "#field9511";//安全基金借款
    checkCustomize = function () {
        var isSuccess = true;
	var str=new Date($(id_qkrq).val().replace(/-/g, "/")).Format("MM");
	$("td[name='td_sgzrrxm']").each(function(){
	str=str+"/"+$(this).find("span").text()+"/"+$(id_lk).val();
	}
    );
        

        $(id_pzzy).val(str);
        return isSuccess;
    }

    



    jQuery(document).ready(function () {
        //jQuery(id_ksrq).bindPropertyChange(function () { resetCheck(); resetQJSS(); }); //开始日期
        
    });



</script>





