<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="gcl.company.CompanyAuthorityUtil" %>
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
    <link rel="stylesheet" type="text/css" href="/css/crmcss/lanlv.css" /></p>
    <script type="text/css">

    </script>
</head>
<%
    int emp_id = user.getUID();
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "地址异常";
    String needfav = "1";
    String needhelp = "";
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSYCXXGL");
    String gsid = Util.null2String(request.getParameter("gsid"));
    String oaxx = "";
    String qccxx = "";
    String sql = "select b.oaxx,b.qccxx from "+tablename+" a,"+tablename+"_dt1 b where a.id=b.mainid and a.gsid='"+gsid+"' and b.lx='2' ";
    rs.execute(sql);
    if(rs.next()){
        oaxx = Util.null2String(rs.getString("oaxx"));
        qccxx = Util.null2String(rs.getString("qccxx"));
    }
    CompanyAuthorityUtil cau = new CompanyAuthorityUtil();
    String ryid = emp_id+"";
    String bjyjlbids = "";
    if(!"1".equals(ryid)){
        bjyjlbids = cau.getEditDataLbId(ryid);
    }
    String tablenameGs = du.getBillTableName("GSGLXXK");
    String yjlb = "";
    sql = "select yjlb from "+tablenameGs+" where id="+gsid;
    rs.execute(sql);
    if(rs.next()){
        yjlb = Util.null2String(rs.getString("yjlb"));
    }
    String canupdate = "0";
    if("1".equals(ryid) || bjyjlbids.indexOf(yjlb)>=0){
        canupdate = "1";
    }
   
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    if("1".equals(canupdate)){
    RCMenu += "{"+"变更"+",javascript:dochange(),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
    }
    //RCMenu += "{"+"导出Excel"+",javascript:_xtable_getAllExcel(),_self} " ;
    //RCMenuHeight += RCMenuHeightStep ;
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
                         
    <table class=Viewform id="searchTable" >
        <tbody>
        <COLGROUP>
            <COL width="15%">
            <COL width="35%">
            <COL width="35%">
            <COL width="15%">

           <!-- <TR class=Title>
                <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
            </TR>-->
            <tr>
                <td></td>
                <td class="fname">系统地址</td>
                <td class="fname">企查查地址</td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td class=fvalue><SPAN id=xtdz style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=oaxx%></SPAN></td>
                <td class=fvalue><SPAN id=qccdz style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=qccxx%></SPAN></td>
                <td></td>
            </tr>
            
            
    </table>
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

    function dochange(){
        var gsid = "<%=gsid%>";
        this.openFullWindowForXtable('/gcl/company/change/wui/main.jsp?dataid='+gsid);
    }

   

   
</script>
</BODY>
</HTML>