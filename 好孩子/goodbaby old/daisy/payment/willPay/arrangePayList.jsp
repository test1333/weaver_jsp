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
    String recipient = Util.null2String(request.getParameter("recipient"));
    String fkqx = Util.null2String(request.getParameter("fkqx"));
    String late_pageId = "arrangePayList0001";
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
//    RCMenu += "{付款,javascript:openDialog(),_self} ";
//    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
                <%--<input type=button class="e8_btn_top" onclick="openDialog();" value="发起流程">--%>

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

                <%--<wea:item>付款期限</wea:item>--%>
                <%--<wea:item>--%>
                    <%--<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(fkqx,fkqxspan)"></BUTTON>--%>
                    <%--<SPAN id=fkqxspan><%=fkqx%></SPAN>--%>
                    <%--<INPUT  type="hidden" name="fkqx" value="<%=fkqx%>">--%>
                <%--</wea:item>--%>
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
                    <input class="e8_btn_submit" type="submit" name="submit_1" onClick="onBtnSearchClick()"
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
    String backfields = " t.*  ";
    //表单中的字段
    String fromSql = " from gb_payFlowView t ";//sql查询的表
    String sqlWhere = " no >0 and t.SJFKZJE>0";//where条件

//     out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
    String orderby = " requestid ";//排序关键字
    String tableString = "";

    tableString = " <table tabletype=\"checkbox\" pagesize=\"" + PageIdConst.getPageSize(late_pageId, user.getUID(), PageIdConst.HRM) + "\" pageId=\"" + late_pageId + "\">" +
            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\"  sqlorderby=\"" + orderby + "\" " +
            " sqlprimarykey=\"requestid\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>" +
            "	<head>";
    tableString += "		    <col width=\"40%\" text=\"排款流程\" column=\"requestid\" orderkey=\"requestid\" " +
            "           transmethod=\"weaver.workflow.request.RequestComInfo.getRequestname\" " +
            "           linkvaluecolumn=\"requestid\" linkkey=\"requestid\"" +
            "           href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />" +
            "           <col width=\"30%\"  text=\"计划付款金额（人民币）\" column=\"JHFKZJE\" " +
            "           orderkey=\"JHFKZJE\"  otherpara=\"column:requestid\"  " +
            "           transmethod=\"goodbaby.daisy.payment.OpenDialog.getLinkType\" />"+
            "		    <col width=\"30%\" text=\"实际付款金额（人民币）\" column=\"SJFKZJE\" orderkey=\"SJFKZJE\" />"+
            "	</head>" +
            " </table>";
%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
<script type="text/javascript">
    function onBtnSearchClick() {
        report.submit();
    }
    function openDialog(url,title){
        dialog = new window.top.Dialog();
        dialog.currentWindow = window;
        var url = url;
        dialog.Title = title;
        dialog.Width = 900;
        dialog.Height = 500;
        dialog.Drag = true;
        dialog.URL = url;
        dialog.maxiumnable=true;//允许最大化
        dialog.show();
    }
    function showVi(vid){
        if(vid=="") return ;
       // alert(vid);
        var url = "/goodbaby/daisy/payment/willPay/editPayYS.jsp?requestid="+vid;
        var title = "付款";
        openDialog(url,title);
    }



</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>
