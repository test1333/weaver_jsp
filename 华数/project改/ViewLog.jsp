<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %><%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetL" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="RecordSetShare" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CheckUserRight" class="weaver.systeminfo.systemright.CheckUserRight" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page"/>

<%
String projid = Util.null2String(request.getParameter("projid"));  
String log=Util.null2String(request.getParameter("log"));
boolean isfromtab =  Util.null2String(request.getParameter("isfromtab")).equals("true")?true:false;
 
RecordSetL.executeSql(" select * from projrecordlog where projid="+projid);
/*check right begin*/

String useridcheck=""+user.getUID();

boolean canview=true;
boolean canedit=true;
boolean canviewlog=true;
boolean canmailmerge=true;
boolean canapprove=true; 
 
 
/*check right end*/

if(!canview){
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
%>

<HTML><HEAD>
<%if(isfromtab) {%>
<base target='_blank'/>
<%} %>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%
String imagefilename = "/images/hdReport.gif";
String titlename =  "ÐÞ¸Ä¼ÇÂ¼"; 
String needfav ="1";
String needhelp ="";
%>
<BODY>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
if(!isfromtab){
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:goBack(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%
}
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
	<td ></td>
	<td valign="top">
		<% if(!isfromtab){%> 
		<TABLE class=Shadow>
		<%}else{ %>
		<TABLE width='100%'>
		<%} %>
		<tr>
		<td valign="top">
	  <TABLE class=ListStyle cellspacing=1>
        <COLGROUP>
		<COL width="15%">
  		<COL width="15%">
  		<COL width="15%">
		<COL width="15%">
  		<COL width="20%">
        <TBODY>
	    <TR class=Header>
	      <th><%=SystemEnv.getHtmlLabelName(97,user.getLanguage())%></th>
	      <th><%=SystemEnv.getHtmlLabelName(277,user.getLanguage())%></th>
	      <th><%=SystemEnv.getHtmlLabelName(616,user.getLanguage())%></th>
	      <th>IP Address</th>
	      <th><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></th>
	    </TR>
<TR class=Line><TD colSpan=5></TD></TR>
<%
boolean isLight = false;
int nLogCount=0;
while(RecordSetL.next())
{
	nLogCount++;
		if(isLight)
		{%>	
	<TR CLASS=DataLight>
<%		}else{%>
	<TR CLASS=DataDark>
<%		}%>
          <TD><%=RecordSetL.getString("operatedate")%></TD>
          <TD><%=RecordSetL.getString("operatetime")%></TD>
          <TD>
			<%=Util.toScreen(ResourceComInfo.getResourcename(RecordSetL.getString("operater")),user.getLanguage())%>
		  </TD>
          <TD><%=RecordSetL.getString("clientip")%></TD>
		  <TD>
<%
  %>&nbsp;<%=RecordSetL.getString("logtype") %>  
		  </TD>           
        </TR>
<%
	isLight = !isLight;
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
<SCRIPT language="JavaScript">
function goBack() { 
	window.location.href="/project/ViewCustomer.jsp?CustomerID=<%=projid%>";
}
</SCRIPT>
</BODY>
</HTML>
