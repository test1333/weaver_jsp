<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    var id_zffs = "field10850";//支付方式

//    var id_gysbh = "13802";         //供应商编号 //13782
//    var id_gysmc = "field13803";    //供应商名称 //13783
//    var id_fph = "field13804";      //发票号     //13784
//    var id_fpys = "field13805";     //发票页数   //13785

    var id_gysbh = "13782";         //供应商编号 //13782
    var id_gysmc = "field13783";    //供应商名称 //13783
    var id_fph = "field13784";      //发票号     //13784
    var id_fpys = "field13785";     //发票页数   //13785
	
	var _ysqje = "field15923_"; //原申请金额
	var _fyxmmc = "field10747_"; //费用项目科目
	var _zzkm01="field10374_";//总账科目01

    //支付方式变更联动明细表开关
    var handleZFFS_CHG = function () {
        var zffs = $("#" + id_zffs);
        if (zffs.val() == "T" || zffs.val() == "U" || zffs.val() == "R") {
            $("#oTable0 td[_fieldid*='" + id_gysbh + "_']").each(function () {
                $(this).children().eq(0).show();
            });
            $("#oTable0 input[name*='" + id_gysmc + "_']").each(function () {
                $(this).show();
            });
            $("#oTable0 input[name*='" + id_fph + "_']").each(function () {
                $(this).show();
            });
            $("#oTable0 input[name*='" + id_fpys + "_']").each(function () {
                $(this).show();
            });
        } else {
            $("#oTable0 td[_fieldid*='" + id_gysbh + "_']").each(function () {
                $(this).find("span.e8_delClass").click();
                $(this).children().eq(0).hide();
            });
            $("#oTable0 input[name*='" + id_gysmc + "_']").each(function () {
                $(this).val("").hide();
            });
            $("#oTable0 input[name*='" + id_fph + "_']").each(function () {
                $(this).val("").hide();
            });
            $("#oTable0 input[name*='" + id_fpys + "_']").each(function () {
                $(this).val("").hide();
            });
        }
    }

    //提交前根据支付方式判断明细表填写
    var handleZFFS_CHK = function () {
        var zffs = $("#" + id_zffs);
        var isSuccess = true;
        if (zffs.val() == "T" || zffs.val() == "U" || zffs.val() == "R") {
            $("#oTable0 input[name*='" + id_gysmc + "_']").each(function () {
                if ($(this).val() == "") {
                    window.top.Dialog.alert("请填写供应商！");
                    isSuccess = false;
                    return false;
                }
            });
            if (isSuccess == true) {
                $("#oTable0 input[name*='" + id_fph + "_']").each(function () {
                    if ($(this).val() == "") {
                        window.top.Dialog.alert("请填写发票号！");
                        isSuccess = false;
                        return false;
                    }
                });
            }
            if (isSuccess == true) {
                $("#oTable0 input[name*='" + id_fpys + "_']").each(function () {
                    if ($(this).val() == "") {
                        window.top.Dialog.alert("请填写发票页数！");
                        isSuccess = false;
                        return false;
                    }
                });
            }
        }
        return true;
    }


    /*
    *   供应商预付款申请单
    *  1.如果主表报销类型"费用类 3，人力成本类 2，间接成本 1”时，
    明细表“费用项目名称”栏位必填，并隐藏“资产编号”和“资产描述”；
    如果主表报销类型"固定资产 0”时，
    明细表“资产编号和资产描述”栏位必填，并隐藏“费用明细项目”。
    需求二：
         凭证摘要在流程最后一个节点的审批的节点后附加操作计算生成。（可以先不做）
         生成规则：过账日期“月份”+“供应商名称”+“费用项目名称（明细表循环取值，用逗号隔开）”
         例：10江苏飞力达国际物流股份有限公司上海分公司纸、笔、书本、…

    需求三（这个暂时不做）：
     选择“供应商编号”，时候带出“供应商名称”，并且加载该供应商的预付款信息到表单最下方明细表中（数据来源来之SAP），

     需求四：
“是否有超预算项”逻辑判端，明细表中只要有一条明细中“报销金额”大于“预算金额”即判断“是否有超预算项”值为“Y”没有这为“N”

    */
    //
    var d_zbbxlx = "#field11171"//主表报销类型
    var d_pzhzy = "#field9352"//凭证摘要
    var d_gzrq = "#field10872"//过账日期
    var d_gysmc = "#field9350"//供应商名称
    var d_gysbh = "#field9910"//供应商编号

    var khbh = "#field11083_"; // 客户编号
      var yfkbh= "#field11844_";//OA预付款申请编号
    var pzbh= "#field10844_"; // 凭证编号
    var pzrq = "#field10845_"; // 凭证日期  
    var bz= "#field10846_"; // 币种
    var je= "#field10857_"; //金额
    var cainian= "#field12361_"; //财年	
    var hxms= "#field12362_"; //行项目数	
    var wb = "#field10848_";//文本
    	var gysbh_dt1 = "#field13782_";//明细1供应商编号
    var indexnum_dt1 = 0;
    var khbm="#field9910";
    var gsdm ="#field12451";
    var smsj ="#field10695_"; //税码税金
    var smsj2 ="#field12202_"; //税码税金(修改)
    var bhsje ="#field11030_"; //不含税金额
    var bxje ="#field10645_"; //报销金额
    var zffs ="#field10850"; //支付方式
    var gysbh = "field9910"; //供应商编号
    var gysmc = "field9350"; //供应商名称
    var xjllm = "field11941"; //现金流量码
    var xjllmmc = "field11942"; //现金流量码名称
    var fkzh = "field10870"; //公司付款账号
    var hflx = "field10868"; //还付类型
    var hfje = "field10869"; //还付金额
    var gzrq = "field10872"; //过账日期
    var fjsc = "field10738"; //附件上传

    var zffsfunction =function () {
        var zffs_val=jQuery(zffs).val();

    if(zffs_val=="O"){
        //elementsHideShow(0,0);
        elementsHideShow(1,1);
        elementsHideShow(2,0);
        elementsHideShow(3,0);
    }else if(zffs_val=="P"){
        //elementsHideShow(0,0);
        elementsHideShow(1,1);
        elementsHideShow(2,0);
        elementsHideShow(3,0);
    }else if(zffs_val=="R"){
		var hflx_val2=jQuery("#"+hflx).val();
            if(hflx_val2=="2"){
                elementsHideShow(1,1);
                elementsHideShow(2,0);    
            }else if(hflx_val2=="0"||hflx_val2=="1"){
                elementsHideShow(1,1);
                elementsHideShow(2,0); 
            }else{
				elementsHideShow(1,0);
				elementsHideShow(2,0); 
            }
        jQuery("#"+hflx).bindPropertyChange(function () {

            var hflx_val=jQuery("#"+hflx).val();
            if(hflx_val=="2"){
                elementsHideShow(1,1);
                elementsHideShow(2,0);    
            }else if(hflx_val=="0"||hflx_val=="1"){
                elementsHideShow(1,1);
                elementsHideShow(2,0); 
            }else{
				elementsHideShow(1,0);
				elementsHideShow(2,0); 
            }
        })
        //elementsHideShow(0,1);
        //elementsHideShow(3,1);

    }else{
        //elementsHideShow(0,1);
        elementsHideShow(1,0);
        elementsHideShow(2,0);
        elementsHideShow(3,0);
    }
    }

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
        }else if(sort=="1"){//现金流量码
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
        }else if(sort=="财务审核岗付款账号不变"){
			//20180418财务审核岗付款账号不变else if(sort=="2")
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

                
                jQuery("#"+hfje).show();

        

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
        for(var index =indexnum_dt1;index <indexnum0;index ++){
			bindfyxmmc(index);
            bindchange(index);
            bindchange2(index); 
             if(jQuery(gysbh_dt1+index).length>0){
            bindchange3(index); 
			} 
        } 
        indexnum_dt1 = indexnum0;
    });
    jQuery("button[name=delbutton0]").live("click",function(){
		var indexnum1 = jQuery("#nodesnum2").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_2]:checkbox").attr("checked", true);
				deleteRow2(2);
			}
			 getData1();
	}); 
     function bindchange3(index){
	 jQuery(gysbh_dt1+index).bindPropertyChange(function () {
           
			var indexnum1 = jQuery("#nodesnum2").val();
			if (indexnum1 > 0) {
				jQuery("[name = check_node_2]:checkbox").attr("checked", true);
				deleteRow2(2);   
			}
			 getData1();

		})

 }
 function getData1(){
 var indexnum0=jQuery("#indexnum0").val();
   var gysid='';
     var falgg='';
   for(var index1=0;index1<indexnum0;index1++){
	  if(jQuery(gysbh_dt1+index1).length>0){ 
      var bh_val=jQuery(gysbh_dt1+index1).val();
	    if(bh_val != ''){
            var gysall=","+gysid+",";
            var bh_all=","+bh_val+",";
          if(gysall.indexOf(bh_all)>=0){
           continue;
          }else{
		  gysid = gysid+falgg+bh_val;
          }
		  falgg = ',';
	    }
	  }
     
   }
   if(gysid !=''){
   getdetail2(gysid);
   }
 }
 function getdetail2(gysid){
   var indexnum1=  jQuery("#indexnum2").val();
    var xhr = null;
        if (window.ActiveXObject) {//IE浏览器
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            xhr = new XMLHttpRequest();
        }
        if (null != xhr) {
                        var gsdm_val = jQuery(gsdm).val();
            xhr.open("GET","/feilida/finance/getFI08Info.jsp?id="+gysid+"&custom="+gsdm_val, false);
            xhr.onreadystatechange = function () {

                    if (xhr.readyState == 4) {
                        if (xhr.status == 200) {
                            var text = xhr.responseText;
                            text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');  
                            //alert(text);        
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
 }
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
        var mmn = (y < 10 ? '0' : '') + y; //月份
        var i_gysmc = $(d_gysmc).val(); //供应商名称 
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
             $(".td_ysqje").hide();
        } else if (i_zbbxlx.val() == 1) {
            $(".td_zcbh").show();
            $(".td_zcms").show();
            $(".td_fyxmmc").hide();
              $(".td_ysqje").show();
        }else{
            $(".td_zcbh").show();
            $(".td_zcms").show();
            $(".td_fyxmmc").show();
        }
        initD();
    }
    //点击保存的时候再提醒
    var setNX = function () {
        var i_zbbxlx = $(d_zbbxlx + " option:selected")
        if (i_zbbxlx.val() == 0 || i_zbbxlx.val() == 2 || i_zbbxlx.val() == 3) { 
            $("td[name='td_fyxmmc'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("请选择费用项目名称");
                    return false;
                }
            });
        };
        if (i_zbbxlx.val() == 1) { 
            $("td[name='td_zcbh'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("请选择资产编号");
                    return false;
                }
            });
            $("td[name='td_zcms'] input[type='hidden']").each(function () {
                var m = $(this).val();
                if (m == "") {
                    alert("请选择资产描述");
                    return false;
                }
            });
        } 
    } 

    var initD = function () {
        var td_fyxmmc = $("#oTable0 td[name='td_fyxmmc']:last");
        var tr = td_fyxmmc.closest("tr");
        var i_ysxmms = tr.find("td[name='td_fyxmmc'] input[type='hidden']:last"); //费用项目名称
        jQuery("#" + i_ysxmms.attr("id")).bindPropertyChange(function () { initDetail(); });
    }
    jQuery(document).ready(function () {
		
    checkCustomize = function () {

        if (handleZFFS_CHK() == false) { return false; }
        var _budget_temp = "field13742_";//预算信息
        var _percent = "field12621";//超出预算比
        var _keyNum = "field13743_";
        var _cptmoney = "field13744_";
        var _account = "field10645_";
        var indexnum0 = jQuery("#indexnum0").val();
        var indexnum0_temp = jQuery("#indexnum0").val();
           
		var zzkm = "#field10374_";//总账科目
			var kmid1 = "field13882_"; 
            var indexnum00 = jQuery("#indexnum0").val();
			for (var index001 = 0; index001 < indexnum00; index001++) {
				if($(zzkm+index001+"").val()==""){
					var zzkm_val = $("#"+kmid1+index001+"span").text();
					$(zzkm+index001+"").val(zzkm_val);
				
				}
			    
			 }
			
    
        var isSuccess = true;
        var i_zbbxlx = $(d_zbbxlx + " option:selected")
        if (i_zbbxlx.val() == 0 || i_zbbxlx.val() == 2 || i_zbbxlx.val() == 3) { 
            $("td[name='td_fyxmmc'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("请选择费用项目名称");
                    isSuccess=false;
                }
            });
        }
        if (i_zbbxlx.val() == 1) { 
            $("td[name='td_zcbh'] input[type='hidden']").each(function () {
                if ($(this).val() == "") {
                    alert("请选择资产编号");
                    isSuccess=false;
                }
            });
            $("td[name='td_zcms'] input[type='hidden']").each(function () {
                var m = $(this).val();
                if (m == "") {
                    alert("请选择资产描述");
                    isSuccess=false;
                }
            });
        } 
        return isSuccess;
    }
        initDetail();
        jQuery(d_zbbxlx).bindPropertyChange(function () { getlx() }); //主表报销类型
        jQuery(d_gzrq).bindPropertyChange(function () { initDetail() }); //过账日期
        jQuery(d_gysbh).bindPropertyChange(function () { initDetail() }); //供应商编号
        $("#oTable0 .addbtn_p").click(function () { getlx() }); //添加的按钮
         var nodesnum4=jQuery("#nodesnum0").val();
        var indexnum4=jQuery("#indexnum0").val();
		 if(nodesnum4>0){
		for(var index=0;index<indexnum4;index++){
				 if(jQuery(gysbh_dt1+index).length>0){
				 bindchange3(index)
				 }
			 }
		 }
		setTimeout('zffsfunction()',1000);
        //window.setTimeout("initD ()", 1000);
        //setTimeout('bind()',500);

    });  

function bindfyxmmc(index){
		jQuery("#"+_fyxmmc+index).bindPropertyChange(function () {
			var fyxxmc_val = jQuery("#"+_fyxmmc+index).val();
			getzzkm01(fyxxmc_val,index);
		})
		
	}
		
	function getzzkm01(fyxmmc,index){
		    jQuery.ajax({
             type: "POST",
             url: "/feilida/js/cpt/fl_zzkm.jsp",
             data: {'fyxmmc':fyxmmc},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                       jQuery("#"+_zzkm01+index).val(data);
						
             }
         });

		
	}
jQuery(document).ready(function () {

         jQuery("#" + id_zffs).bindPropertyChange(handleZFFS_CHG); //支付方式变更
        $("#oTable0 button.addbtn_p").click(function () {
            setTimeout("handleZFFS_CHG()", 1000);
        });

	var applyworkflow = "#field13881"; // 物品申请流程
	var expenseType = "#field11171"; // 报销类型
          var oadate = "#field9313"; //申请日期
	var _dept = "field9915_"; // 部门
	var _deptName = "field9354_"; // 部门名称
	var _cptCard = "field13581_"; // 资产卡片
	var _cptDescribe = "field10802_"; // 资产描述
	var _budgetMoney = "field13744_"; // 预算金额
	var _expense = "field10645_"; // 报销金额
	var _businessRange = "field10693_"; // 业务范围
	var _busiRangeName = "field11309_"; // 业务范围名称
	var _tax = "field10853_"; // 税码
	var _taxRate = "field10855_"; // 税率
	var _taxes = "field12202_"; //税金
	var _noTax = "field11030_"; // 不含税金额
	var _insideOrder = "field9918_"; // 内部订单号
	var _insideOrderDesc = "field9359_"; //内部订单号描述
var reqid_dt = "field13884_";
	var wpbm = "field13921_";
	var exetype = "field13922_";
      var useDept = "#field9315"; //使用部门
        var GSBER = "#field13902";//业务范围
    	var ysly = "#field13901";//预算来源
    	  var bxrid =  "#field9312";
	  //明细
    var _budget = "field13742_"; //预算信息
    var _cptNumber = "field10374_"; //资产编号
    var _cptmoney= "field13744_"; //预算金额
    var _cptKSTAR= "field10374_"; //科目id
    var _keyNum = "field13743_";//标识码
    	var nodesnum0=jQuery("#nodesnum0").val();
        	 var indexnum0=jQuery("#indexnum0").val();
        	 if(nodesnum0>0){
                    var expenseType_val = jQuery(expenseType).val();
        	       if (expenseType_val != '1') {    
			 for(var index=0;index<indexnum0;index++){
				 if(jQuery("#"+_cptKSTAR+index).length>0){
				    fl_dtChange(_cptKSTAR, index) ;
					bindfyxmmc(index);
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
                      alert("请先填写报销部门");
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
                      alert("请先填写报销部门");
                      return;
                     }
                get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum,tmp_dept,useDept,'');
                }
        });
    }
    function get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum,tmp_dept,tmp_usedept,tmp_exetype) {
      
    }
    
	function fl_change(_rowdtid) {
		//alert("_rowdtid=" + _rowdtid);
		var zzkm="field13882_";
		var xhr = null;
		if (window.ActiveXObject) { //IE浏览器
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

								jQuery("#" + _deptName + i).val(tmp_arr[0]); //存放id
								jQuery("#" + _deptName + i + "span").html(tmp_arr[0]); //存放名称

								jQuery("#" + _dept + i).val(tmp_arr[1]); //存放id
								jQuery("#" + _dept + i + "span").html(tmp_arr[1]); //存放名称

								jQuery("#" + _cptCard + i).val(tmp_arr[2]); //存放id
								jQuery("#" + _cptCard + i + "span").html(tmp_arr[2]); //存放名称

								jQuery("#" + _cptDescribe + i).val(tmp_arr[3]); //存放id
								jQuery("#" + _cptDescribe + i + "span").html(tmp_arr[3]); //存放名称

								jQuery("#" + _budgetMoney + i).val(tmp_arr[4]); //存放id
								jQuery("#" + _budgetMoney + i + "span").html(tmp_arr[4]); //存放名称

								jQuery("#" + _budget + i).val(tmp_arr[5]); //存放id
								jQuery("#" + _budget + i + "span").html(tmp_arr[5]); //存放名称

								jQuery("#" + _businessRange + i).val(tmp_arr[6]); //存放id
								jQuery("#" + _businessRange + i + "span").html(tmp_arr[6]); //存放名称

								jQuery("#" + _busiRangeName + i).val(tmp_arr[7]); //存放id
								jQuery("#" + _busiRangeName + i).val(tmp_arr[7]); //存放id
								//jQuery("#" + _cityType + i + "span").html(tmp_arr[6]); //存放名称

								jQuery("#" + _tax + i).val(tmp_arr[8]); //存放id
								jQuery("#" + _tax + i + "span").html(tmp_arr[8]); //存放名称

								jQuery("#" + _taxRate + i).val(tmp_arr[9]); //存放id
								jQuery("#" + _taxRate + i + "span").html(tmp_arr[9]); //存放名称

								jQuery("#" + _taxes + i).val(tmp_arr[10]); //存放id
								jQuery("#" + _taxes + i + "span").html(tmp_arr[10]); //存放名称

								jQuery("#" + _insideOrder + i).val(tmp_arr[11]); //存放id
								jQuery("#" + _insideOrder + i + "span").html(tmp_arr[11]); //存放id
								//jQuery("#" + _cityType + i + "span").html(tmp_arr[6]); //存放名称

								jQuery("#" + _insideOrderDesc + i).val(tmp_arr[12]); //存放id
								jQuery("#" + _insideOrderDesc + i + "span").html(tmp_arr[12]); //存放名称
							//	alert("13"+tmp_arr[13]);	
								jQuery("#" + zzkm + i).val(tmp_arr[13]); //存放id
								jQuery("#" + zzkm + i + "span").html(tmp_arr[13]); //存放名称
								//alert("134"+tmp_arr[14]);	
								jQuery("#" + _keyNum + i).val(tmp_arr[14]); //存放id
								jQuery("#" + _keyNum + i + "span").html(tmp_arr[14]); //存放名称
									
								jQuery("#" + _expense + i).val(tmp_arr[15]); //存放id
                                                  jQuery("#" + reqid_dt + i).val(tmp_arr[16]); //存放id
								jQuery("#" + reqid_dt + i + "span").html(tmp_arr[16]); //存放名称
									 jQuery("#" + wpbm + i).val(tmp_arr[17]); //存放id
								jQuery("#" + wpbm + i + "span").html(tmp_arr[17]); //存放名称
								//	alert(tmp_arr[18]);
										 jQuery("#" + exetype + i).val(tmp_arr[18]); //存放id
								jQuery("#" + exetype + i + "span").html(tmp_arr[18]); //存放名称
									var tmp_budget = "#" + _budget + i;
            							var tmp_cptNumber = "#" + zzkm + i;
                   						var tmp_money= "#" + _cptmoney + i;
                   					      var tmp_KSTAR = "#" + zzkm + i;
                   					      var tmp_keyNum = "#" + _keyNum + i;
                                                        var tmp_dept ="#" + _dept  + i;
                                                        var tmp_usedept="#" + wpbm  + i;
                                                   get_cpt_info(tmp_cptNumber, oadate, tmp_budget,tmp_money,tmp_KSTAR,tmp_keyNum,tmp_dept,tmp_usedept,tmp_arr[18]);
								//jQuery("#" + _hotelStandard + i).val(tmp_arr[9]); //存放id
								//jQuery("#" + _hotelStandard + i + "span").html(tmp_arr[9]); //存放名称

								//jQuery("#" + _foodStandard + i).val(tmp_arr[10]); //存放id
								//jQuery("#" + _foodStandard + i + "span").html(tmp_arr[10]); //存放名称

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































