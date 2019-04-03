<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="ProjectTaskApprovalDetail" class="weaver.proj.Maint.ProjectTaskApprovalDetail" scope="page"/>
<jsp:useBean id="RequestComInfo" class="weaver.workflow.request.RequestComInfo" scope="page"/>

<%
String crmId = Util.null2String(request.getParameter("CustomerID"));
int viewType = Util.getIntValue(request.getParameter("viewtype"), 0);
boolean isfromtab =  Util.null2String(request.getParameter("isfromtab")).equals("true")?true:false;
String userId = String.valueOf(user.getUID());
String userType = user.getLogintype();

String sql = "" ;

if (rs.getDBType().equals("oracle"))
	sql = " SELECT id, begindate, begintime, resourceid, description, name, status, urgentLevel, createrid, createrType, taskid, crmid, requestid, docid " 
		+ " FROM WorkPlan WHERE id IN ( " 
	    + " SELECT DISTINCT a.id FROM WorkPlan a, WorkPlanShareDetail b "
        + " WHERE a.id = b.workid" 
		+ " AND (CONCAT(CONCAT(',',a.crmid),',')) LIKE '%," + crmId + ",%'"
		+ " AND b.usertype = " + userType + " AND b.userid = " + userId
		+ " AND a.type_n = '3')";
else if (rs.getDBType().equals("db2"))
	sql = " SELECT id, begindate, begintime, resourceid, description, name, status, urgentLevel, createrid, createrType, taskid, crmid, requestid, docid " 
		+ " FROM WorkPlan WHERE id IN ( " 
	    + " SELECT DISTINCT a.id FROM WorkPlan a, WorkPlanShareDetail b "
        + " WHERE a.id = b.workid" 
		+ " AND (CONCAT(CONCAT(',',a.crmid),',')) LIKE '%," + crmId + ",%'"
		+ " AND b.usertype = " + userType + " AND b.userid = " + userId
		+ " AND a.type_n = '3')";
else
	sql = "SELECT id, begindate , begintime, resourceid, description, name, status, urgentLevel, createrid, createrType, taskid, crmid, requestid, docid " 
		+ " FROM WorkPlan WHERE id IN ( " 
	    + " SELECT DISTINCT a.id FROM WorkPlan a,  WorkPlanShareDetail b WHERE a.id = b.workid" 
		+ " AND (',' + a.crmid + ',') LIKE '%," + crmId + ",%'" 
		+ " AND b.usertype = " + userType + " AND b.userid = " + userId
		+ " AND a.type_n = '3')";

if (viewType == 0 ) sql += " ORDER BY begindate DESC, begintime DESC";
if (viewType == 1 ) sql += " ORDER by urgentLevel DESC";
if (viewType == 2 ) sql += " ORDER by resourceid";
rs.executeSql(sql);
%>


<HTML><HEAD>
<%if(isfromtab) {%>
<base target='_blank'/>
<%} %>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%
String imagefilename = "/images/hdReport.gif";
String titlename = SystemEnv.getHtmlLabelName(6082,user.getLanguage())
					+ " - " + SystemEnv.getHtmlLabelName(136,user.getLanguage())
					+ ":&nbsp;<A href='/CRM/data/ViewCustomer.jsp?CustomerID=" + crmId + "'>"
					+ Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(crmId),user.getLanguage())+"</A>";

String needfav ="1";
String needhelp ="";
String currentvalue = "";
%>
<BODY>


<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",javascript:doAdd(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!isfromtab){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:goCustomerCardBack(),_top} " ;
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
		<%if(!isfromtab){ %>
		<TABLE class=Shadow>
		<%}else{ %>
		<TABLE width='100%'>
		<%} %>
		<tr>
		<td valign="top">
  
  <TABLE class="ListStyle">
		<COLGROUP>
		<COL width="5%">
  	<COL width="17%">
		<COL width="7%">
		<COL width="5%">
		<COL width="17%">
		<COL width="12%">
		<COL width="12%">
		<COL width="13%">
		<COL width="12%">

        <TBODY>
	    <TR class=Header>
	      <th style="TEXT-ALIGN: center">���</th>
	      <th style="TEXT-ALIGN: center">��̱�����</th>	      
	      <th style="TEXT-ALIGN: center">��̱����</th>
	      <th style="TEXT-ALIGN: center">��̱�����</th>
	      <th style="TEXT-ALIGN: center">Ŀǰ��Ŀ����</th> 
		    <th style="TEXT-ALIGN: center">״̬</th>
		    <th style="TEXT-ALIGN: center">��ע</th>
		    <th style="TEXT-ALIGN: center">����</th>
	    </TR>
<TR class=Line><TD colSpan=8></TD></TR>
<%
boolean isLight = false;
String m_id = "";
String m_name = "";
String m_beginDate = "";
String m_beginTime = "";
String m_memberIds = "";
String m_createrType = "";
String m_description = "";
String m_urgentLevel = "";
String m_status = "";
while (rs.next()) {
	m_id = Util.null2String(rs.getString("id"));
	m_name = Util.null2String(rs.getString("name"));
	m_beginDate = Util.null2String(rs.getString("begindate"));
	m_beginTime = Util.null2String(rs.getString("begintime"));
	m_memberIds = Util.null2String(rs.getString("resourceid"));
	m_createrType = Util.null2String(rs.getString("createrType"));
	m_urgentLevel = Util.null2String(rs.getString("urgentLevel"));	
	m_description = Util.null2String(rs.getString("description"));
	m_status = Util.null2String(rs.getString("status"));
	String relatedprj = Util.null2String(rs.getString("taskid"));
	String relatedcus = Util.null2String(rs.getString("crmid"));
	String relatedwf = Util.null2String(rs.getString("requestid"));
	String relateddoc = Util.null2String(rs.getString("docid"));
	ArrayList relatedprjList = Util.TokenizerString(relatedprj, ",");
	ArrayList relatedcusList = Util.TokenizerString(relatedcus, ",");
	ArrayList relatedwfList = Util.TokenizerString(relatedwf, ",");
	ArrayList relateddocList = Util.TokenizerString(relateddoc, ",");

	switch (viewType) {
	case 1: if (!currentvalue.equals(m_urgentLevel)) {%><tr class=datadark><%
			switch (Integer.parseInt(m_urgentLevel)) {
			case 1: %><td colspan = 8><span id = contacttypename class ="fontred"><%=SystemEnv.getHtmlLabelName(154,user.getLanguage())%></span></td><% break;
			case 2: %><td colspan = 8><span id = contacttypename class ="fontred"><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%></span></td><% break;
			case 3: %><td colspan = 8><span id = contacttypename class ="fontred"><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%></span></td><% break;			
			default: %><td colspan =8><span id = contacttypename class ="fontred">&nbsp;</span></td><% break;
			}%></tr><%} break;
	default: %><% break;
	}
		if(isLight)
		{%>	
	<TR CLASS=DataLight>
<%		}else{%>
	<TR CLASS=DataDark>
<%		}%>

<%
	if (m_status.equals("0")) {
%>
	      <TD class=fontred><%=SystemEnv.getHtmlLabelName(732,user.getLanguage())%></TD>
<%
	} else if (m_status.equals("1")) {
%>
<TD><%=SystemEnv.getHtmlLabelName(555,user.getLanguage())%></TD>
<%
	} else if (m_status.equals("2")) {	
%>
<TD><%=SystemEnv.getHtmlLabelName(251,user.getLanguage())%></TD>
<%	
	}
%>
<TD><A href="/workplan/data/WorkPlan.jsp?workid=<%=m_id%>"><%=Util.toScreen(m_name,user.getLanguage())%></A></TD>
		 
<%
	switch (Integer.parseInt(m_urgentLevel)) {
	case 1: %><td><%=SystemEnv.getHtmlLabelName(154,user.getLanguage())%></td><% break;
	case 2: %><td><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%></td><% break;
	case 3: %><td><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%></td><% break;
	default: %><td>&nbsp;</td><% break;
	}
%>	      
	 <TD>
<%
	if (!userType.equals("2")) {
		if (m_createrType.equals("1")) {
			if (!m_memberIds.equals("")) {
				ArrayList members = Util.TokenizerString(m_memberIds, ",");
				for (int i = 0; i < members.size(); i++) {
%>
			<A href="/hrm/resource/HrmResource.jsp?id=<%=""+members.get(i)%>">
			<%=ResourceComInfo.getResourcename(""+members.get(i))%></A>&nbsp;
<%
				}
			}
		} else {
			if (!m_memberIds.equals("")) {
				ArrayList members = Util.TokenizerString(m_memberIds, ",");
				for (int i = 0; i < members.size(); i++) {
%>
			<A href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=""+members.get(i)%>">
			<%=CustomerInfoComInfo.getCustomerInfoname(""+members.get(i))%></A>&nbsp;
<%
				}
			}
		}
	} else {
		if (m_createrType.equals("1")) {
			if (!m_memberIds.equals("")) {
				ArrayList members = Util.TokenizerString(m_memberIds, ",");
				for (int i = 0; i < members.size(); i++) {
%>
		<%=ResourceComInfo.getResourcename(""+members.get(i))%>
<%
				}
			}
		} else {
			if (!m_memberIds.equals("")) {
				ArrayList members = Util.TokenizerString(m_memberIds, ",");
				for (int i = 0; i < members.size(); i++) {
%>
			<A href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=""+members.get(i)%>">
			<%=CustomerInfoComInfo.getCustomerInfoname(""+members.get(i))%></A>
<%
				}
			}
		}
	}
%>
	</TD>
	<TD><%=m_beginDate%>&nbsp;&nbsp;<%=m_beginTime%></TD>
    <td>
		<%for(int i=0;i<relateddocList.size();i++){%>
			<a href="/docs/docs/DocDsp.jsp?id=<%=relateddocList.get(i).toString()%>">
			<%=DocComInfo.getDocname(relateddocList.get(i).toString())%><br>
			</a>
		<%}%>
		</td>
    <td>
		<%for(int i=0;i<relatedprjList.size();i++){%>
			<a href="/proj/process/ViewTask.jsp?taskrecordid=<%=relatedprjList.get(i).toString()%>">
			<%=ProjectTaskApprovalDetail.getTaskSuject(relatedprjList.get(i).toString())%><br>
			</a>
		<%}%>
		</td>
    <td>
		<%for(int i=0;i<relatedcusList.size();i++){%>
			<a href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=relatedcusList.get(i).toString()%>">
			<%=CustomerInfoComInfo.getCustomerInfoname(relatedcusList.get(i).toString())%><br>
			</a>
		<%}%>		
		</td>
    <td>
		<%for(int i=0;i<relatedwfList.size();i++){%>
			<a href="/workflow/request/ViewRequest.jsp?requestid=<%=relatedwfList.get(i).toString()%>">
			<%=RequestComInfo.getRequestname(relatedwfList.get(i).toString())%><br>
			</a>
		<%}%>		
		</td>
    </TR>
		<%if(isLight)
				{%>	
			<TR CLASS=DataLight>
		<%		}else{%>
			<TR CLASS=DataDark>
		<%		}%>
		  <TD></TD>
	      <TD colspan=8><%=m_description%></TD>
	    </TR>
	    <TR><TD class=Line colSpan=8></TD></TR>

<%		
	switch (viewType) {
	case 1: currentvalue = m_urgentLevel; break;
	default: %><% break;
	}
	isLight = !isLight;
}
%>
	  </TBODY>
  </TABLE>
		</TD>
		</TR>
		</TABLE>
	</TD>
	<TD></TD>
</TR>
<TR>
	<TD height="10" colspan="3"></TD>
</TR>
</TABLE>
<SCRIPT language="JavaScript"> 
function doAdd() {
	document.location.href = "/project/MilestoneAdd.jsp?add=1&crmid=<%=crmId%>&isfromtab=<%=isfromtab%>";
}

function doSubmit() {
	weaver.action="/CRM/data/ViewContactLog.jsp?CustomerID=<%=crmId%>";
	weaver.submit();
}

function goCustomerCardBack(){
   document.location.href="/CRM/data/ViewCustomer.jsp?CustomerID=<%=crmId%>";
}
</SCRIPT>
</BODY>
</HTML>