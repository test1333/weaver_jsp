<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="RecordSetS" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetC" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page"/>
<%
    String CustomerID = request.getParameter("CustomerID");
boolean isfromtab =  Util.null2String(request.getParameter("isfromtab")).equals("true")?true:false;
/*check right begin*/
RecordSetC.executeProc("CRM_CustomerInfo_SelectByID",CustomerID);
if(RecordSetC.getCounts()<=0)
{
	response.sendRedirect("/base/error/DBError.jsp?type=FindDataVCL");
	return;
}
RecordSetC.first();
String useridcheck=""+user.getUID();
String customerDepartment=""+RecordSetC.getString("department") ;

boolean canview=false;
boolean canedit=false;
boolean canviewlog=false;
boolean canmailmerge=false;
boolean canapprove=false;

//String ViewSql="select * from CrmShareDetail where crmid="+CustomerID+" and usertype=1 and userid="+user.getUID();

//RecordSetV.executeSql(ViewSql);

//if(RecordSetV.next())
//{
//	 canview=true;
//	 canviewlog=true;
//	 canmailmerge=true;
//	 if(RecordSetV.getString("sharelevel").equals("2")){
//		canedit=true;	  
//	 }else if (RecordSetV.getString("sharelevel").equals("3") || RecordSetV.getString("sharelevel").equals("4")){
//		canedit=true;	
//		canapprove=true;		
//	 }
//}

int sharelevel = CrmShareBase.getRightLevelForCRM(""+user.getUID(),CustomerID);
if(sharelevel>0){
     canview=true;
     canviewlog=true;
     canmailmerge=true;
     if(sharelevel==2) canedit=true;
     if(sharelevel==3||sharelevel==4){
         canedit=true;
         canapprove=true;
     }
}

 if( useridcheck.equals(RecordSetC.getString("agent")) ) {
	 canview=true;
	 canedit=true;
	 canviewlog=true;
	 canmailmerge=true;
 }

if(RecordSetC.getInt("status")==7 || RecordSetC.getInt("status")==8){
	canedit=false;
}

if(!canview){
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}

/*check right end*/



   //out.print(CustomerID);
	RecordSet.executeProc("CRM_SellChance_SByCustomerID",CustomerID);

%>
<HTML><HEAD>
<%if(isfromtab) {%>
<base target='_blank'/>
<%} %>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename =SystemEnv.getHtmlLabelName(2227,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>


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
		<% }%>
		<tr>
		<td valign="top">
<%if(canedit){%>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",javascript:domyfun1.click(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON language=VBS class=BtnNew  style="display:none" id=domyfun1  accessKey=N name=button1 onclick="location='/CRM/sellchance/AddSellChance.jsp?isfromtab=<%=isfromtab%>&CustomerID=<%=CustomerID%>'"><U>N</U>-<%=SystemEnv.getHtmlLabelName(82,user.getLanguage())%></BUTTON>
<%}%>
<%
if(!isfromtab){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:domyfun2.click(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
	%>
	<%@ include file="/systeminfo/TopTitle.jsp" %>
	<%
}

%>
 <BUTTON language=VBS class=Btn  style="display:none" id=domyfun2  accessKey=C name=button1 onclick="location='/CRM/data/ViewCustomer.jsp?CustomerID=<%=CustomerID%>'"><U>C</U>-<%=SystemEnv.getHtmlLabelName(1290,user.getLanguage())%></BUTTON>
 </DIV>
<TABLE class=ListStyle cellspacing=1>
  <COLGROUP>
  <COL width="30%">
  <COL width="15%">
  <COL width="15%">
  <COL width="10%">
  <COL width="10%">
  <COL width="10%">
  <COL width="10%">
  
  <TBODY>
  <TR class=Header>
  <th><%=SystemEnv.getHtmlLabelName(344,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(2247,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(2248,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(2249,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(1339,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(2250,user.getLanguage())%></th>
  <th><%=SystemEnv.getHtmlLabelName(15112,user.getLanguage())%></th>
  </tr>
<TR class=Line><TD colSpan=7></TD></TR>
<%
boolean isLight = false;
	while(RecordSet.next())
	{ 
	if(isLight = !isLight)
		{%>	
	<TR CLASS=DataLight>
<%		}else{%>
	<TR CLASS=DataDark>
<%		}%>
	<TD><a href="/CRM/sellchance/ViewSellChance.jsp?id=<%=RecordSet.getString(1)%>&CustomerID=<%=CustomerID%>"><%=Util.toScreen(RecordSet.getString("subject"),user.getLanguage())%></a></TD>


	<TD>
	<%=Util.toScreen(RecordSet.getString("predate"),user.getLanguage())%>
	</TD>
	 <TD>
	<%=Util.toScreen(RecordSet.getString("preyield"),user.getLanguage())%>
	</TD>
	<TD>
	<%=Util.toScreen(RecordSet.getString("probability"),user.getLanguage())%>
	</TD>
	<TD>
	<%=Util.toScreen(RecordSet.getString("createdate"),user.getLanguage())%>
	</TD>   
	<TD>
	<%
		String sellstatusid = Util.null2String(RecordSet.getString("sellstatusid"));

		if (!sellstatusid.equals("")) {
			String sql="select * from CRM_SellStatus where id ="+sellstatusid;
			rs.executeSql(sql);
			rs.next();
	%>
	 
	<%=Util.toScreen(Util.null2String(rs.getString("fullname")),user.getLanguage())%>
	<%}%>
	</TD> 
	<TD>
	<%
	   String  endtatusid =RecordSet.getString("endtatusid");         
	%>
		<%if(endtatusid.equals("0")){%><%=SystemEnv.getHtmlLabelName(1960,user.getLanguage())%><%}%>
		<%if(endtatusid.equals("1")){%><%=SystemEnv.getHtmlLabelName(15242,user.getLanguage())%><%}%>
		<%if(endtatusid.equals("2")){%><%=SystemEnv.getHtmlLabelName(498,user.getLanguage())%><%}%>
	</TD>            
	</TR>
<%
	}
%>
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
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
</BODY>
</HTML>
