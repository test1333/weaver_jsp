<script type="text/javascript">

var id_sapsl = "#field13705_";//sap税率
var id_sj = "#field13706_";//税金
var id_smsj = "#field23083_";//税码税金
var id_sl = "#field23183_";//税率
var id_hsdj = "#field14264_";//含税单价
var id_bhsdj = "#field23063_";//不含税单价
var id_shul = "#field11980_";//数量
var id_zj = "#field13722_";//不含税总价
var id_bz = "#field11982_";//备注
var id_hszj = "#field23224_";//含税总价

function bind() {
	var indexnum0 = jQuery("#indexnum0").val();
	for (var index = 0; index <= indexnum0; index++) {
		if (jQuery(id_smsj + index).length > 0) {
			bindchange(index);
		}
		if (jQuery(id_sj + index).length > 0) {
			bindchange2(index);
		}
		
		
	}
}

function bindchange(numx) {
	
	jQuery(id_smsj + numx).bindPropertyChange(function () {
		var smsj_val = jQuery(id_smsj + numx).val();
		var shul_val = $(id_shul + numx).val();
		jQuery(id_sj + numx).val(smsj_val * shul_val);
		var hsdj_val = $(id_hsdj + numx).val();
		$(id_hszj + numx).val(hsdj_val * shul_val);
	});
	
	/* jQuery(id_shul + numx).bindPropertyChange(function () {
		var smsj_val = jQuery(id_smsj + numx).val();
		var shul_val = $(id_shul + numx).val();
		jQuery(id_sj + numx).val(smsj_val * shul_val);
		var bhsdj_val = $(id_bhsdj + numx).val();
		$(id_zj + numx).val(bhsdj_val * shul_val);
		$(id_zj + numx +"span").text(bhsdj_val * shul_val);
		
	}); */
	
	jQuery(id_sapsl + numx).bindPropertyChange(function () {
			$(id_sl + numx).val($(id_sapsl + numx).val())
			
	});
	jQuery(id_bhsdj + numx).bindPropertyChange(function () {
		var bhsdj_val = $(id_bhsdj + numx).val();
		var shul_val = $(id_shul + numx).val();
		$(id_zj + numx).val(bhsdj_val * shul_val);
		
	});
	jQuery(id_hsdj + numx).bindPropertyChange(function () {
		var shul_val = $(id_shul + numx).val();
		var hsdj_val = $(id_hsdj + numx).val();
		$(id_hszj + numx).val(hsdj_val * shul_val);
		
		
	});
	
	
}

function bindchange2(numx) {
	jQuery(id_sj + numx).bindPropertyChange(function () {
		var smsj_val = jQuery(id_smsj + numx).val();
		var hsdj_val = jQuery(id_hsdj + numx).val();
		var diff = Number(hsdj_val) - Number(smsj_val);
		diff = diff.toFixed(2);
		jQuery(id_bhsdj + numx).val(diff);
		//jQuery(bhsje + numx + "span").text(diff);
	})
}

jQuery(document).ready(function(){
	bind();
            
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
		for (var index = 0; index < indexnum0; index++) {
			if($("#field13259span a").text() == "固定资产" ){
				//alert("固定资产");
				if( parseFloat($("#field14264_" + index).val()) < 2000){
					alert("固定资产不得小于2000。");
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
                var account_all = "0";
                //var money_all=jQuery("#"+_cptmoney+index).val();
                 for (yet = 0; yet < indexnum0; yet++) {
                   var key_num_index = jQuery("#" + _keyNum + index).val();
                   var key_num_yet = jQuery("#" + _keyNum + yet).val();
                  if (key_num_index == key_num_yet) {
					  var account_val=jQuery("#" + _account + yet).val();
					   if(account_val == ""){
						  account_val = "0";
					  }
                       account_all = accAdd(account_all,account_val);
                   }
                }
                //alert("account_all="+account_all);
				//var tmp_index_account = jQuery("#" + _account + index).val();
				var tmp_index_account=account_all;
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

      return true;
    }


})
function accAdd(arg1,arg2){
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2))
    return (arg1*m+arg2*m)/m
}


</script>




















