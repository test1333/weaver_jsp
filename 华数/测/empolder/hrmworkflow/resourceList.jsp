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
String titlename ="基层领导力落点人员列表";
String needfav ="1";
String needhelp ="";

String jcldlld = request.getParameter("jcldlld");
String amorpm = request.getParameter("amorpm");
String year = request.getParameter("year");
	
String sql = "select * from hrmresource where id in (select bpgz from formtable_main_223 where jcldlld = '"+jcldlld+"' and nf = '"+year+"' and aporpm = '"+amorpm+"' )";
// out.println(sql);
sql+=" order by lastname";
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
				  <TD><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></TD>
				  <TD><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></TD>
				  <TD><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></TD>
				  <TD><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></TD>
				  <TD><%=SystemEnv.getHtmlLabelName(421,user.getLanguage())%></TD>
				  <TD><%=SystemEnv.getHtmlLabelName(620,user.getLanguage())%></TD>
                  <TD><%=SystemEnv.getHtmlLabelName(477,user.getLanguage())%></TD>
                </TR>
				<%
				boolean islight=true;
			int total=0;


                while(RecordSet.next()){
					  String userid = Util.null2String(RecordSet.getString("id")) ;
                      String workcode = Util.null2String(RecordSet.getString("workcode")) ;
                      String accounttype = ""+RecordSet.getInt("accounttype");
                      String accounttypename = AccountType.getAccountType(accounttype);
                      String username = Util.null2String(RecordSet.getString("lastname")) ;
					  String subcompanyid1 = Util.null2String(RecordSet.getString("subcompanyid1")) ;
					  String subcompanyid1name = SubCompanyComInfo.getSubCompanyname(subcompanyid1) ;
                      String departmentid = Util.null2String(RecordSet.getString("departmentid")) ;
                      String department = departmentComInfo.getDepartmentname(departmentid) ;
					  String telephone = Util.null2String(RecordSet.getString("telephone")) ;
					  String mobile = Util.null2String(RecordSet.getString("mobile")) ;
					  String email = Util.null2String(RecordSet.getString("email")) ;
                      total++;
                %>
		<tr <%if(islight){%> class=datalight <%} else {%> class=datadark <%}%>>
		<TD noWrap><%=workcode%></TD>
        <TD><A href="resourceDetail.jsp?id=<%=userid%>&year=<%=year %>&amorpm=<%=amorpm %>" target="_blank"><%=username%></A></TD>
<%-- 		<TD><A href="/hrm/company/HrmDepartment.jsp?subcompanyid=<%=subcompanyid1%>"target="_blank"><%=subcompanyid1name%></A></TD> --%>
<%-- 		<TD><A href="/hrm/company/HrmDepartmentDsp.jsp?id=<%=departmentid%>" target="_blank"><%=department%></A></TD> --%>
<TD><%=subcompanyid1name%></TD>
<TD><%=department%></TD>
        <TD noWrap><%=telephone%></TD>
		<TD noWrap><%=mobile%></TD>
        <TD noWrap><%=email%></TD>
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
