<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    *   ��Ӧ��Ԥ�������뵥
    *  1.�������������"������ 3�������ɱ��� 2����ӳɱ� 1��ʱ��
    ��ϸ��������Ŀ���ơ���λ��������ء��ʲ���š��͡��ʲ���������
    �������������"�̶��ʲ� 0��ʱ��
    ��ϸ���ʲ���ź��ʲ���������λ��������ء�������ϸ��Ŀ����
    �������
         ƾ֤ժҪ���������һ���ڵ�������Ľڵ�󸽼Ӳ����������ɡ��������Ȳ�����
         ���ɹ��򣺹������ڡ��·ݡ�+����Ӧ�����ơ�+��������Ŀ���ƣ���ϸ��ѭ��ȡֵ���ö��Ÿ�������
         ����10���շ�������������ɷ����޹�˾�Ϻ��ֹ�˾ֽ���ʡ��鱾����

    �������������ʱ��������
     ѡ�񡰹�Ӧ�̱�š���ʱ���������Ӧ�����ơ������Ҽ��ظù�Ӧ�̵�Ԥ������Ϣ�������·���ϸ���У�������Դ��֮SAP����

     �����ģ�
���Ƿ��г�Ԥ����߼��жˣ���ϸ����ֻҪ��һ����ϸ�С����������ڡ�Ԥ������жϡ��Ƿ��г�Ԥ���ֵΪ��Y��û����Ϊ��N��

    */
    //
    var d_zbbxlx = "#field11171"//����������
    var d_pzhzy = "#field9352"//ƾ֤ժҪ
    var d_gzrq = "#field10872"//��������
    var d_gysmc = "#field9350"//��Ӧ������
    var d_gysbh = "#field9910"//��Ӧ�̱��

    var khbh = "#field11083_"; // �ͻ����
      var yfkbh= "#field11844_";//OAԤ����������
    var pzbh= "#field10844_"; // ƾ֤���
    var pzrq = "#field10845_"; // ƾ֤����  
    var bz= "#field10846_"; // ����
    var je= "#field10857_"; //���
    var cainian= "#field12361_"; //����	
    var hxms= "#field12362_"; //����Ŀ��	
    var wb = "#field10848_";//�ı�
    var khbm="#field9910";
    var gsdm ="#field12451";
    var smsj ="#field10695_"; //˰��˰��
    var smsj2 ="#field12202_"; //˰��˰��(�޸�)
    var bhsje ="#field11030_"; //����˰���
    var bxje ="#field10645_"; //�������
    var zffs ="#field10850"; //֧����ʽ
    var gysbh = "field9910"; //��Ӧ�̱��
    var gysmc = "field9350"; //��Ӧ������
    var xjllm = "field11941"; //�ֽ�������
    var xjllmmc = "field11942"; //�ֽ�����������
    var fkzh = "field10870"; //��˾�����˺�
    var hflx = "field10868"; //��������
    var hfje = "field10869"; //�������
    var gzrq = "field10872"; //��������
    var fjsc = "field10738"; //�����ϴ�

    jQuery(zffs).bindPropertyChange(function () {
        var zffs_val=jQuery(zffs).val();

    if(zffs_val=="O"){
        elementsHideShow(0,0);
        elementsHideShow(1,0);
        elementsHideShow(2,0);
        elementsHideShow(3,0);
    }else if(zffs_val=="P"){
        elementsHideShow(0,0);
        elementsHideShow(1,0);
        elementsHideShow(2,0);
        elementsHideShow(3,0);
    }else if(zffs_val=="R"){
        jQuery("#"+hflx).bindPropertyChange(function () {
            var hflx_val=jQuery("#"+hflx).val();
            if(hflx_val=="2"){
                elementsHideShow(1,0);
                elementsHideShow(2,0);    
            }else if(hflx_val=="0"||hflx_val=="1"){
                elementsHideShow(1,0);
                elementsHideShow(2,0); 
            }else{
            }
        })
        elementsHideShow(0,1);
        elementsHideShow(3,1);

    }else{
        //elementsHideShow(0,1);
        elementsHideShow(1,0);
        elementsHideShow(2,0);
        elementsHideShow(3,0);
    }
    })

    function elementsHideShow(sort,type){
        if(sort=="0"){
            if(type=="1"){
                jQuery("#"+gysbh).val("");
                jQuery("#"+gysbh+"span").text("");
                jQuery("#out"+gysbh+"div").show();
                jQuery("#"+gysbh+"_browserbtn").show();
                jQuery("#"+gysbh+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

                jQuery("#"+gysmc).val("");
                jQuery("#"+gysmc+"span").text("");
                jQuery("#"+gysmc).show();
                var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+gysbh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=gysbh;
                }
                if(needcheck.value.indexOf(","+gysmc)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=gysmc;
                }
            }else{
                jQuery("#"+gysbh).val("");
                jQuery("#"+gysbh+"span").text("");
                jQuery("#out"+gysbh+"div").hide();
                jQuery("#"+gysbh+"_browserbtn").hide();
                jQuery("#"+gysbh+"spanimg").html("");

                jQuery("#"+gysmc).val("");
                jQuery("#"+gysmc+"span").text("");
                jQuery("#"+gysmc).hide();
                var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+gysbh,"");
                parastr = parastr.replace(","+gysmc,"");
                document.all('needcheck').value=parastr;

            }
        }else if(sort=="1"){
            if(type=="1"){
                jQuery("#"+xjllm).val("");
                jQuery("#"+xjllm+"span").text("");
                jQuery("#out"+xjllm+"div").show();
                jQuery("#"+xjllm+"_browserbtn").show();
                jQuery("#"+xjllm+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

                jQuery("#"+xjllmmc).val("");
                jQuery("#"+xjllmmc+"span").text("");
                jQuery("#"+xjllmmc).show();
                var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+xjllm)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=xjllm;
                }
                if(needcheck.value.indexOf(","+xjllmmc)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=xjllmmc;
                }
            }else{
                jQuery("#"+xjllm).val("");
                jQuery("#"+xjllm+"span").text("");
                jQuery("#out"+xjllm+"div").hide();
                jQuery("#"+xjllm+"_browserbtn").hide();
                jQuery("#"+xjllm+"spanimg").html("");

                jQuery("#"+xjllmmc).val("");
                jQuery("#"+xjllmmc+"span").text("");
                jQuery("#"+xjllmmc).hide();
                var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+xjllm,"");
                parastr = parastr.replace(","+xjllmmc,"");
                document.all('needcheck').value=parastr;

            }
        }else if(sort=="2"){
            if(type=="2"){
                jQuery("#"+fkzh).val("");
                jQuery("#"+fkzh+"span").text("");
                jQuery("#out"+fkzh+"div").show();
                jQuery("#"+fkzh+"_browserbtn").show();
                jQuery("#"+fkzh+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
                var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+fkzh)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=fkzh;
                }
            }else if(type=="0"){
                jQuery("#"+fkzh).val("");
                jQuery("#"+fkzh+"span").text("");
                jQuery("#out"+fkzh+"div").hide();
                jQuery("#"+fkzh+"_browserbtn").hide();
                jQuery("#"+fkzh+"spanimg").html("");
                var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+fkzh,"");
                document.all('needcheck').value=parastr;
            }else{
                jQuery("#"+fkzh).val("");
                jQuery("#"+fkzh+"span").text("");
                jQuery("#out"+fkzh+"div").show();
                jQuery("#"+fkzh+"_browserbtn").show();
                jQuery("#"+fkzh+"spanimg").html("");
            }

        }else{
            if(type=="1"){
                jQuery("#"+hflx).val("");
                jQuery("#"+hflx).show();
                jQuery("#"+hflx+"span").html("");

                jQuery("#"+hfje).val("");
                jQuery("#"+hfje+"span").text("");
                jQuery("#"+hfje).show();
                jQuery("#"+hfje+"spanimg").html("");

                jQuery("#"+gzrq).val("");
                jQuery("#"+gzrq+"span").text("");
                jQuery("#"+gzrq+"browser").show();
                jQuery("#"+gzrq+"span").html("");

               // jQuery("#"+fjsc).val("");
               // jQuery("#"+fjsc+"_tab").show();
              //  jQuery("#"+fjsc+"span").html("");

            }else{
                jQuery("#"+hflx).val("");
                jQuery("#"+hflx).hide();
                jQuery("#"+hflx+"span").html("");

                jQuery("#"+hfje).val("");
                jQuery("#"+hfje+"span").text("");
                jQuery("#"+hfje).hide();
                jQuery("#"+hfje+"spanimg").html("");

                jQuery("#"+gzrq).val("");
                jQuery("#"+gzrq+"span").text("");
                jQuery("#"+gzrq+"browser").hide();
                jQuery("#"+gzrq+"span").html("");

               // jQuery("#"+fjsc).val("");
               // jQuery("#"+fjsc+"_tab").hide();
               // jQuery("#"+fjsc+"span").html("");

                var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+hflx,"");
                parastr = parastr.replace(","+hfje,"");
                parastr = parastr.replace(","+gzrq,"");
               // parastr = parastr.replace(","+fjsc,"");
                document.all('needcheck').value=parastr;

            }

        }
    }

    jQuery("button[name=addbutton0]").live("click",function(){
        var indexnum0=jQuery("#indexnum0").val();
        for(var index =0;index <indexnum0;index ++){
            bindchange(index);
            bindchange2(index); 
        } 
    });
    
    function bind(){
        var indexnum0=jQuery("#indexnum0").val();
        for(var index =0;index <=indexnum0;index ++){
         if(jQuery(smsj+index).length>0){
           bindchange(index); 
         }
         if(jQuery(smsj2+index).length>0){
           bindchange2(index); 
         }
        }
    }

    function bindchange(numx){
      jQuery(smsj+numx).bindPropertyChange(function () {
         var smsj_val= jQuery(smsj+numx).val();
         jQuery(smsj2+numx).val(smsj_val);  
       })
    }

    function bindchange2(numx){
      jQuery(smsj2+numx).bindPropertyChange(function () {
        var smsj2_val= jQuery(smsj2+numx).val();
        var bxje_val= jQuery(bxje+numx).val();
        var diff = Number(bxje_val)-Number(smsj2_val);
        jQuery(bhsje+numx).val(diff);  
        jQuery(bhsje+numx+"span").text(diff);  
       })
    }



    var initDetail = function () {
        var mm = Date.parse($(d_gzrq).val());
        var newDate = new Date(mm);
        var y = newDate.getMonth() + 1; 
        var mmn = (y < 10 ? '0' : '') + y; //�·�
        var i_gysmc = $(d_gysmc).val(); //��Ӧ������ 
        var msum = "";
        $("td[name='td_fyxmmc'] .e8_showNameClass a").each(function () {
            var m = $(this).text();
            if (m != "") {
                msum = msum + m + ",";
            }
        });
        //$(d_pzhzy).val(mmn + i_gysmc + msum);
    }
    var getlx = function () {
        var i_zbbxlx = $(d_zbbxlx + " option:selected")
        if (i_zbbxlx.val() == 0 || i_zbbxlx.val() == 2 || i_zbbxlx.val() == 3) {
            $(".td_zcbh").hide();
            $(".td_zcms").hide();
            $(".td_fyxmmc").show();
        } else if (i_zbbxlx.val() == 1) {
            $(".td_zcbh").show();
            $(".td_zcms").show();
            $(".td_fyxmmc").hide();
        }else{
            $(".td_zcbh").show();
            $(".td_zcms").show();
            $(".td_fyxmmc").show();
        }
        initD();
    }
    //��������ʱ��������
    var setNX = function () {
        var i_zbbxlx = $(d_zbbxlx + " option:selected")
        if (i_zbbxlx.val() == 0 || i_zbbxlx.val() == 2 || i_zbbxlx.val() == 3) { 
            $("td[name='td_fyxmmc'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("��ѡ�������Ŀ����");
                    return false;
                }
            });
        };
        if (i_zbbxlx.val() == 1) { 
            $("td[name='td_zcbh'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("��ѡ���ʲ����");
                    return false;
                }
            });
            $("td[name='td_zcms'] input[type='hidden']").each(function () {
                var m = $(this).val();
                if (m == "") {
                    alert("��ѡ���ʲ�����");
                    return false;
                }
            });
        } 
    } 

    var initD = function () {
        var td_fyxmmc = $("#oTable0 td[name='td_fyxmmc']:last");
        var tr = td_fyxmmc.closest("tr");
        var i_ysxmms = tr.find("td[name='td_fyxmmc'] input[type='hidden']:last"); //������Ŀ����
        jQuery("#" + i_ysxmms.attr("id")).bindPropertyChange(function () { initDetail(); });
    }
    jQuery(document).ready(function () {

    checkCustomize = function () {
        var _budget_temp = "field13742_";//Ԥ����Ϣ
        var _percent = "field12621";//����Ԥ���
        var _keyNum = "field13743_";
        var _cptmoney = "field13744_";
        var _account = "field10645_";
        var indexnum0 = jQuery("#indexnum0").val();
        var account_all="";
        var indexnum0_temp = jQuery("#indexnum0").val();
           jQuery("#"+_percent).val(0);
           jQuery("#"+_percent+"span").text(0);
        for(index=0;index<indexnum0_temp;index++){
          if(jQuery("#"+_budget_temp+index).length>0){
            val_all(index);
           }
        }
    function val_all(index){
        //var money_all=jQuery("#"+_cptmoney+index).val();
        for(yet=0;yet<indexnum0;yet++){
            var key_num_index=jQuery("#"+_keyNum+index).val();
            var key_num_yet=jQuery("#"+_keyNum+yet).val();
            if(key_num_index==key_num_yet){
                account_all=Number(account_all)+Number(jQuery("#"+_account+yet).val());
            }
        }
        var _budget_all = jQuery("#"+_budget_temp+index).val();
        //alert("_budget_all="+_budget_all);
        var temp = new Array();
        temp = _budget_all.toString().split(","); 
        temp[0]=temp[0].replace('����Ԥ����:', '');
        temp[1]=temp[1].replace('����Ԥ����:', '');
        temp[2]=temp[2].replace('��ʹ��Ԥ����:', '');
        temp[3]=temp[3].replace('����Ԥ����:', '');
            var _percent_val = jQuery("#"+_percent).val();
            var _percent_now = (Number(account_all)+Number(temp[1])+Number(temp[2])-Number(temp[3]))/Number(temp[3])*100;
            //alert("_percent_now="+_percent_now);
            if(Number(_percent_now)>0){
                if(Number(_percent_now)>Number(_percent_val)){
                    jQuery("#"+_percent).val(Math.round(_percent_now));
                    jQuery("#"+_percent+"span").text(Math.round(_percent_now));
                 }
            alert("������Ʒ��Ԥ��!");
            //return false;
            }
        return true;
    }
        var isSuccess = true;
        var i_zbbxlx = $(d_zbbxlx + " option:selected")
        if (i_zbbxlx.val() == 0 || i_zbbxlx.val() == 2 || i_zbbxlx.val() == 3) { 
            $("td[name='td_fyxmmc'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("��ѡ�������Ŀ����");
                    isSuccess=false;
                }
            });
        }
        if (i_zbbxlx.val() == 1) { 
            $("td[name='td_zcbh'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("��ѡ���ʲ����");
                    isSuccess=false;
                }
            });
            $("td[name='td_zcms'] input[type='hidden']").each(function () {
                var m = $(this).val();
                if (m == "") {
                    alert("��ѡ���ʲ�����");
                    isSuccess=false;
                }
            });
        } 
        return isSuccess;
    }
        initDetail();
        jQuery(d_zbbxlx).bindPropertyChange(function () { getlx() }); //����������
        jQuery(d_gzrq).bindPropertyChange(function () { initDetail() }); //��������
        jQuery(d_gysbh).bindPropertyChange(function () { initDetail() }); //��Ӧ�̱��
        $("#oTable0 .addbtn_p").click(function () { getlx() }); //��ӵİ�ť
         
        window.setTimeout("initD ()", 1000);
        setTimeout('bind()',500);

        jQuery(khbm).bindPropertyChange(function (){ 
             var indexnum1=  jQuery("#indexnum2").val();
                if(indexnum1>0){
                      jQuery("[name = check_node_2]:checkbox").attr("checked", true);
                    deleteRow2(2);                                                               
                }  
            var xhr = null;
        if (window.ActiveXObject) {//IE�����
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            xhr = new XMLHttpRequest();
        }
        if (null != xhr) {
            var khbm_val = jQuery(khbm).val();
                        var gsdm_val = jQuery(gsdm).val();
            xhr.open("GET","/feilida/finance/getFI08Info.jsp?id="+khbm_val+"&custom="+gsdm_val, false);
            xhr.onreadystatechange = function () {

                    if (xhr.readyState == 4) {
                        if (xhr.status == 200) {
                            var text = xhr.responseText;
                            text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');          
                            var text_arr = text.split("@@@");
                            var length1=Number(text_arr.length)-1+Number(indexnum1);
                            for(var i=indexnum1;i<length1;i++){                                                          
                                addRow2(2);
                                var tmp_arr = text_arr[i-indexnum1].split("###");                           
                                jQuery(khbh+i).val(tmp_arr[0]);                         
                                jQuery(khbh+i+"span").text(tmp_arr[0]);   
                                jQuery(yfkbh+i).val(tmp_arr[1]);                         
                                jQuery(yfkbh+i+"span").text(tmp_arr[1]);   
                                jQuery(pzbh+i).val(tmp_arr[2]);                         
                                jQuery(pzbh+i+"span").text(tmp_arr[2]);
                                jQuery(pzrq+i).val(tmp_arr[3]);                         
                                jQuery(pzrq+i+"span").text(tmp_arr[3]);
                                jQuery(bz+i).val(tmp_arr[4]);                           
                                jQuery(bz+i+"span").text(tmp_arr[4]);
                                jQuery(je+i).val(tmp_arr[5]);                           
                                jQuery(je+i+"span").text(tmp_arr[5]);
                                  jQuery(cainian+i).val(tmp_arr[6]);                           
                                jQuery(cainian+i+"span").text(tmp_arr[6]);
                                  jQuery(hxms+i).val(tmp_arr[7]);                           
                                jQuery(hxms+i+"span").text(tmp_arr[7]);
                                jQuery(wb+i).val(tmp_arr[8]);                           
                                jQuery(wb+i+"span").text(tmp_arr[8]);                                                                                                       
                        }
                    }   
                }
            }
            xhr.send(null);         
        }
     })
    });  


jQuery(document).ready(function () {
	var applyworkflow = "#field13881"; // ��Ʒ��������
	var expenseType = "#field11171"; // ��������
          var oadate = "#field9313"; //��������
	var _dept = "field9915_"; // ����
	var _deptName = "field9354_"; // ��������
	var _cptCard = "field13581_"; // �ʲ���Ƭ
	var _cptDescribe = "field10802_"; // �ʲ�����
	var _budgetMoney = "field13744_"; // Ԥ����
	var _expense = "field10645_"; // �������
	var _businessRange = "field10693_"; // ҵ��Χ
	var _busiRangeName = "field11309_"; // ҵ��Χ����
	var _tax = "field10853_"; // ˰��
	var _taxRate = "field10855_"; // ˰��
	var _taxes = "field12202_"; //˰��
	var _noTax = "field11030_"; // ����˰���
	var _insideOrder = "field9918_"; // �ڲ�������
	var _insideOrderDesc = "field9359_"; //�ڲ�����������
var reqid_dt = "field13884_";
	var wpbm = "field13921_";
	var exetype = "field13922_";
      var useDept = "#field9315"; //ʹ�ò���
        var GSBER = "#field13902";//ҵ��Χ
    	var ysly = "#field13901";//Ԥ����Դ
    	  var bxrid =  "#field9312";
	  //��ϸ
    var _budget = "field13742_"; //Ԥ����Ϣ
    var _cptNumber = "field10374_"; //�ʲ����
    var _cptmoney= "field13744_"; //Ԥ����
    var _cptKSTAR= "field10374_"; //��Ŀid
    var _keyNum = "field13743_";//��ʶ��
    	var nodesnum0=jQuery("#nodesnum0").val();
        	 var indexnum0=jQuery("#indexnum0").val();
        	 if(nodesnum0>0){
                    var expenseType_val = jQuery(expenseType).val();
        	       if (expenseType_val != '1') {    
			 for(var index=0;index<indexnum0;index++){
				 if(jQuery("#"+_cptKSTAR+index).length>0){
				    fl_dtChange(_cptKSTAR, index) ;
				 }
			 }
		 }
		}
	  jQuery(bxrid).bindPropertyChange(function () {
              jQuery(applyworkflow).val("");
           jQuery(applyworkflow+"span").text("");
       
      });
       jQuery("#indexnum0").bindPropertyChange(function () {
        var expenseType_val = jQuery(expenseType).val();
        	if (expenseType_val != '1') {
        	//	alert("1");
			 fl_getBudget();
		} 
       
      });
	jQuery(expenseType).bindPropertyChange(function () {
		var expenseType_val = jQuery(expenseType).val();
		if (expenseType_val == '1') {
			deleteDt();
		} else {
			deleteDt();
			jQuery(applyworkflow).val("");
			jQuery(applyworkflow + "span").html("");
		}

	});

	jQuery(applyworkflow).bindPropertyChange(function () {
			deleteDt();
		var _indexnum0 = jQuery("#indexnum0").val();
			fl_change(_indexnum0);
	});
	
      function fl_getBudget() {
        var nowRow = parseInt($G("indexnum0").value) - 1;
        //fl_dtChange(_budget, nowRow);
        fl_dtChange(_cptKSTAR, nowRow);
    }
    
        function fl_dtChange(tmpObj, nowRow) {
          //alert("2");
            jQuery("#" + _cptKSTAR + nowRow).bindPropertyChange(function () {
          //alert("3");
            var tmp_budget = "#" + _budget + nowRow;
            var tmp_cptNumber = "#" + _cptNumber + nowRow;
                   var tmp_money= "#" + _cptmoney + nowRow;
                    var tmp_KSTAR = "#" + _cptKSTAR + nowRow;
                    var tmp_keyNum = "#" + _keyNum + nowRow;
                    var tmp_dept ="#" + _dept  + nowRow;
                     var useDept_val = jQuery(useDept).val();
                     if(useDept_val == ''){
                      alert("������д��������");
                      return;
                     }
            get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum,tmp_dept,useDept,'');
        });
         jQuery("#" + _dept + nowRow).bindPropertyChange(function () {
            var tmp_budget = "#" + _budget + nowRow;
            var tmp_cptNumber = "#" + _cptNumber + nowRow;
                   var tmp_money= "#" + _cptmoney + nowRow;
                    var tmp_KSTAR = "#" + _cptKSTAR + nowRow;
                    var tmp_keyNum = "#" + _keyNum + nowRow;
                    var tmp_dept = "#" + _dept  + nowRow;
                    
                    var tmp_KSTAR_val = jQuery(tmp_KSTAR).val();
                    if(tmp_KSTAR_val !=''){
                    	 var useDept_val = jQuery(useDept).val();
                     if(useDept_val == ''){
                      alert("������д��������");
                      return;
                     }
                get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum,tmp_dept,useDept,'');
                }
        });
    }
    function get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum,tmp_dept,tmp_usedept,tmp_exetype) {
        var tmp_cptNumber_val = jQuery(tmp_cptNumber).val();
        var oadate_val = jQuery(oadate).val();
        var useDept_val = jQuery(tmp_usedept).val();
        var tmp_KSTAR_val = jQuery(tmp_KSTAR).val();
        var amount = "0";
        var exectype =   jQuery(expenseType).val();
        if(exectype == '1'){
        	exectype=tmp_exetype;
        }
        var GSBER_val = jQuery(GSBER).find("option:selected").text();
        var ysly_val = jQuery(ysly).val();
        if(ysly_val !='1'){
        	GSBER_val = '';
       } 
        if(GSBER_val == ''){
       GSBER_val = jQuery(tmp_dept).val();
       }
        
      //alert(oadate_val+","+tmp_KSTAR_val+","+amount+","+useDept_val+","+exectype+","+tmp_KSTAR_val+","+GSBER_val);
      //alert(tmp_KSTAR_val+","+GSBER_val);
        if (tmp_cptNumber.length > 0 && oadate.length > 0 && useDept_val.length > 0) {
                    //  alert("����");
            jQuery.post("/feilida/js/cpt/fl_getCptInfoNew.jsp", {
                'OADATE': oadate_val,
                'ANLKL': tmp_KSTAR_val,
                'AMOUNT': amount,
                'DEPTID': useDept_val,
                'EXECTYPE': exectype,
                'KSTAR': tmp_KSTAR_val,
                 'KOSTL':GSBER_val
            }, function (data) {
            //alert(data);
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
                    jQuery(tmp_budget + "span").html("");
                    jQuery(tmp_money).val("");
                    jQuery(tmp_money + "span").html("");
                    jQuery(tmp_keyNum).val("");
                    jQuery(tmp_keyNum + "span").html("");
                } else {
                    jQuery(tmp_budget).val(info);
                    jQuery(tmp_budget + "span").html(info);
                    jQuery(tmp_money).val(AMOUNT1);
                    jQuery(tmp_money + "span").html(AMOUNT1);
                    jQuery(tmp_keyNum).val(GPKEY);
                    jQuery(tmp_keyNum + "span").text(GPKEY);
                }
            });
        }
    }
    
	function fl_change(_rowdtid) {
		//alert("_rowdtid=" + _rowdtid);
		var zzkm="field13882_";
		var xhr = null;
		if (window.ActiveXObject) { //IE�����
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var _applywf_val = jQuery(applyworkflow).val();
		//	alert("_applywf_val= " + _applywf_val);
			//alert("_emp_code_val= " + _emp_code_val);
			xhr.open("GET", "/feilida/js/cpt/cptApply.jsp?reqid=" + _applywf_val + " ", false);
		//	alert("11");
			xhr.onreadystatechange = function () {

				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var text = xhr.responseText;
						text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
					//	alert("text= " + text);
						var text_arr = text.split("@@@");
						if (text_arr.length > 1) {
							var length_dt = Number(text_arr.length) - 1 + Number(_rowdtid);
							for (var i = _rowdtid; i < length_dt; i++) {
								//alert("lenth" + text_arr.length);
								//alert("index="+index);
								addRow0(0);
                                                  getlx();
								var tmp_arr = text_arr[i - _rowdtid].split("###");

								jQuery("#" + _deptName + i).val(tmp_arr[0]); //���id
								jQuery("#" + _deptName + i + "span").html(tmp_arr[0]); //�������

								jQuery("#" + _dept + i).val(tmp_arr[1]); //���id
								jQuery("#" + _dept + i + "span").html(tmp_arr[1]); //�������

								jQuery("#" + _cptCard + i).val(tmp_arr[2]); //���id
								jQuery("#" + _cptCard + i + "span").html(tmp_arr[2]); //�������

								jQuery("#" + _cptDescribe + i).val(tmp_arr[3]); //���id
								jQuery("#" + _cptDescribe + i + "span").html(tmp_arr[3]); //�������

								jQuery("#" + _budgetMoney + i).val(tmp_arr[4]); //���id
								jQuery("#" + _budgetMoney + i + "span").html(tmp_arr[4]); //�������

								jQuery("#" + _budget + i).val(tmp_arr[5]); //���id
								jQuery("#" + _budget + i + "span").html(tmp_arr[5]); //�������

								jQuery("#" + _businessRange + i).val(tmp_arr[6]); //���id
								jQuery("#" + _businessRange + i + "span").html(tmp_arr[6]); //�������

								jQuery("#" + _busiRangeName + i).val(tmp_arr[7]); //���id
								jQuery("#" + _busiRangeName + i).val(tmp_arr[7]); //���id
								//jQuery("#" + _cityType + i + "span").html(tmp_arr[6]); //�������

								jQuery("#" + _tax + i).val(tmp_arr[8]); //���id
								jQuery("#" + _tax + i + "span").html(tmp_arr[8]); //�������

								jQuery("#" + _taxRate + i).val(tmp_arr[9]); //���id
								jQuery("#" + _taxRate + i + "span").html(tmp_arr[9]); //�������

								jQuery("#" + _taxes + i).val(tmp_arr[10]); //���id
								jQuery("#" + _taxes + i + "span").html(tmp_arr[10]); //�������

								jQuery("#" + _insideOrder + i).val(tmp_arr[11]); //���id
								jQuery("#" + _insideOrder + i + "span").html(tmp_arr[11]); //���id
								//jQuery("#" + _cityType + i + "span").html(tmp_arr[6]); //�������

								jQuery("#" + _insideOrderDesc + i).val(tmp_arr[12]); //���id
								jQuery("#" + _insideOrderDesc + i + "span").html(tmp_arr[12]); //�������
							//	alert("13"+tmp_arr[13]);	
								jQuery("#" + zzkm + i).val(tmp_arr[13]); //���id
								jQuery("#" + zzkm + i + "span").html(tmp_arr[13]); //�������
								//alert("134"+tmp_arr[14]);	
								jQuery("#" + _keyNum + i).val(tmp_arr[14]); //���id
								jQuery("#" + _keyNum + i + "span").html(tmp_arr[14]); //�������
									
								jQuery("#" + _expense + i).val(tmp_arr[15]); //���id
                                                  jQuery("#" + reqid_dt + i).val(tmp_arr[16]); //���id
								jQuery("#" + reqid_dt + i + "span").html(tmp_arr[16]); //�������
									 jQuery("#" + wpbm + i).val(tmp_arr[17]); //���id
								jQuery("#" + wpbm + i + "span").html(tmp_arr[17]); //�������
								//	alert(tmp_arr[18]);
										 jQuery("#" + exetype + i).val(tmp_arr[18]); //���id
								jQuery("#" + exetype + i + "span").html(tmp_arr[18]); //�������
									var tmp_budget = "#" + _budget + i;
            							var tmp_cptNumber = "#" + zzkm + i;
                   						var tmp_money= "#" + _cptmoney + i;
                   					      var tmp_KSTAR = "#" + zzkm + i;
                   					      var tmp_keyNum = "#" + _keyNum + i;
                                                        var tmp_dept ="#" + _dept  + i;
                                                        var tmp_usedept="#" + wpbm  + i;
                                                   get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum,tmp_dept,tmp_usedept,tmp_arr[18]);
								//jQuery("#" + _hotelStandard + i).val(tmp_arr[9]); //���id
								//jQuery("#" + _hotelStandard + i + "span").html(tmp_arr[9]); //�������

								//jQuery("#" + _foodStandard + i).val(tmp_arr[10]); //���id
								//jQuery("#" + _foodStandard + i + "span").html(tmp_arr[10]); //�������

							}
						}
					}
				}
			}
			xhr.send(null);
		}
	}


	function deleteDt() {
		var _nodesnum0 = jQuery("#nodesnum0").val();
		//alert("_nodesnum0=" + _nodesnum0);
		if (_nodesnum0 > 0) {
			jQuery("[name = check_node_0]:checkbox").attr("checked", true);
			deleteRow0(0);
		}
	}
});
</script>





