<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
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
        elementsHideShow(0,1);
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
        }
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
         
        window.setTimeout("initD ()", 1000);
        setTimeout('bind()',500);

        jQuery(khbm).bindPropertyChange(function (){ 
             var indexnum1=  jQuery("#indexnum2").val();
                if(indexnum1>0){
                      jQuery("[name = check_node_2]:checkbox").attr("checked", true);
                    deleteRow2(2);                                                               
                }  
            var xhr = null;
        if (window.ActiveXObject) {//IE浏览器
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
</script>




















