<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
jQuery(document).ready(function () {
    var _subcompany = "#field13260"; // �ʲ�������˾
    var _type = "#field13258"; // ���
    var _prop = "#field13259"; // ����

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
                var _cptName = "field13057_"; //��Ʒ����
                var _cptName_val = jQuery("#" + _cptName + i).val();
                if (_cptName_val.length > 0) {
                    //alert("length=" + _cptName_val.length);
                    jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                    deleteRow0(0);
                }
            }
        }
    } //Ҫע����ǣ�ҳ��ɾ������ϸ���±� ��������
});
	//alert("wwww");
	//��ϸ1
	//var qjr_code = "field27310_"; //��Ա����
	//var qjr_id = "field27311_"; //��Ա����
	var oadate = "#field11962"; //��������
	var useDept = "#field11967"; //ʹ�ò���
	var appDept = "#field11969"; //���벿��
	//var amount = "field27318_"; //Ԥ�ƽ�����ʼʱ��
	var costCenter = "#field13665"; //�ɱ�����
	var costCenter1 = "#field13666"; //���γɱ�����
       var GSBER = "#field13781";//ҵ��Χ
       var ysly = "#field11973";//Ԥ����Դ
         //��ע
        var id_flag = "#field13754";//��ע��־
        var id_lb = "#field13258";//���
        var id_xz = "#field13259";//����
        //$(id_flag).val($(id_sqrgs).val()=="��Ѷ" && $(id_xz).val() == "�̶��ʲ�")?"1":"0");


	//��ϸ
	var _cpt = "field13057_"; //��Ʒ����
	var _budget = "field11981_"; //Ԥ����Ϣ
	var _cptNumber = "field13721_"; //�ʲ����
	var _cptmoney= "field13718_"; //Ԥ����
	var _cptKSTAR= "field13721_"; //��Ŀid
      var _cptxz= "field13745"; //����
    var _keyNum = "field13723_";//��ʶ��
    var _Num = "field11980_";//����
    var _usePerson= "field13801_";//ʵ��ʹ����
jQuery(document).ready(function () {

	
        checkCustomize = function () {
            var _cptxz_val=jQuery("#"+_cptxz).val();
            if(_cptxz_val=="�̶��ʲ�" || _cptxz_val=="�й��ʲ�"){
                var indexnum0 = jQuery("#indexnum0").val();
                for(index=0;index<indexnum0;index++){
                	if(jQuery("#"+_Num+index).length>0){
                    var _Num_val=jQuery("#"+_Num+index).val();
                    var _usePerson_val=jQuery("#"+_usePerson+index).val();
                    if(Number(_Num_val)!=1 ||_usePerson_val==""){
                        alert("�̶��ʲ����й��ʲ���������ֻ��Ϊ1����ʵ��ʹ���˱�����д��")
                        return false;
                    }
                }
            }
            }
            
                var id_pm = "#field14561";//Ʒ��
		var id_wpmc = "#field13057";//��Ʒ����	
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
                    alert("δ�ҵ���Ӧ�ĳɱ����ģ�����ϵ����Ա");
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
		if(exectype == "�̶��ʲ�"||exectype == "��̯����"||exectype == "���ڴ�̯����"){
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
					//	alert("����");
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
                         var info="����Ԥ����:"+AMOUNT1+", ����Ԥ����:"+AMOUNT2+", ��ʹ��Ԥ����:"+AMOUNT3+", ����Ԥ����:"+AMOUNT0;
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



























































