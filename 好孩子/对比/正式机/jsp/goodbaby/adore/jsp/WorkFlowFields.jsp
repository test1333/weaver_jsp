<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.SystemEnv" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ taglib uri="/browserTag" prefix="brow" %>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page"/>
<%!
    public String getDynamicFields(String workflowId) {
        RecordSet rs = new RecordSet();
        // BaseBean log = new BaseBean();
        String DBType = rs.getDBType();
        // log.writeLog("DBType=" + DBType);
        StringBuilder returnJSON = new StringBuilder();
        String hasDetail = "NoDetail";
        StringBuilder tableIndexSQL = new StringBuilder();
        if ("sqlServer".equalsIgnoreCase(DBType)) {
            tableIndexSQL.append("(case ")
                    .append("isnull(").append("t.detailtable,").append("'").append(hasDetail).append("'").append(")")
                    .append(" when ").append("'").append(hasDetail).append("'").append(" then 0 else ")
                    .append(" cast(substring(t.detailtable , charindex('_dt' , t.detailtable)+3 , ")
                    .append("len(t.detailtable)) as int) end) ");
        } else if ("oracle".equalsIgnoreCase(DBType)) {
            tableIndexSQL.append("(case ")
                    .append("nvl(").append("t.detailtable,").append("'").append(hasDetail).append("'").append(")")
                    .append(" when ").append("'").append(hasDetail).append("'").append(" then 0 else ")
                    .append(" cast(substr(t.detailtable , instr(t.detailtable,'_dt',1,1)+3 , ")
                    .append("length(t.detailtable)) as Number) end) ");
        }
        // log.writeLog("tableIndexSQL=" + tableIndexSQL);
        StringBuilder tSQL = new StringBuilder("select")
                .append(" t.fieldname n ,t.id ,t.detailtable t ,h.labelname h, t.fielddbtype d")
                .append(" , ").append(tableIndexSQL).append(" ti")
                .append(" from")
                .append(" workflow_billfield t")
                .append(",workflow_base w")
                .append(",HtmlLabelInfo h")
                .append(" where w.formid = t.billid and t.fieldlabel = h.indexid and h.languageid = 7")
                .append(" and w.id = '").append(workflowId).append("'")
                .append(" order by ").append(tableIndexSQL).append(" , t.id");
        // log.writeLog("tSQL=" + tSQL.toString());
        rs.executeSql(tSQL.toString());

        int tableIndex = -1;
        String lastTable = null;
        while (rs.next()) {
            String thisTable = Util.null2String(rs.getString("t"));
            String n = Util.null2String(rs.getString("n"));
            String id = Util.null2String(rs.getString("id"));
            String h = Util.null2String(rs.getString("h"));
            String d = Util.null2String(rs.getString("d"));
            if (lastTable == null || !lastTable.equals(thisTable)) {
                tableIndex++;
                if (lastTable != null) {
                    returnJSON.append("};");
                }
                lastTable = thisTable;
                returnJSON.append("var t").append(tableIndex).append("={")
                        .append("_index:").append(tableIndex);
            }
            returnJSON.append(",").append(n)
                    .append(":'field").append(id).append("'");
            // add lablename
            returnJSON.append("/**").append(h).append("-")
                    .append(d).append("**/");
        }
        returnJSON.append("};");
        return returnJSON.toString();
    }
%>
<%
    String imagefilename = "/images/hdReport_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(20536, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
    String workflowid = Util.null2String(request.getParameter("workflowid"));
    // DynamicFieldsUtil fieldsUtil = new DynamicFieldsUtil();
%>
<HTML>
<HEAD>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
    <script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
    <script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
    <link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css"/>
    <link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css"/>
</HEAD>
<BODY scroll="no">
<jsp:include page="/systeminfo/commonTabHead.jsp">
    <jsp:param name="mouldID" value="workflow"/>
    //指定图标id
    <jsp:param name="navName" value="流程字段"/>
    //指定显示的名称
</jsp:include>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage()) + ",javascript:onBtnSearchClick(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="WorkFlowFields.jsp" method=post>
    <wea:layout type="4Col">
        <wea:group context="常用条件">
            <wea:item>流程</wea:item>
            <wea:item>
                <brow:browser name="workflowid" viewType="0" hasBrowser="true" hasAdd="false"
                              browserUrl="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser_frm.jsp?isTemplate=0&iswfec=1"
                              isMustInput="2" isSingle="true" hasInput="true"
                              completeUrl="/data.jsp?type=workflowBrowser&isTemplate=0"
                              width="300px" browserValue="<%=workflowid%>"
                              browserSpanValue="<%=Util.toScreen(WorkflowComInfo.getWorkflowname(workflowid),user.getLanguage())%>"/>
            </wea:item>
        </wea:group>
    </wea:layout>
</FORM>
<%
    if (!"".equals(workflowid)) {
        out.print(getDynamicFields(workflowid));
    }
%>
<script type="text/javascript">
    function onBtnSearchClick () {
        report.submit();
    }
</script>
</BODY>
</HTML>
