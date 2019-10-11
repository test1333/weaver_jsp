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
    String recipient = Util.null2String(request.getParameter("recipient"));
    String htbh = Util.null2String(request.getParameter("htbh"));
    String htmc = Util.null2String(request.getParameter("htmc"));
    String late_pageId = "daisy111";
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
%>
<%
    RCMenu += "{导出全部,javascript:_xtable_getAllExcel(),_self} " ;
    RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
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
                <wea:item>经办人姓名</wea:item>
                <wea:item>
                    <brow:browser viewType="0" name="recipient" browserValue="<%=recipient %>"
                                  browserOnClick=""
                                  browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                                  hasInput="true" isSingle="false" hasBrowser="true" isMustInput='1'
                                  completeUrl="/data.jsp" width="165px"
                                  browserSpanValue="<%=Util.toScreen(rci.getResourcename(recipient),user.getLanguage())%>">
                    </brow:browser>
                </wea:item>
                <wea:item>合同编号</wea:item>
                <wea:item>
                    <input type="text" name="htbh" style='width:80%' value="">
                </wea:item>
                <wea:item>合同名称</wea:item>
                <wea:item>
                    <input type="text" name="htmc" style='width:80%' value="">
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
    String backfields = " id,JBRXM,HTMC,HTBH,BBJE,f.HTJZRQ,f.HTSXRQ,(select selectname from workflow_selectitem where fieldid='13301' and selectvalue=HTXZ) as HTXZ," +
           " (select selectname from workflow_selectitem where fieldid='13314' and selectvalue=QYZT) as QYZT," +
            "(select GYSMC from uf_suppmessForm where id=f.GYSMC) as GYS,GYSMC,f.requestId,FKQ";
    //表单中的字段
    String fromSql = " from formtable_main_233 f left join  workflow_requestbase r on f.requestId=r.requestid ";//sql查询的表
    String sqlWhere = " r.currentnodetype = 3  ";//where条件
    //合同编号
    if(!"".equals(htbh)){
        sqlWhere += " and HTBH like '%"+htbh+"%' ";
    }
    if(!"".equals(htmc)){
        sqlWhere += " and HTMC like '%"+htmc+"%' ";
    }
   // out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
    String orderby = " id ";//排序关键字
    String tableString = "";

    tableString = " <table tabletype=\"none\" pagesize=\"" + PageIdConst.getPageSize(late_pageId, user.getUID(), PageIdConst.HRM) + "\" pageId=\"" + late_pageId + "\">" +
            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\"  sqlorderby=\"" + orderby + "\" " +
            "      sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>" +
            "	<head>";
    tableString += "    <col width=\"8%\" text=\"合同/项目名称\" column=\"HTMC\" orderkey=\"HTMC\" />" +
            "    		<col width=\"6%\" text=\"合同编号\" column=\"HTBH\" orderkey=\"HTBH\" />" +
            "		    <col width=\"10%\" text=\"经办人姓名\" column=\"JBRXM\" orderkey=\"JBRXM\" " +
            "           transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />" +
            "		    <col width=\"7%\" text=\"合同性质\" column=\"HTXZ\" orderkey=\"HTXZ\" />" +
            "		    <col width=\"13%\" text=\"签约主体\" column=\"QYZT\" orderkey=\"QYZT\" />" +
            "		    <col width=\"5%\" text=\"付款期\" column=\"FKQ\" orderkey=\"FKQ\" />" +
            "		    <col width=\"8%\" text=\"合同生效日期\" column=\"HTSXRQ\" orderkey=\"HTSXRQ\" />" +
            "		    <col width=\"8%\" text=\"合同截止日期\" column=\"HTJZRQ\" orderkey=\"HTJZRQ\" />" +
            "		    <col width=\"10%\" text=\"供应商\" column=\"GYS\" orderkey=\"GYS\" " +
            " 			linkvaluecolumn=\"GYSMC\" linkkey=\"billid\" " +
            " 			href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=41&amp;formId=-202\" target=\"_fullwindow\" />" +
            "		    <col width=\"10%\" text=\"流程\" column=\"requestId\" orderkey=\"requestId\" " +
            "           transmethod=\"weaver.workflow.request.RequestComInfo.getRequestname\" " +
            "           linkvaluecolumn=\"requestid\" linkkey=\"requestid\"" +
            "           href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />" +
            "	</head>" +
            " </table>";
%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true"/>
<script type="text/javascript">
    function onBtnSearchClick () {
        report.submit();
    }

    function firm () {
        Dialog.confirm("是否统计迟到时间？", function () {
            report.action = "/seahonor/attend/jsp/CountLate.jsp";
            report.submit();
        }, function () {}, 320, 90, false);

    }
</script>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>
