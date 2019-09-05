<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<html>
<head>
    <script type="text/javascript" src="/js/weaver.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/Weaver.css">
    <link rel="stylesheet" type="text/css" href="/gcl/company/style/company.css"> 
    <script type="text/css">

    </script>
</head>
<%
    int emp_id = user.getUID();
   
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
    int perpage = 10;
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "对外投资";
    String needfav = "1";
    String needhelp = "";
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSGLXXK");
    String tablenameDJG = du.getBillTableName("DJG");
    String formid = "";
    String modeid = "";
    String sql = "select id from workflow_bill where tablename='" + tablename + "'";
    rs.executeSql(sql);
    if (rs.next()) {
        formid = Util.null2String(rs.getString("id"));
    }
    sql = "select id from modeinfo where  formid=" + formid;
    rs.executeSql(sql);
    if (rs.next()) {
        modeid = Util.null2String(rs.getString("id"));
    }
    String ishide="";
    String gsid = Util.null2String(request.getParameter("gsid"));
   
   
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
   
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
        <col width="10">
        <col width="">
        <col width="10">
</colgroup>
        <tr>
            <td height="10" colspan="3"></td>
        </tr>
        <tr>
            <td></td>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                         
<FORM id=weaver name=weaver action="company-tzfy.jsp" method=post >
    <input type="hidden" name="gsid" id="gsid" value="<%=gsid%>" />
   
</FORM>

                <%
                    String backfields = " b.id,a.id as tzfid,a.gsmc,a.fddbr,(select xm from "+tablenameDJG+" where id=a.fddbr) as dffbrname,a.zczbwy,to_char(b.tzbl)||'%' as tzbl,a.zcrq,(select c.selectname from workflow_billfield t, workflow_bill b,workflow_selectitem c where t.billid=b.id and c.fieldid=t.id  and b.tablename='"+tablename+"' and t.fieldname='gszt' and c.selectvalue=a.gszt) as gszt ";
                        String fromSql = " from "+tablename+" a,"+tablename+"_dt1 b ";
                    String sqlWhere = " a.id=b.mainid  and b.tzf ='"+gsid+"' ";
                   
                    //out.println("select "+ backfields + fromSql + " where " + sqlWhere);
                
                    String orderby = " b.id  ";
                    String tableString = "";

                    tableString = " <table  tabletype=\"none\" pagesize=\"" + perpage + "\" >" +
                            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"b.id\" sqlsortway=\"desc\" />" +
                            "			<head>" +
                            " 	<col width=\"25%\" text=\"被投资企业名称\" column=\"gsmc\" orderkey=\"gsmc\" linkvaluecolumn=\"tzfid\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=" + modeid + "&amp;formId=" + formid + "&amp;opentype=0\" target=\"_fullwindow\"/>" +
                            " 	<col width=\"15%\" text=\"法定代表人\" column=\"dffbrname\" orderkey=\"dffbrname\" />" +
                            " 	<col width=\"15%\" text=\"注册资本（万元）\" column=\"zczbwy\" orderkey=\"zczbwy\"  />" +
                            " 	<col width=\"15%\" text=\"出资比例\" column=\"tzbl\" orderkey=\"tzbl\"  />" +
                            " 	<col width=\"15%\" text=\"成立日期\" column=\"zcrq\" orderkey=\"zcrq\"  />" +
                            " 	<col width=\"15%\" text=\"公司状态\" column=\"gszt\" orderkey=\"gszt\"  />" +
                           
 

                            "			</head>" +
                            "</table>";
                    //showExpExcel="true"
                %>
            <div>
                <wea:SplitPageTag tableString="<%=tableString%>" mode="run"  isShowTopInfo="false" isShowBottomInfo="true"/>
            </div>
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
<script type="text/javascript">

    function refresh() {
        window.location.reload();
    }

   

   
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>