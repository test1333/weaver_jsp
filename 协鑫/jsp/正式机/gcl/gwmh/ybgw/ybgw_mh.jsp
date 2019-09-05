<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<html>
<head>
    <script type="text/javascript" src="/js/weaver.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>
<%
    int emp_id = user.getUID();
	// out.print("emp_id-------"+emp_id);
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
    String lx = Util.null2String(request.getParameter("lx"));
	// String lastname = Util.null2String(request.getParameter("lastname"));
	// String workcode = Util.null2String(request.getParameter("workcode"));
    int perpage = 5;
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "已办传阅子流程";
    String needfav = "1";
    String needhelp = "";
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
        <tr>
            <td height="10" colspan="2"></td>
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
				String 	backfields = " a.requestid,a.requestname,b.receivedate ,b.receivetime,a.creater,(select lastname from hrmresource where id = a.creater) as lastname ";				
                String fromSql = "  from workflow_requestbase a join workflow_currentoperator b on a.requestid =b.requestid join formtable_main_3787 c on a.requestid =c.requestid  ";
                String sqlWhere = " where a.requestid = b.requestid and b.isremark in(2,4) and b.islasttimes=1   and b.userid ='"+emp_id+"'";
				 if(!"".equals(lx)){
                    sqlWhere = sqlWhere + " and  c.gwlx ="+lx;
                }
                // if (emp_id!=1) {
                    // sqlWhere += " and b.userid ='"+emp_id+"'";
                // }	

				// out.print("select "+backfields +fromSql+sqlWhere);
                String orderby = " b.receivedate desc, b.receivetime desc";
                String tableString = "";
                tableString = " <table  tabletype=\"none\" pagesize=\"" + perpage + "\" >" +
				"	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"a.requestid\" sqlsortway=\"asc\" />" +
                        "			<head>" +
			" 	<col width=\"50%\" text=\"标题\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\"  target=\"_fullwindow\" />" +
            " 	<col width=\"16%\" text=\"创建人\" column=\"creater\" orderkey=\"creater\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" linkvaluecolumn=\"creater\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp\" target=\"_fullwindow\"/>" +
            " 	<col width=\"16%\" text=\"接收日期\" column=\"receivedate\" orderkey=\"receivedate\" />" +
            " 	<col width=\"16%\" text=\"接收时间\" column=\"receivetime\" orderkey=\"receivetime\"   />" +
                        "			</head>" +
                        "</table>";
            %>

            <wea:SplitPageTag tableString="<%=tableString%>" mode="run" isShowTopInfo="false" />
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
</table>
<script type="text/javascript">
    function refresh() {
        window.location.reload();
    }
 
    function onShowResource() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?selectedids=" + jQuery("#lastname").val());
        if (data != null) {
            if (data.id != "") {
                ids = data.id.split(",");
                names = data.name.split(",");
                sHtml = "";
                for (var i = 0; i < ids.length; i++) {
                    if (ids[i] != "") {
                        sHtml = sHtml + names[i] + "&nbsp;&nbsp;";
                    }
                }
                jQuery("#lastnamespan").html(sHtml);
                jQuery("input[name=lastname]").val(data.id.substr(1));
            } else {
                jQuery("#lastnamespan").html("");
                jQuery("input[name=lastname]").val("");
            }
        }
    }
   
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
</BODY>
</HTML>