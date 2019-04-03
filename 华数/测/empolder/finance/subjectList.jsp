<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="BudgetModuleComInfo" class="weaver.fna.maintenance.BudgetModuleComInfo" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
String id = Util.null2String(request.getParameter("id")) ; 
int msgid = Util.getIntValue(request.getParameter("msgid") , -1) ; 
String showName = Util.null2String(request.getParameter("showName")); ;

String imagefilename = "/images/hdMaintenance.gif" ; 
String titlename = "科目列表(X)" ; 
String needfav = "1" ; 
String needhelp = "" ; 
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(1421,user.getLanguage())+",javascript:onAdd(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onGo(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
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
<TABLE class=Shadow>
<tr>
	<td valign="top">
<FORM id=frmMain action="subjectList.jsp" method=post >
<DIV>
<input class=inputstyle id=fnayear type=hidden value="" name=fnayear>
<input class=inputstyle type="hidden" name="operation">
<input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <TABLE class=ViewForm>
  <TBODY>
  <TR>
      <td width="30%">名称</td>
      <td class=Field width="70%"><input name="showName" value="<%=showName%>"/></td>
    </TR>
  <TR class=Spacing>
    <TD class=Line1 colspan="2"></TD></TR></TBODY></TABLE>
</FORM>
    
	<BR>
<TABLE class=ListStyle cellspacing=1>
  <COLGROUP>
  <COL width="10%">
  <COL width="45%">
  <COL width="45%">
  <THEAD>
  <TR class=Header align=left>
    <TH>序号</TH>
    <TH>名称</TH>
    <TH>备注</TH>
	</TR>
    <TR class=Line><TD colSpan=3></TD></TR> 
<%
int i= 0;
    int y = 0;
    String sql = "select * from subjectDeatil ";
    if(!"".equals(showName)){
  	  sql += " where name like '%"+showName+"%'";
    }
    sql += " order by code asc ";
    	rs.executeSql(sql);
  //  out.println("sql = " + sql);
while(rs.next()) {
	y++;
if(i==0){
		i=1;
%>
<TR class=DataLight>
<%
	}else{
		i=0;
%>
<TR class=DataDark>
<%
}
%>
    <TD><%=rs.getString("code")%></TD>
    <TD><A href="addSubject.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("name")%></A></TD>
    <TD><%=rs.getString("remark")%></TD>
	</TR>
<%}%>
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


<script language=javascript>
 function onEdit(){
	frmMain.operation.value="edityearperiods" ; 
	frmMain.submit() ; 
}
function onDelete() {
		if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
			frmMain.operation.value="deleteyearperiods" ; 
			frmMain.submit() ; 
		}
}
<!--add by wangdongli-->
function onTakeEffect() {
		frmMain.operation.value="takeeffectyearperiods" ; 
		frmMain.submit() ; 
}
function onCloseDown() {
	if(confirm("<%=SystemEnv.getHtmlNoteName(75,user.getLanguage())%>")) {
		frmMain.operation.value="closedownyearperiods" ; 
		frmMain.submit() ; 
	}
}
function onReopenDD() {
	if(confirm("<%=SystemEnv.getHtmlLabelName(18900,user.getLanguage())%>")) {
		frmMain.operation.value="reopenDD" ; 
		frmMain.submit() ; 
	}
}
function onAdd(){
	frmMain.action ="addSubject.jsp" ; 
	frmMain.submit() ; 
}
function onGo(){
//	frmMain.action="subjectList.jsp" ; 
	frmMain.submit() ; 
}
<!--end-->
</script>
 
</BODY></HTML>
