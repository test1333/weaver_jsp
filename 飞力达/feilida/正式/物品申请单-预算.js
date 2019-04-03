<script type="text/javascript">
jQuery(document).ready(function(){
    checkCustomize = function() {
        var _budget_temp = "field11981_";//预算信息
        var _percent = "field13661";//超出预算比
        var _keyNum = "field13723_";
        var _cptmoney = "field13718_";
        var _account = "field13722_";
        var indexnum0 = jQuery("#indexnum0").val();
        var account_all="";
        var indexnum0_temp = jQuery("#indexnum0").val();
           jQuery("#"+_percent).val(0);
           jQuery("#"+_percent+"span").text(0);
        for(index=0;index<indexnum0_temp;index++){
          //if(jQuery("#"+_budget_temp+index).length>0){
            val_all(index);
          // }
        }

            function val_all(index) {
                var account_all = "";
                //var money_all=jQuery("#"+_cptmoney+index).val();
                for (yet = 0; yet < indexnum0; yet++) {
                    var key_num_index = jQuery("#" + _keyNum + index).val();
                    var key_num_yet = jQuery("#" + _keyNum + yet).val();
                    if (key_num_index == key_num_yet) {
                        account_all = Number(account_all) + Number(jQuery("#" + _account + yet).val());
                    }
                }
                //alert("account_all="+account_all);
                var _budget_all = jQuery("#" + _budget_temp + index).val();
                //alert("_budget_all="+_budget_all);
                if (_budget_all != "") {
                    var temp = new Array();
                    temp = _budget_all.toString().split(",");
                    temp[0] = temp[0].replace('可用预算数:', '');
                    temp[1] = temp[1].replace('冻结预算数:', '');
                    temp[2] = temp[2].replace('已使用预算数:', '');
                    temp[3] = temp[3].replace('当月预算数:', '');
                    var _percent_val = jQuery("#" + _percent).val();
                    var tempx = Number(temp[0]) + Number(temp[1]) + Number(temp[2]);
                    if (tempx == 0) {
                        tempx = 1;
                    }
                    //alert(tempx);
                    var _percent_now = (Number(account_all)  - Number(temp[0])) /Number(tempx) * 100;
                    //alert("_percent_now="+_percent_now);
                    if (Number(_percent_now) > 0) {
                        if (Number(_percent_now) > Number(_percent_val)) {
                            jQuery("#" + _percent).val(Math.round(_percent_now));
                            jQuery("#" + _percent + "span").text(Math.round(_percent_now));
                        }
                        alert("申请物品金额超预算!");
                        //return false;
                    }
                }
                return true;
            }

      return true;
    }


})

</script>






