<script type="text/javascript">




jQuery(document).ready(function(){

            
    checkCustomize = function() {
		//alert("1");
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
        
		var dj = "#field14264_";//单价
		var id_sjsyrdj = "#field16221_";//实际使用人行政等级
		var id_wpmc = "#field13057_";//物品名称
		var indexnum1 = jQuery("#indexnum0").val();
		for (var index = 0; index < indexnum1; index++) {
			if($("#field13259").val() == 92){	
			}else{
				if(isNaN($(dj+index).val())||parseFloat($(dj+index).val()) ==0||$(dj+index).val()==""){
					alert("单价不能为0");
					return false;
				}
			}

		}
		 for (var index = 0; index < indexnum1; index++) {
			//alert(index);
			//alert("1"+$(id_wpmc+index+"span").text()+"1");
			//alert($(id_wpmc+index).val());
			if($(id_wpmc+index+"span a").text() == "笔记本电脑"){
				//alert("2");
				//alert($(id_sjsyrdj+index).val());
				//alert($(dj+index).val());
				if(parseInt($(id_sjsyrdj+index).val()) <= 4 && $(dj+index).val() > 4500){
					
					alert("超制度规定金额，请参考制度重新设置物品金额。");
					return false;
					
				}else if(parseInt($(id_sjsyrdj+index).val()) >= 5 && parseInt($(id_sjsyrdj+index).val()) <= 6 && $(dj+index).val() > 5000){
					alert("超制度规定金额，请参考制度重新设置物品金额。");
					return false;
					
				}else if(parseInt($(id_sjsyrdj+index).val()) >= 7 && parseInt($(id_sjsyrdj+index).val()) <= 9 && $(dj+index).val() > 7000){
					alert("超制度规定金额，请参考制度重新设置物品金额。");
					return false;
					
				}else if(parseInt($(id_sjsyrdj+index).val()) >= 10 && $(dj+index).val() > 9000){
					alert("超制度规定金额，请参考制度重新设置物品金额。");
					return false;
					
				}
			
			}

		} 
		  var alert_ct = true;
		for(index=0;index<indexnum0_temp;index++){
          //if(jQuery("#"+_budget_temp+index).length>0){
            if (val_all(index, alert_ct)==false) {
                  alert_ct = false;
            }
          // }
        }
         function val_all(index,alert_ct) {
                var account_all = "";
                //var money_all=jQuery("#"+_cptmoney+index).val();
               // for (yet = 0; yet < indexnum0; yet++) {
                 //   var key_num_index = jQuery("#" + _keyNum + index).val();
                 //   var key_num_yet = jQuery("#" + _keyNum + yet).val();
                 //   if (key_num_index == key_num_yet) {
                 //       account_all = Number(account_all) + Number(jQuery("#" + _account + yet).val());
                //    }
                //}
                //alert("account_all="+account_all);
				 var tmp_index_account = jQuery("#" + _account + index).val();
                var _budget_all = jQuery("#" + _budget_temp + index).val();
                //alert("_budget_all="+_budget_all);
                if (_budget_all != "") {
                    var temp = new Array();
                    temp = _budget_all.toString().split(",");
                    temp[0] = temp[0].replace('可用预算数:', '');
                    temp[1] = temp[1].replace('冻结预算数:', '');
                    temp[2] = temp[2].replace('已使用预算数:', '');
                    //temp[3] = temp[3].replace('当月预算数:', '');
					
					if(temp[0] == "") temp[0] = "0";
                    if(temp[1] == "") temp[1] = "0";
                    if(temp[2] == "") temp[2] = "0";
					
                    var _percent_val = jQuery("#" + _percent).val();
                    var tmp_index_fm = Number(temp[0]) + Number(temp[1]) + Number(temp[2]);
                     if(tmp_index_fm <= 0){
                        tmp_index_fm = 1;
                    }
					 var tmp_index_fz = Number(tmp_index_account) - Number(temp[0]) + Number(temp[1]);
                    //alert(tempx);
					 if(Number(tmp_index_account) - Number(temp[0]) <= 0 ){
                        tmp_index_fz = 0;
                    }
                     var _percent_now = tmp_index_fz /tmp_index_fm * 100;
                    //alert("_percent_now="+_percent_now);
					if (Number(_percent_now) > 0) {
                        if (Number(_percent_now) > Number(_percent_val)) {
                            jQuery("#" + _percent).val(Math.round(_percent_now));
                            jQuery("#" + _percent + "span").text(Math.round(_percent_now));
                            //alert("_percent="+_percent);
                        }
                        if (alert_ct) {
                            alert("申请物品金额超预算!");
                        }
                        return false;

                    }
                   
                }
                return true;
            } 

      return false;
    }


})

</script>













