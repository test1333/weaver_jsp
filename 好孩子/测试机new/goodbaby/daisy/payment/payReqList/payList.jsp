<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.general.PageIdConst" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<HTML>
<HEAD>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script> 
    <script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
</head>
<%
    String imagefilename = "/images/hdReport_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(20536, user.getLanguage());
    String needfav = "1";
    String needhelp = "";

    int userId = user.getUID();//获取当前登录用户的ID
    String idkey = Util.null2String(request.getParameter("idkey"));
    String company = Util.null2String(request.getParameter("company"));
    String fkqx = Util.null2String(request.getParameter("fkqx"));
    //String fkdw = Util.null2String(request.getParameter("fkdw"));
    String bz = Util.null2String(request.getParameter("bz"));
    String cgdl = Util.null2String(request.getParameter("cgdl"));
    String late_pageId = "payList00002";
    String bzspan = "";
    String sql = "";
    if(!"".equals(bz)){
        sql = "select bz1 from uf_hl where id="+bz;
        rs.executeSql(sql);
        if(rs.next()){
            bzspan = Util.null2String(rs.getString("bz1"));
        }
    }
    String cgdlspan = "";
    if(!"".equals(cgdl)){
        sql = "select buydl from uf_buydl where id="+cgdl;
        rs.executeSql(sql);
        if(rs.next()){
            cgdlspan = Util.null2String(rs.getString("buydl"));
        }
    }
%>
<BODY>
<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
				<%=SystemEnv.getHtmlLabelName(20536, user.getLanguage()) %></span>
</div>
<input type="hidden" _showCol="false" name="pageId" id="pageId" value="<%=late_pageId%>"/>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    // RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage()) + ",javascript:onBtnSearchClick(),_self} ";
    // RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{发起流程,javascript:createWorkflow(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
                <input type=button class="e8_btn_top" onclick="createWorkflow();" value="发起流程">
                </input>
                <span id="advancedSearch" class="advancedSearch">
						<%=SystemEnv.getHtmlLabelName(21995, user.getLanguage())%>
						</span>
                <span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
            </td>
        </tr>
    </table>
    <div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
        <wea:layout type="4col">
            <wea:group context="查询条件">
                <%--<wea:item>员工姓名</wea:item>--%>
                <%--<wea:item>--%>
                <%--<brow:browser viewType="0" name="recipient" browserValue="<%=recipient %>"--%>
                <%--browserOnClick=""--%>
                <%--browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="--%>
                <%--hasInput="true" isSingle="false" hasBrowser="true" isMustInput='1'--%>
                <%--completeUrl="/data.jsp" width="165px"--%>
                <%--browserSpanValue="<%=Util.toScreen(rci.getResourcename(recipient),user.getLanguage())%>">--%>
                <%--</brow:browser>--%>
                <%--</wea:item>--%>

                <wea:item>付款期限</wea:item>
                <wea:item>
                    <button type="button" class=Calendar id="SelectDate" onclick="gettheDate(fkqx,fkqxspan)"></BUTTON>
                    <SPAN id=fkqxspan><%=fkqx%></SPAN>
                    <INPUT type="hidden" name="fkqx" id="fkqx" value=<%=fkqx%>>
                </wea:item>
                <wea:item>币种</wea:item>
                <wea:item>
                    <brow:browser viewType="0" name="bz" id="bz"
                                  browserValue="<%=bz%>"
                                  browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.huin"
                                  hasInput="true" hasBrowser="true" isMustInput='1'
                                  isSingle="false"
                                  width="165px"
                                  linkUrl=""
                                  browserSpanValue="<%=bzspan%>">
                    </brow:browser>
                </wea:item>
                <wea:item>公司（单位）</wea:item>
                <wea:item>
                    <select class="e8_btn_top middle" style="width:200px" name="company" id="company">
                    <option value="" <%if("".equals(company)){%> selected<%} %>>
                        <%=""%></option>
                    <%
                        sql = "select distinct dw from uf_company";
                        rs.executeSql(sql);
                        while(rs.next()){
                            String dw = Util.null2String(rs.getString("dw"));
                    %>
                    <option value="<%=dw%>" <%if(dw.equals(company)){%> selected<%} %>>
                        <%=dw%></option>
                    <%
                        }
                    %>
                    </select>
                 </wea:item>
                <wea:item>采购大类</wea:item>
                <wea:item>
                    <brow:browser viewType="0" name="cgdl" id="cgdl"
                                  browserValue="<%=cgdl%>"
                                  browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.btn_buydl01"
                                  hasInput="true" hasBrowser="true" isMustInput='1'
                                  isSingle="false"
                                  width="165px"
                                  linkUrl=""
                                  browserSpanValue="<%=cgdlspan%>">
                    </brow:browser>
                </wea:item>
            </wea:group>

            <wea:group context="">
                <wea:item type="toolbar">
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>"
                           class="e8_btn_submit" onclick="onBtnSearchClick();"/>
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>"
                           class="e8_btn_cancel" id="cancel"/>
                </wea:item>
            </wea:group>

            <wea:group context="">
                <wea:item type="toolbar">
                    <input class="e8_btn_submit" type="button" name="submit_1" onClick="onBtnSearchClick()"
                           value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
                    <span class="e8_sep_line">|</span>
                    <input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()"
                           value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
                    <span class="e8_sep_line">|</span>
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>"
                           class="e8_btn_cancel" id="cancel"/>
                </wea:item>
            </wea:group>
        </wea:layout>
    </div>
</FORM>
<%
    int count = 0;
    String sqlcount="select count(1) as count from gb_payReqView2 where fkqx<= '" + fkqx + "' and bz = '" + bz + "' and gs = '" + company + "' and cgdl ='"+cgdl+"' ";
    if("".equals(fkqx)||"".equals(bz)||"".equals(company)||"".equals(cgdl)){
       sqlcount = sqlcount + "and 1=2";
    }
    rs.executeSql(sqlcount);
    if(rs.next()){
        count = rs.getInt("count");
    }
    //out.print(count);
    String backfields = " * ";
    //表单中的字段
    String fromSql = " from (select max(gys) as gys,gysmc,max(fkqx) as fkqx,max(gs) as gs,bz,sum(ybje) as ybje,"+
" sum(rmb) as rmb ,max(YHZH) as yhzh,max(LHH) as lhh,max(KHH) as khh,max(jgh) as jgh,max(CNAPS) as CNAPS,"+
" max(ZHSK) as zhsk,cgdl,max(cgdlspan) as cgdlspan from dbo.[gb_payReqView2] where fkqx&lt;='" + fkqx + "' group by gysmc,bz,gs,cgdl) t ";//sql查询的表
    String sqlWhere = " bz = '" + bz + "'";//where条件
    
    if (!"".equals(company)) {
        sqlWhere += " and gs = '" + company + "'";
    }
    if (!"".equals(cgdl)) {
        sqlWhere += " and cgdl ='"+cgdl+"'";
    }
    if("".equals(fkqx)||"".equals(bz)||"".equals(company)||"".equals(cgdl)){
       sqlWhere = sqlWhere + "and 1=2 ";
   }
//    out.println("select " + backfields + fromSql + "where" + sqlWhere);
    String orderby = " gysmc";//排序关键字
    String tableString = "";

    tableString = " <table tabletype=\"none\" pagesize=\"" + PageIdConst.getPageSize(late_pageId, user.getUID(), PageIdConst.HRM) + "\" pageId=\"" + late_pageId + "\">" +
            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\"  sqlorderby=\"" + orderby + "\" " +
            " sqlprimarykey=\"gysmc\" sqlsortway=\"asc\" sqlisdistinct=\"false\"   sumColumns=\"ybje,rmb\" showCountColumn=\"true\" decimalFormat=\"%,.2f|%,.2f\"/>\"+/>" +
            "	<head>";
    tableString += "   <col width=\"8%\" text=\"公司\" column=\"gs\" orderkey=\"gs\" />" +
            "   <col width=\"9%\" text=\"供应商名称\" column=\"gys\" orderkey=\"gys\" " +
            "   linkvaluecolumn=\"gysmc\" linkkey=\"billid\" " +
            "   href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=41&amp;formId=-202\" target=\"_fullwindow\" />" +
            "	<col width=\"8%\" text=\"币种\" column=\"bz\" orderkey=\"bz\" " +
            "   transmethod=\"goodbaby.price.ChangeCurrency.getLinkType\" " +
            "   linkvaluecolumn=\"bz\" linkkey=\"billid\" " +
            "   href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=2&amp;formId=-50\" target=\"_fullwindow\" />" +
            "	<col width=\"9%\" text=\"原币金额\" column=\"ybje\" orderkey=\"ybje\" />" +
            "	<col width=\"9%\" text=\"人民币金额\" column=\"rmb\" orderkey=\"rmb\" " +
            "   otherpara=\"column:gysmc+column:gs\"" +
            "   transmethod=\"goodbaby.daisy.payment.OpenDialog.getLinkType\" />" +
//            "   href= \"/goodbaby/daisy/payment/payReqList/paydtList.jsp?fkqx=" + fkqx + "&amp;bz=" + bz + "\" target=\"view_window\"/>" +
            "   <col width=\"8%\" text=\"收款银行\" column=\"khh\" orderkey=\"khh\" />" +
            "   <col width=\"8%\" text=\"收款银行账号\" column=\"yhzh\" orderkey=\"yhzh\" />" +
            "   <col width=\"8%\" text=\"收款行联行号\" column=\"lhh\" orderkey=\"lhh\" />" +
            "   <col width=\"8%\" text=\"收款行机构号\" column=\"jgh\" orderkey=\"jgh\" />" +
            "   <col width=\"9%\" text=\"是否中行收款标识\" column=\"zhsk\" orderkey=\"zhsk\" />" +
            "   <col width=\"8%\" text=\"CNAPS行号\" column=\"CNAPS\" orderkey=\"CNAPS\" />" +
            "   <col width=\"8%\" text=\"采购大类\" column=\"cgdlspan\" orderkey=\"cgdlspan\" />" +
            "	</head>" +
            " </table>";
%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
<script type="text/javascript">
    function onBtnSearchClick() {
        var fkqx = jQuery("#fkqx").val();
        var bz = jQuery("#bz").val();
        var cgdl = jQuery("#cgdl").val();
        var company = jQuery("#company").val();
        // alert(fkqx+","+bz);
        if (fkqx.length <= 0 || bz.length <= 0 || cgdl.length <= 0||company.length <= 0) {
            alert("付款期限、币种、采购大类均、公司均为必填项"); 
            return;
        } 
        report.submit();
        

    }

    /**
     * 发起流程
     * @returns {boolean}
     */
    function createWorkflow() {
        var userId = '<%=userId%>'
        var fkqx = '<%=fkqx%>'
        var bz = '<%=bz%>'
        var company = '<%=company%>'
        var cgdl = '<%=cgdl%>'
        var count = '<%=count%>'
        if(Number(count)<=Number("0")){
            alert("无待排款数据，无法触发流程");
            return;
        }
        Dialog.confirm('确定发起流程？', function () {
            // frmmain.action = 'createPOFlow.jsp?id=' + ids + '&userId=' + userId
            // frmmain.submit()
            var result = createPayFlow(userId, fkqx, bz, company,cgdl)
            if (result === '0') {
                location.reload()
                dialog.closeByHand()
                // parentWin.Dialog.alert('流程创建成功！')
            }
        }, function () {
        }, 320, 90, false)

    }


    function createPayFlow(userId, fkqx, bz, company,cgdl) {
        var result = '1'
           jQuery.ajax({
             type: "POST",
             url: "/goodbaby/daisy/payment/payReqList/createPayFlow.jsp",
             data: {'userId':userId, 'fkqx':fkqx, 'bz':bz, 'com':company, 'cgdl':cgdl},
             dataType: "text",
             async:false,//同步   true异步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                        result=data;
                      }
         });

        //var a = {
        //    url: 'createPayFlow.jsp?userId=' + userId + '&fkqx=' + fkqx + '&bz=' + bz + '&com=' + company+ '&cgdl=' + cgdl,
         //  data: jQuery('#frmmain').serialize(), // 要发送的是frmmain表单中的数据
         //   type: 'post',
         //   async: false,
         //   success: function (data) {
         //       data = data.replace(/\n/g, '').replace(/\r/g, '')
                //alert(data)
        //        if (data === '0') {
         //           result = '0'
         //       }
         //   }
       // }
       // jQuery.ajax(a)
        return result
    }

    function openDialog(url, title) {
        dialog = new window.top.Dialog();
        dialog.currentWindow = window;
        var url = url;
        dialog.Title = title;
        dialog.Width = 1100;
        dialog.Height = 700;
        dialog.Drag = true;
        dialog.URL = url;
        dialog.maxiumnable = true;//允许最大化
        dialog.show();
    }

    function showVi(vid, com) {
        var fkqx = "<%=fkqx%>";
        var bz = "<%=bz%>";
        if (vid == "") return;
        var gysmc = vid.split("+")[0];
        var comspan = vid.split("+")[1];
        var url = "/goodbaby/daisy/payment/payReqList/paydtList_url.jsp?fkqx=" + fkqx + "&bz=" + bz + "&gysmc=" + gysmc + "&com=" + comspan;
        var title = "付款";
        openDialog(url, title);
    }

    var idkey = '<%=idkey%>'
    // alert("idkey="+idkey);
    if (idkey === '0') {
        alert('流程创建成功')
    }

</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>
