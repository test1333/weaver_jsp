<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%

String imagefilename = "/images/hdReport.gif";
String titlename ="基层领导力落点人员详细评分情况";
String needfav ="1";
String needhelp ="";

String userid = request.getParameter("id");
String amorpm = request.getParameter("amorpm");
String year = request.getParameter("year");
	
String sql = "select * from formtable_main_223_dt1 where mainid = (select id from formtable_main_223 where bpgz = '"+userid+"' and nf = '"+year+"' and aporpm = '"+amorpm+"') order by fzbs";
// out.println(sql);
RecordSet.executeSql(sql);
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
// RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onReSearch(),_self} " ;
// RCMenuHeight += RCMenuHeightStep ;

%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<FORM id=report name=report action=OnlineUser.jsp method=post>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
			<TABLE class=ListStyle cellspacing=1>
			  <COL width="10%">
			  <COL width="10%">
			  <COL width="10%">
			  <COL width="10%">
			  <COL width="15%">
			  <COL width="15%">	
              <COL width="20%">
              <TBODY>
			  <TR class=Header>
			  <TD>序号</TD>
				  <TD>领导力项目</TD>
				  <TD>描述</TD>
				  <TD>自评</TD>
				  <TD>上级评</TD>
				  <TD>上上级评</TD>
				  <TD>综合评分</TD>
<%--                   <TD><%=SystemEnv.getHtmlLabelName(477,user.getLanguage())%></TD> --%>
                </TR>
				<%
				boolean islight=true;
			int total=0;


                while(RecordSet.next()){
					  String ldlxm = Util.null2String(RecordSet.getString("ldlxm")) ;
                      String xwms = Util.null2String(RecordSet.getString("xwms")) ;
                      String zp = Util.null2String(RecordSet.getString("zp")) ;
					  String sjpf = Util.null2String(RecordSet.getString("sjpf")) ;
                      String ssjpf = Util.null2String(RecordSet.getString("ssjpf")) ;
					  String zhpf = Util.null2String(RecordSet.getString("zhpf")) ;
                      total++;
                %>
		<tr <%if(islight){%> class=datalight <%} else {%> class=datadark <%}%>>
		<TD><%=total %></TD>
		<TD noWrap><%=ldlxm%></TD>
        <TD noWrap><%=xwms %></TD>
<%-- 		<TD><A href="/hrm/company/HrmDepartment.jsp?subcompanyid=<%=subcompanyid1%>"target="_blank"><%=subcompanyid1name%></A></TD> --%>
<%-- 		<TD><A href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=departmentid%>" target="_blank"><%=department%></A></TD> --%>
<TD><%=zp%></TD>
<TD><%=sjpf%></TD>
        <TD noWrap><%=ssjpf%></TD>
		<TD noWrap><%=zhpf%></TD>
<%--         <TD noWrap><%=email%></TD> --%>
				</TR>
			<%
				islight=!islight;

			}


			%>
			  </TBODY>
			</TABLE>
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
<script language=vbs>


sub onShowDepartment(tdname,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&document.all(inputname).value)
	if NOT isempty(id) then
	        if id(0)<> "" and id(0)<> "0" then
		document.all(tdname).innerHtml = "<A href='/hrm/company/HrmDepartmentDsp.jsp?id="&id(0)&"'>"&id(1)&"</A>"
//		document.all(tdname).innerHtml =id(1)
		document.all(inputname).value=id(0)
		else
		document.all(tdname).innerHtml = ""
		document.all(inputname).value=""
		end if
	end if
end sub

sub onShowSubCompany()
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp?selectedids="&report.subcompanyid1.value)
	if NOT isempty(id) then
	    if id(0)<> "" then
			subcompanyspan.innerHtml = id(1)
			report.subcompanyid1.value=id(0)
			if id(0)<> 0 then
				report.chkSubCompany.style.display=""
				document.all("lblSubCompany").style.display=""
			else
				report.chkSubCompany.style.display="none"
				document.all("lblSubCompany").style.display="none"
			end if
		else
			subcompanyspan.innerHtml = ""
			report.subcompanyid1.value=""
			report.chkSubCompany.style.display="none"
			document.all("lblSubCompany").style.display="none"
		end if
	end if
end sub
</script>
<script>
document.getElementById("total").innerHTML='<%=total%>';
function onReSearch(){
	report.submit();
}
function setCheckbox(chkObj) {
	if(chkObj.checked == true) {
		chkObj.value = 1;
	} else {
		chkObj.value = 0;
	}
}
</script>
</FORM>
</BODY>
</HTML>
