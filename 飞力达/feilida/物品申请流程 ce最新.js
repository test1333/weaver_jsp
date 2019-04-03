<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
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
	//alert("wwww");
	//明细1
	//var qjr_code = "field27310_"; //人员工号
	//var qjr_id = "field27311_"; //人员姓名
	var oadate = "#field11962"; //申请日期
	var useDept = "#field11967"; //使用部门
	var appDept = "#field11969"; //申请部门
	//var amount = "field27318_"; //预计结束开始时间
	var costCenter = "#field13665"; //成本中心
	var costCenter1 = "#field13666"; //责任成本中心
       var GSBER = "#field13781";//业务范围
       var ysly = "#field11973";//预算来源
         //备注
        var id_flag = "#field13754";//备注标志
        var id_lb = "#field13258";//类别
        var id_xz = "#field13259";//性质
        //$(id_flag).val($(id_sqrgs).val()=="资讯" && $(id_xz).val() == "固定资产")?"1":"0");


	//明细
	var _cpt = "field13057_"; //物品名称
	var _budget = "field11981_"; //预算信息
	var _cptNumber = "field13721_"; //资产编号
	var _cptmoney= "field13718_"; //预算金额
	var _cptKSTAR= "field13721_"; //科目id
      var _cptxz= "field13745"; //性质
    var _keyNum = "field13723_";//标识码
    var _Num = "field11980_";//数量
    var _usePerson= "field13801_";//实际使用人
jQuery(document).ready(function () {

	
        checkCustomize = function () {
            var _cptxz_val=jQuery("#"+_cptxz).val();
            if(_cptxz_val=="固定资产" || _cptxz_val=="列管资产"){
                var indexnum0 = jQuery("#indexnum0").val();
                for(index=0;index<indexnum0;index++){
                	if(jQuery("#"+_Num+index).length>0){
                    var _Num_val=jQuery("#"+_Num+index).val();
                    var _usePerson_val=jQuery("#"+_usePerson+index).val();
                    if(Number(_Num_val)!=1 ||_usePerson_val==""){
                        alert("固定资产或列管资产申请数量只能为1并且实际使用人必须填写！")
                        return false;
                    }
                }
            }
            }
            
                var id_pm = "#field14561";//品名
		var id_wpmc = "#field13057";//物品名称	
//var span=$("#oTable0 span[name*='field13057_'] a")
		$(id_pm).val($("#oTable0 span[name*='field13057_'] a").eq(0).text());	
	
            return true;
        }


      var nodesnum0=jQuery("#nodesnum0").val();
        	 var indexnum0=jQuery("#indexnum0").val();
        	 if(nodesnum0>0){
                       
			 for(var index=0;index<indexnum0;index++){
				 if(jQuery("#"+_cptKSTAR+index).length>0){
				    fl_dtChange(_cptKSTAR, index) ;
				      jQuery("#" + _budget + index).attr("readonly", "readonly");
                jQuery("#" + _keyNum + index).attr("readonly", "readonly");
                jQuery("#" + _cptmoney + index).attr("readonly", "readonly");
				 }
			 }
		 }

});
 jQuery("button[name=addbutton0]").live("click", function () {
 	   var indexnum3 = jQuery("#indexnum0").val();
 	fl_dtChange(_cptNumber, indexnum3-1);
 });
	jQuery("#indexnum0").bindPropertyChange(function () {
		fl_getBudget();
		//adoreFunction();
	});
	  jQuery(ysly).bindPropertyChange(function () {
    //  alert(111);
        get_cost_info();
    });
 jQuery(GSBER).bindPropertyChange(function () {
    //  alert(111);
        get_cost_info();
    });
	jQuery(useDept).bindPropertyChange(function () {
	//	alert(111);
		get_cost_info();
	});

	//jQuery(appDept).bindPropertyChange(function () {
	//alert(222);
	//	get_cost_info(oadate, appDept, costCenter);
	//});

	function fl_getBudget() {
		var nowRow = parseInt($G("indexnum0").value) - 1;
		//fl_dtChange(_budget, nowRow);
		fl_dtChange(_cptNumber, nowRow);
	}

	function fl_dtChange(tmpObj, nowRow) {
		
			jQuery("#" + _cptKSTAR + nowRow).bindPropertyChange(function () {
	
			var tmp_budget = "#" + _budget + nowRow;
			var tmp_cptNumber = "#" + _cptNumber + nowRow;
                   var tmp_money= "#" + _cptmoney + nowRow;
                    var tmp_KSTAR = "#" + _cptKSTAR + nowRow;
                    var tmp_keyNum = "#" + _keyNum + nowRow;
			get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum);
		});
	}

	function get_cost_info() {
		var oadate_val = jQuery(oadate).val();
		var oadept_val = jQuery(useDept).val();
	//	alert("oadate_val1=" + oadate_val);
           var GSBER_val = jQuery(GSBER).find("option:selected").text();
          var ysly_val = jQuery(ysly).val();
        if(ysly_val !='1'){
        	GSBER_val = '';
       } 
		var amount = "0";
		if (oadept_val.length > 0 && oadept_val.length > 0) {
                                     // alert("1");
			jQuery.post("/feilida/js/cpt/fl_getCptInfoNew.jsp", {
				"OADATE": oadate_val,
				"DEPTID": oadept_val,
				"AMOUNT": amount,
				"KOSTL":GSBER_val
			}, function (data) {
				data = data.replace(/\n/g, "").replace(/\r/g, "");
				//alert(data);
				eval('var obj =' + data);
				var KOSTL = obj.KOSTL;
				var MSGTYP = obj.MSGTYP;
				var MSGTXT = obj.MSGTXT;
                         
				if (KOSTL == '') {
                    alert("未找到对应的成本中心，请联系管理员");
					jQuery(costCenter).val("");
					jQuery(costCenter + "span").html("");
					jQuery(costCenter1).val("");
					jQuery(costCenter1 + "span").html("");
				} else {
					jQuery(costCenter).val(KOSTL);
					jQuery(costCenter + "span").html(KOSTL);
					
					jQuery(costCenter1).val(KOSTL);
					jQuery(costCenter1 + "span").html(KOSTL);
				}

			});
		}
	}

	function get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum) {
		var tmp_cptNumber_val = jQuery(tmp_cptNumber).val();
		var oadate_val = jQuery(oadate).val();
		var useDept_val = jQuery(useDept).val();
		var tmp_KSTAR_val = jQuery(tmp_KSTAR).val();
	//	alert(oadate_val+","+useDept_val+","+tmp_cptNumber_val+","+tmp_KSTAR_val);
		var amount = "0";
		var exectype = jQuery("#"+_cptxz).val();
		//alert(exectype);
		if(exectype == "固定资产"||exectype == "待摊费用"||exectype == "长期待摊费用"){
			exectype = "1";
		}else{
		exectype = "";
		}	
	  var GSBER_val = jQuery(GSBER).find("option:selected").text();
        var ysly_val = jQuery(ysly).val();
        if(ysly_val !='1'){
        	GSBER_val = '';
       } 
//alert(oadate_val+","+tmp_KSTAR_val+","+amount+","+useDept_val+","+exectype+","+tmp_KSTAR_val+","+GSBER_val);
   //   alert(tmp_KSTAR_val+","+GSBER_val);
		if (tmp_cptNumber.length > 0 && oadate.length > 0 && useDept_val.length > 0) {
					//	alert("进入");
			jQuery.post("/feilida/js/cpt/fl_getCptInfoNew.jsp", {
				'OADATE': oadate_val,
				'ANLKL': tmp_KSTAR_val,
				'AMOUNT': amount,
				'DEPTID': useDept_val,
				'EXECTYPE': exectype,
				'KSTAR': tmp_KSTAR_val,
                         'KOSTL':GSBER_val
			}, function (data) {
			//	alert(data);
				data = data.replace(/\n/g, "").replace(/\r/g, "");
				eval('var obj =' + data);
				var AMOUNT0 = obj.AMOUNT0;
				var AMOUNT1 = obj.AMOUNT1
		      	var AMOUNT2= obj.AMOUNT2;
				var AMOUNT3 = obj.AMOUNT3;
				var MSGTYP = obj.MSGTYP;
				var MSGTXT = obj.MSGTXT;
				var GPKEY = obj.GPKEY;
                         var info="可用预算数:"+AMOUNT1+", 冻结预算数:"+AMOUNT2+", 已使用预算数:"+AMOUNT3+", 当月预算数:"+AMOUNT0;
				if (MSGTYP != 'S') {
					alert(MSGTXT);
					jQuery(tmp_budget).val("");
					jQuery(tmp_money).val("");
					jQuery(tmp_keyNum).val("");
					
                        jQuery(tmp_budget).attr("readonly", "readonly");
                        jQuery(tmp_money).attr("readonly", "readonly");
                        jQuery(tmp_keyNum).attr("readonly", "readonly");
				} else {
					jQuery(tmp_budget).val(info);
					jQuery(tmp_money).val(AMOUNT1);
					jQuery(tmp_keyNum).val(GPKEY);
					
                        jQuery(tmp_budget).attr("readonly", "readonly");
                        jQuery(tmp_money).attr("readonly", "readonly");
                        jQuery(tmp_keyNum).attr("readonly", "readonly");
				}
			});
		}
	}
	setTimeout(' get_cost_info()',1500);
</script>



























































