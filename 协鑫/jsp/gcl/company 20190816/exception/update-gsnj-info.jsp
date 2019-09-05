<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
    String titlename = "公司年检信息";
    String needfav = "1";
    String needhelp = "";
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSNJJLB");
    String njid = Util.null2String(request.getParameter("njid"));
    String StartDateF = Util.null2String(request.getParameter("StartDateF"));
    SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	String nowyear = sf.format(new Date());
    String sql = "";
    
   
%>
<BODY>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{"+"提交"+",javascript:dosubmit(),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
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
            <COL width="20%">
            <COL width="60%">
            <COL width="20%">

           <!-- <TR class=Title>
                <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
            </TR>-->
            <tr>
                <td></td>
                <td class="fname">年检完成日期</td>
                <td></td>
            </tr>
            
                <tr>
                <td></td>
                <td class=fvalue> 
                <BUTTON type="button" class=calendar id=SelectDate1
                    onclick="gettheDate(StartDateF,StartDateFspan)"></BUTTON>
                <SPAN id=StartDateFspan><%=StartDateF%></SPAN>
                <input type="hidden"id="StartDateF" name="StartDateF" value="<%=StartDateF%>"></td>               
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
    
    function dosubmit(){
        var njid = "<%=njid%>";
        var jbrid ="<%=emp_id%>";
        var wcsj = jQuery("#StartDateF").val();
        if(wcsj == ""){
            alert("请先填写年检完成时间");
            return;
        }else{
            var result = "";
             $.ajax({
                type: "POST",
                url: "/gcl/company/exception/update-njdata.jsp",
                data: {'njid': njid, 'jbr': jbrid, 'njdate': wcsj},
                dataType: "text",
                async: false,//同步   true异步
                success: function (data) {
                    data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                    result = data;
                }
             });
            if(result =="123"){
                window.returnValue='1';
                window.close();
            }
        }
        
    }

   

   
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>