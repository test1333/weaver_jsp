<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
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
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
	// String workcode = Util.null2String(request.getParameter("workcode"));
    int perpage = 10;
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "已阅公文";
    String needfav = "1";
    String needhelp = "";
    DocUtil du = new DocUtil();
    String lx = Util.null2String(request.getParameter("lx"));
    String swtable = du.getBillTableName("GWLX");
    String gwlxname = "";
    String sql = "select gwlx from " + swtable + " where id='"+lx+"'";
    rs.executeSql(sql);
    if (rs.next()) {
        gwlxname = Util.null2String(rs.getString("gwlx"));
    }
    String cjren = Util.null2String(request.getParameter("cjren"));
    String requestname = Util.null2String(request.getParameter("requestname"));
    String StartDateF = Util.null2String(request.getParameter("StartDateF"));
    String EndDateF = Util.null2String(request.getParameter("EndDateF"));
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(197,user.getLanguage()) + ",javascript:document.weaver.submit(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{刷新,javascript:refresh(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
%>
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
                                <table width=100% class=ViewForm>
    <colgroup>
        <COL width="15%">
            <COL width="35%">
            <COL width="15%">
            <COL width="35%">
    </colgroup>
    <tr>
        <TD align="center" valign="middle">公文类型</TD>
        <TD class=fvalue>
            <BUTTON class=Browser type="button" onClick="onShowBrowser1()">
            </BUTTON>
            <SPAN id=gwlxspan><%=gwlxname%></SPAN><INPUT id=lx type=hidden name=lx temptitle="公文类型" viewtype="0"
                                                         value="<%=lx%>">
        </TD>
        <TD align="center" valign="middle">标题</TD>
        <td><input class=inputstyle id='requestname' name=requestname size="20" value="<%=requestname%>">
        </td>
    </tr>
   
    <tr>
       
        <TD align="center" valign="middle">创建人</TD>
        <td>
            <button class=Browser type="button" onClick="onShowResource()"></button>
            <span id=cjrenspan><%=Util.toScreen(ResourceComInfo.getLastnames(cjren), user.getLanguage())%></span>
            <input class=inputstyle id=cjren type=hidden name=cjren value="<%=cjren%>">
        </td>
        <TD align="center" valign="middle">接收日期</TD>
        <TD>
            <BUTTON type="button" class=calendar id=SelectDate1
                    onclick="gettheDate(StartDateF,StartDateFspan)"></BUTTON>
            <SPAN id=StartDateFspan><%=StartDateF%></SPAN>
            <input type="hidden" name="StartDateF" value="<%=StartDateF%>">
            -&nbsp;&nbsp;
            <BUTTON type="button" class=calendar id=SelectDate onclick="gettheDate(EndDateF,EndDateFspan)"></BUTTON>
            <SPAN id=EndDateFspan><%=EndDateF%></SPAN>
            <input type="hidden" name="EndDateF" value="<%=EndDateF%>">
        </TD>

    </tr>
    
   
    

    <tr style="height:1px;">
        <td class=Line colspan=11></td>
    </tr>
</table>
                        
<TABLE width="100%">
    <tr>
        <td valign="top">
            <%
				String 	backfields = " a.requestid,a.requestname,b.receivedate ,b.receivetime,a.creater,(select lastname from hrmresource where id = a.creater) as lastname ";				
                String fromSql = "  from workflow_requestbase a join workflow_currentoperator b on a.requestid =b.requestid join formtable_main_2511 c on a.requestid =c.requestid  ";
                String sqlWhere = " where a.requestid = b.requestid and b.isremark in(2,4) and b.islasttimes=1   and b.userid ='"+emp_id+"'";
                if(!"".equals(lx)){
                    sqlWhere = sqlWhere + " and  c.gwlx ="+lx;
                }
                if(!"".equals(requestname)){
                    sqlWhere += " and a.requestname like '%" + requestname + "%'";
                }

                if(!"".equals(StartDateF)){
                    sqlWhere += " and b.receivedate>='" + StartDateF + "' ";
                }
                if(!"".equals(EndDateF)){
                        sqlWhere += " and b.receivedate<='" + EndDateF + "' ";
                }
                if(!"".equals(cjren)){
                        sqlWhere += " and a.creater in("+cjren+") ";
                }
				// if (emp_id!=1) {
                    // sqlWhere += " and b.userid ='"+emp_id+"'";
                // }				
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

            <wea:SplitPageTag tableString="<%=tableString%>" mode="run" isShowTopInfo="false"   />
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
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?selectedids=" + jQuery("#tjren").val());
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
                jQuery("#cjrenspan").html(sHtml);
                jQuery("input[name=cjren]").val(data.id.substr(1));
            } else {
                jQuery("#cjrenspan").html("");
                jQuery("input[name=cjren]").val("");
            }
        }
    }
    function onShowBrowser1() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.gwlx&selectedids=" + jQuery("#gwlx").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "") {
                jQuery("#gwlxspan").html(data.name);
                jQuery("input[name=lx]").val(data.id);
            } else {
                jQuery("#gwlxspan").html("");
                jQuery("input[name=lx]").val("");
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