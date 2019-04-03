<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.PageManagerUtil " %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<% 

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "拓展经理列表";
String needfav ="1";
String needhelp ="";

    //以下得搜索时的变量值
    //层级
    String level = Util.null2String(request.getParameter("level"));
    String name = Util.null2String(request.getParameter("name"));



//     String sql = "select * from hrmManager where id = '6'";
//     recordSet.executeSql(sql);
//     if(recordSet.next()){
//     	out.print(recordSet.getString("memo"));
//     }
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
// if(HrmUserVarify.checkUserRight("FnaLedgerAdd:Add", user)){

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/hrm/ManagerAdd.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
// }
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

<FORM id=weaver name=frmmain action=ManagerList.jsp method=post >
<input class=inputstyle type=hidden name=operation value="add">
	
                         <!--搜索部分-->
                            <TABLE  class ="ViewForm">
                                <TBODY>
                                <colgroup>
                                <col width="15%">
                                <col width="30%">
                                <col width="10%">
                                <col width="15%">
                                <col width="30%">
                                <TR>
                                    <TD>名称</TD>
                                    <TD class="field">
                                        <Input type="text" class="inputstyle" name="name" value="<%=name%>"/>
                                    </TD>
                                </TR>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                </TBODY>
                            </TABLE>

	<TABLE class=ListStyle cellspacing=1>
  <COLGROUP>
  <COL width="40%">
  <COL width="20%">
  <COL width="40%">
  <THEAD>
  <TR class=Header align=left>
    <TH>名称</TH>
    <TH>区域code</TH>
    <TH>描述</TH>
	</TR>
    <TR class=Line><TD colSpan=3></TD></TR> 
<%
int i= 0;
    int y = 0;
    String sql = "select * from hrmManager where isShow = '0' ";
    if(!"".equals(name)){
  	  sql += " and name like '%"+name+"%'";
    }
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
    <TD><A href="ManagerAdd.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("name")%></A></TD>
    <TD><%=rs.getString("code")%></TD>
    <TD><%=rs.getString("description")%></TD>
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
</body>
<SCRIPT language="javascript">
function onSearch(){
        document.frmmain.action="ManagerList.jsp";
		document.frmmain.submit();
}
</script>
</html>