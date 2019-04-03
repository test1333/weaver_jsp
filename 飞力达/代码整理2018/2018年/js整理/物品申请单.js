<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var _subcompany = "#field13260"; // 资产所属公司
    var _type = "#field13258"; // 类别
    var _prop = "#field13259"; // 性质
    var id_pro = "#field20686";      // 项目号
	 var _cptName = "#field13057_";
    function adoreFunction() {
		
		var nodesnum0 = jQuery("#nodesnum0").val();
        if(nodesnum0 >0){
              jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                adddelid(0,_cptName);
                removeRow0(0);
        }

        
    } //要注意的是，页面删除，明细的下标 将不复用
    //66,64，141，142
    //行政：列管，固定，待摊，长期待摊
    //资讯：69,67，143
    //生产：72,70，144
    //运输厢式：103固定
    //运输集卡：104
    var handleXZ = function () {
        //alert("handleXZ ");
        //alert($("#field13259span a").text());
        //var xz_val = $(_prop).val();
        //alert(xz_val);
        if ($("#field13259span a").text() == "固定资产" || $("#field13259span a").text() == "列管资产" || $("#field13259span a").text() == "待摊费用" || $("#field13259span a").text() == "长期待摊费用") {
            //$(".td_sjsyr").show();
            //$(".td_sjsyrdj").show();
            //$(".td_sjsyrgs").show();
            // $(".td_cfdd").show();
        } else {
            //$(".td_sjsyr").hide();
            //$(".td_sjsyrdj").hide();
            //$(".td_sjsyrgs").hide();
            //$(".td_cfdd").hide();
            //$(".td_ysxx input[type='text']").css("width", "350px");

        }

    }
    //alert("wwww");
    //明细1
    //var qjr_code = "field27310_"; //人员工号
    //var qjr_id = "field27311_"; //人员姓名
    var oadate = "#field11962"; //申请日期
    var useDept = "#field11967"; //使用部门
    var appDept = "#field11969"; //申请部门
    //var amount = "field27318_"; //预计结束开始时间
    var costCenter = "#field13665"; //成本中心
    var gsmd = "#field13720"; //公司代码
    var costCenter1 = "#field13666"; //责任成本中心
    var GSBER = "#field13781"; //业务范围
    var ysly = "#field11973"; //预算来源

    //备注
    var id_flag = "#field13754"; //备注标志
    var id_lb = "#field13258"; //类别
    var id_xz = "#field13259"; //性质
    //var id_zcxz = "field13663";//资产性质
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    var id_syrgs = "#field11966"; //使用人公司
    //$(id_flag).val($(id_sqrgs).val()=="资讯" && $(id_xz).val() == "固定资产")?"1":"0");


    //明细
    var _cpt = "field13057_"; //物品名称
    var _budget = "field11981_"; //预算信息
    var _cptNumber = "field13721_"; //资产编号
    var _cptmoney = "field13718_"; //预算金额
    var _cptKSTAR = "field13721_"; //科目id
    var _cptxz = "field13745"; //性质
    var _keyNum = "field13723_"; //标识码
    var _Num = "field11980_"; //数量
    var _usePerson = "field13801_"; //实际使用人
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    var _usePersonCom = "field16341_"; //实际使用人公司
    var _usePerComId = "field16381_"; //实际使用人公司代码


    function fl_getBudget() {
		var indexnum0 = jQuery("#indexnum0").val();
		for (var index = 0; index < indexnum0; index++) {
             if (jQuery("#" + _cptNumber + index).length > 0) {
                fl_dtChange(_cptNumber, index);
             }
        }
        //var nowRow = parseInt($G("indexnum0").value) - 1;
        //fl_dtChange(_budget, nowRow);
       // fl_dtChange(_cptNumber, nowRow);
    }

    function fl_dtChange(tmpObj, nowRow) {

        jQuery("#" + _cptKSTAR + nowRow).bindPropertyChange(function () {
            var tmp_budget = "#" + _budget + nowRow;
            var tmp_cptNumber = "#" + _cptNumber + nowRow;
            var tmp_money = "#" + _cptmoney + nowRow;
            var tmp_KSTAR = "#" + _cptKSTAR + nowRow;
            var tmp_keyNum = "#" + _keyNum + nowRow;
            get_cpt_info(tmp_cptNumber, oadate, tmp_budget, tmp_money, tmp_KSTAR, tmp_keyNum);
           
// alert("调用tmp_cptNumber = " + tmp_cptNumber);
        });
    }

    function get_cost_info() {
        var oadate_val = jQuery(oadate).val();
        var oadept_val = jQuery(useDept).val();
        //	alert("oadate_val1=" + oadate_val);
        var GSBER_val = jQuery(GSBER).find("option:selected").text();
        var ysly_val = jQuery(ysly).val();
        if (ysly_val != '1') {
            GSBER_val = '';
        }
    }
     
    function get_cpt_info(tmp_cptNumber, oadate, tmp_budget, tmp_money, tmp_KSTAR, tmp_keyNum) {
        //alert("调用cptinfo");
        var tmp_cptNumber_val = jQuery(tmp_cptNumber).val();
        var oadate_val = jQuery(oadate).val();
        var useDept_val = jQuery(useDept).val();
        var tmp_KSTAR_val = jQuery(tmp_KSTAR).val();
        var project_val = jQuery(id_pro).val();
    	//alert(oadate_val+","+useDept_val+","+tmp_cptNumber_val+","+tmp_KSTAR_val);
        var amount = "0";
        var exectype = jQuery("#" + _cptxz).val();
        //alert(exectype);
        if (exectype == "固定资产" || exectype == "待摊费用" || exectype == "长期待摊费用") {
            exectype = "1";
        } else {
            exectype = "";
        }
        var GSBER_val = jQuery(GSBER).find("option:selected").text();
        var ysly_val = jQuery(ysly).val();
        if (ysly_val != '1') {
            GSBER_val = '';
        }
     //alert(oadate_val+","+tmp_KSTAR_val+","+amount+","+useDept_val+","+exectype+","+tmp_KSTAR_val+","+GSBER_val);
        var KOSTL_vval = jQuery(costCenter).val();
    //   alert(KOSTL_vval);
        if (tmp_cptNumber.length > 0 && oadate.length > 0 && useDept_val.length > 0 && KOSTL_vval.length > 0) {
          	//alert("进入预算查询：");
            jQuery.post("/feilida/js/cpt/fl_getCptInfoNew.jsp", {
                'OADATE': oadate_val,
                'ANLKL': tmp_KSTAR_val,
                'AMOUNT': amount,
                'DEPTID': useDept_val,
                'EXECTYPE': exectype,
                'KSTAR': tmp_KSTAR_val,
                'KOSTL': KOSTL_vval,
                'GSBER': '0001',
                'Project':project_val
            }, function (data) {
                	//alert(data);
                data = data.replace(/\n/g, "").replace(/\r/g, "");
                eval('var obj =' + data);
         //       var AMOUNT0 = obj.AMOUNT0;
                var AMOUNT1 = obj.AMOUNT1;
                var AMOUNT2 = obj.AMOUNT2;
                var AMOUNT3 = obj.AMOUNT3;
                var MSGTYP = obj.MSGTYP;
                var MSGTXT = obj.MSGTXT;
                var GPKEY = obj.GPKEY;
        //        var info = "可用预算数:" + AMOUNT1 + ", 冻结预算数:" + AMOUNT2 + ", 已使用预算数:" + AMOUNT3 + ", 当月预算数:" + AMOUNT0;
           var info = "可用预算数:" + AMOUNT1 + ", 冻结预算数:" + AMOUNT2 + ", 已使用预算数:" + AMOUNT3 ;
                if (MSGTYP != 'S') {
             alert("未获取到预算信息，请联系系统管理员！");
                    jQuery(tmp_budget).val("");
                    jQuery(tmp_money).val("");
                    jQuery(tmp_keyNum).val("");

                    jQuery(tmp_budget).attr("readonly", "readonly");
                    jQuery(tmp_money).attr("readonly", "readonly");
                    jQuery(tmp_keyNum).attr("readonly", "readonly");
                } else {
                    //alert("info");
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
    jQuery(document).ready(function () {
		jQuery(ysly).bindPropertyChange(function () {
            jQuery(GSBER).val("");
            jQuery(GSBER+ "span").text("");
			
        });
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
        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
        jQuery(_prop).bindPropertyChange(function () {
            setTimeout('handleXZ()', 1500);

        }); //性质变更

        $("#oTable0 .addbtn_p").click(function () { handleXZ() }); //添加的按钮

        //jQuery("button[name=addbutton0]").live("click", function () {
        //    var indexnum3 = jQuery("#indexnum0").val();
        //    fl_dtChange(_cptNumber, indexnum3 - 1);
        //});
        jQuery("#indexnum0").bindPropertyChange(function () {
            fl_getBudget();
        });
        jQuery(ysly).bindPropertyChange(function () {
            get_cost_info();
        });
        jQuery(GSBER).bindPropertyChange(function () {
            get_cost_info();
        });
        jQuery(useDept).bindPropertyChange(function () {
            get_cost_info();
        });
			var id_cbzx = "#field20844";
			var id_syrcbzx ="#field13665";
			if($(id_cbzx).val()!=""){
				$(id_syrcbzx).val($(id_cbzx).val());
				$(id_syrcbzx+"span").text($(id_cbzx).val());
				
				
			}
		jQuery(id_cbzx).bindPropertyChange(function () {
            var id_cbzx = "#field20844";
			var id_syrcbzx ="#field13665";
			if($(id_cbzx).val()!=""){
				$(id_syrcbzx).val($(id_cbzx).val());
				$(id_syrcbzx+"span").text($(id_cbzx).val());
				
				
			}
        });	
        //jQuery(appDept).bindPropertyChange(function () {
        //alert(222);
        //	get_cost_info(oadate, appDept, costCenter);
        //});


        checkCustomize = function () {
			

			 var indexnum0 = jQuery("#indexnum0").val()
			
			for (index = 0; index < indexnum0; index++) {
				if(jQuery("#"+_budget+index).length>0){
					if(jQuery("#"+_budget+index).val()==""){
						alert("预算信息不能为空！");
						return false;
				
					}
				}
			} 
			
			for (index = 0; index < indexnum0; index++) {
				//alert($("#"+_budget+index).val());
				if(jQuery("#"+_budget+index).length>0){
					var _budget_val = jQuery("#"+_budget+index).val();
					if(_budget_val !=""){
						 var temp = new Array();
						temp = _budget_val.toString().split(",");
						temp[0] = temp[0].replace('可用预算数:', '');
						temp[1] = temp[1].replace('冻结预算数:', '');
						temp[2] = temp[2].replace('已使用预算数:', '');
						if(temp[0] == ""){
								temp[0] = "0";
						}
						if(Number(temp[0])<= Number("0")){
							alert("超预算");
							break;
							
						}
				
					}
				}
			}
			/*
				20180326
				主表公司和明细公司一致
				
			*/
			var id_zbgsdm = "#field13720";//主表公司代码
			var id_mxsyrgsdm = "#field16381_";//明细使用人公司代码
			var zbgsdm = jQuery(id_zbgsdm).val();
			
			for (index = 0; index < indexnum0; index++) {
				if(jQuery(id_mxsyrgsdm+index).length>0){
					var mxsyrgsdm = jQuery(id_mxsyrgsdm+index).val();
					if(zbgsdm != mxsyrgsdm){
						alert("使用人公司不一致！");
						return false;
						
					}
				}
			}
		
			
			/*if($(ysly).val()=="1"){
				if($(GSBER).val() == ""){
					alert("业务范围不能为空！");
					return false;
					
				}
			
			}
*/
			
/*             if ($(GSBER).val() == "") {
                if ($(gsmd).val() != $(costCenter).val().substring(0, 4)) {
                    alert("所属公司和成本中心不一致！");
                    return false;

                }

            } */
			/*
				20180410
				(预算来源是组织的时候)实际使用人公司代码必须和使用人成本中心一致！
			*/
 			//if($(ysly).val()!="1"){
				if ($("#field13259span a").text() == "固定资产" || $("#field13259span a").text() == "列管资产" || $("#field13259span a").text() == "待摊费用" || $("#field13259span a").text() == "长期待摊费用") {
                var _indexnum0 = jQuery("#indexnum0").val();
                var costCenter_val = $(costCenter).val().substring(0, 4);
					for (index = 0; index < _indexnum0; index++) {
						if (jQuery("#" + _Num + index).length > 0) {
							//var _Num_val = jQuery("#" + _Num + index).val();
							var _usePerComId_val = jQuery("#" + _usePerComId + index).val();
							if (_usePerComId_val != costCenter_val) {
								//alert(_usePerComId);
								//alert(index);
								//alert(_usePerComId_val);
								alert("实际使用人公司代码必须和使用人成本中心一致！");
								return false;

							}

						}
					}



				}
		
			//}            


            if ($("#field13259span a").text() == "固定资产" || $("#field13259span a").text() == "列管资产" || $("#field13259span a").text() == "待摊费用" ||$("#field13259span a").text() == "长期待摊费用") {
                var indexnum0 = jQuery("#indexnum0").val();
                for (index = 0; index < indexnum0; index++) {
                    if (jQuery("#" + _Num + index).length > 0) {
                        var _Num_val = jQuery("#" + _Num + index).val();
                        var _usePerson_val = jQuery("#" + _usePerson + index).val();
                        if (Number(_Num_val) != 1 || _usePerson_val == "") {
                            alert("固定资产/列管资产/待摊费用/长期待摊费用申请数量只能为1并且实际使用人必须填写！")
                            return false;
                        }
                    }
                }
            }

            var id_pm = "#field14561"; //品名
            var id_wpmc = "#field13057_"; //物品名称	
            //var span=$("#oTable0 span[name*='field13057_'] a")
            //$(id_pm).val($("#oTable0 span[name*='field13057_'] a").eq(0).text());
			$(id_pm).val($("#field13057_0span a").text());
            return true;
        }


        var nodesnum0 = jQuery("#nodesnum0").val();
        var indexnum0 = jQuery("#indexnum0").val();
        if (nodesnum0 > 0) {

            for (var index = 0; index < indexnum0; index++) {
                if (jQuery("#" + _cptKSTAR + index).length > 0) {
                    fl_dtChange(_cptKSTAR, index);
                    jQuery("#" + _budget + index).attr("readonly", "readonly");
                    jQuery("#" + _keyNum + index).attr("readonly", "readonly");
                    jQuery("#" + _cptmoney + index).attr("readonly", "readonly");
                }
            }
        }

    });

    setTimeout('handleXZ()', 1000);
    setTimeout(' get_cost_info()', 1500);
	function adddelid(dtid,fieldidqf){
    var ids_dt1="";
              var flag1="";
            var indexnum0=  jQuery("#indexnum"+dtid).val();
            for(var index=0;index <indexnum0;index++){
                 if(jQuery(fieldidqf+index).length>0){
                      var pp=document.getElementsByName('dtl_id_'+dtid+'_'+index)[0].value;
                      ids_dt1=ids_dt1+flag1+pp;
                      flag1=",";
                }
           }
               var deldtlid0_val=jQuery("#deldtlid"+dtid).val();
               if(deldtlid0_val !=""){
                   deldtlid0_val=deldtlid0_val+","+ids_dt1;         
           }else{
                  deldtlid0_val=ids_dt1;
          }
               jQuery("#deldtlid"+dtid).val(deldtlid0_val);   
}
function removeRow0(groupid,isfromsap){
    try{
var flag = false;
    var ids = document.getElementsByName("check_node_"+groupid);
    for(i=0; i<ids.length; i++) {
        if(ids[i].checked==true) {
            flag = true;
            break;
        }
    }
    if(isfromsap){flag=true;}
    if(flag) {
        if(isfromsap || _isdel()){
        var oTable=document.getElementById("oTable"+groupid)
        var len = document.forms[0].elements.length;
        var curindex=parseInt($G("nodesnum"+groupid).value);
        var i=0;
        var rowsum1 = 0;
        var objname = "check_node_"+groupid;
        for(i=len-1; i >= 0;i--) {
            if (document.forms[0].elements[i].name==objname){
                rowsum1 += 1;
            }
        }
        rowsum1=rowsum1+2;
        for(i=len-1; i>=0; i--) {
            if(document.forms[0].elements[i].name==objname){
                if(document.forms[0].elements[i].checked==true){
                    var nodecheckObj;
                        var delid;
                    try{
                              if(jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").length>0){                                   
                                  delid = jQuery(oTable.rows[rowsum1].cells[0]).find("[name='"+objname+"']").eq(0).val();

                        }
                    }catch(e){}
                    //记录被删除的旧记录 id串
                    if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
                        if($G("deldtlid"+groupid).value!=''){
                            //老明细
                            $G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
                        }else{
                            //新明细
                            $G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
                        }
                    }
                    //从提交序号串中删除被删除的行
                    var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
                    $G("submitdtlid"+groupid).value="";
                    var k;
                    for(k=0; k<submitdtlidArray.length; k++){
                        if(submitdtlidArray[k]!=delid){
                            if($G("submitdtlid"+groupid).value==''){
                                $G("submitdtlid"+groupid).value = submitdtlidArray[k];
                            }else{
                                $G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
                            }
                        }
                    }
                    oTable.deleteRow(rowsum1);

                    curindex--;
                }
                rowsum1--;
            }
        }
        $G("nodesnum"+groupid).value=curindex;
            calSum(groupid);
}
}else{
        alert('请选择需要删除的数据');
        return;
    }    }catch(e){}
    try{
        var indexNum = jQuery("span[name='detailIndexSpan0']").length;
        for(var k=1; k<=indexNum; k++){
            jQuery("span[name='detailIndexSpan0']").get(k-1).innerHTML = k;
        }
    }catch(e){}
}
function _isdel(){
    return true;
}

</script>

























