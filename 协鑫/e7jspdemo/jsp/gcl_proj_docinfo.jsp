<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="MBU" class="weaver.interfaces.shaw.util.MultiBrowserUtil" scope="page"/>
<jsp:useBean id="WorkflowRequestComInfo" class="weaver.workflow.workflow.WorkflowRequestComInfo" scope="page"/>
<html>
<head>
    <script type="text/javascript" src="/js/weaver.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>
<%
    int emp_id = user.getUID();
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
    int perpage = 5;
    String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "项目基本信息";
    String needfav = "1";
    String needhelp = "";

    String proj_id = Util.null2String(request.getParameter("proj_id"));

%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:document.weaver.submit(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
        <tr>
            <td height="10" colspan="3"></td>
        </tr>
        <tr>
            <td></td>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                            <FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
                                <input type="hidden" name="multiRequestIds" value="">
                                <input type="hidden" name="operation" value="">
                                <TABLE width="100%">
                                    <tr>
                                        <td valign="top">
                                            <%
                                                //V_GCL_PROJINFO formtable_main_2471
                                                String backfields = " id,rwmc,fzr,formmodeid,xgdoc,xgworkflow,ssxm,status,tjrq   ";
                                                String fromSql = " from V_GCL_PROJDOCINFO ";
                                                String sqlWhere = " SSXM=" + proj_id + " ";

                                                //out.println("select "+ backfields + fromSql + " where " + sqlWhere);
                                                //out.println(sqlWhere);
                                                String orderby = " id ";
                                                String tableString = "";

                                                String type1 = "doc";
                                                String type2 = "request";
                                                String type3 = "resource";

                                                tableString = " <table  tabletype=\"none\" pagesize=\"" + perpage + "\" >" +
                                                        "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />" +
                                                        "			<head>" +
                                                        " 	<col width=\"25%\" text=\"任务名称\" column=\"rwmc\" orderkey=\"rwmc\"  />" +
                                                        "	<col width=\"10%\" text=\"负责人\" column=\"fzr\" orderkey=\"fzr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />" +
                                                        "	<col width=\"25%\" text=\"相关文档\" column=\"xgdoc\" orderkey=\"xgdoc\" otherpara=\"doc\" "
                                                        + " transmethod=\"weaver.interfaces.shaw.util.MultiBrowserUtil.getMultiBrowserValue\" />" +
                                                        " 	<col width=\"25%\" text=\"相关流程\" column=\"xgworkflow\" orderkey=\"xgworkflow\" otherpara=\"request\" "
                                                        + " transmethod=\"weaver.interfaces.shaw.util.MultiBrowserUtil.getMultiBrowserValue\" />" +
                                                        " 	<col width=\"10%\" text=\"提交日期\" column=\"tjrq\" orderkey=\"tjrq\"  />" +
                                                        "			</head>" +
                                                        "</table>";
                                            %>
                                            <wea:SplitPageTag tableString="<%=tableString%>" mode="run"
                                                              showExpExcel="true"/>
                                        </td>
                                    </tr>
                                </TABLE>
                            </FORM>
                        </td>
                    </tr>
                </TABLE>
            </td>
            <td></td>
        </tr>
        <tr>
            <td height="10" colspan="3"></td>
        </tr>
</table>
</BODY>
</HTML>
