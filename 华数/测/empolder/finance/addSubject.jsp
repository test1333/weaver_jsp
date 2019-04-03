<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<% 
String id=Util.fromScreen(request.getParameter("id"),user.getLanguage());
String name = "" ; //名称
String code = "";  //编码
String remark = "";//备注

if(!"".equals(id)){
	String sql = "select * from subjectDeatil where id = '"+id+"'";
	RecordSet.executeSql(sql);
	if(RecordSet.next()){
		name = RecordSet.getString("name");
		code = RecordSet.getString("code");
		remark =  RecordSet.getString("remark");
	}
}

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "科目维护";
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doEdit(this),_TOP} " ;
RCMenuHeight += RCMenuHeightStep ;
if(!"".equals(id)){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:doDelete(this),_TOP} " ;
	RCMenuHeight += RCMenuHeightStep ;
}

RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/empolder/finance/subjectList.jsp,_self} " ;
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

<FORM id=frmmain  action="subjectOperation.jsp" method=post>
  <input class=inputstyle type="hidden" name="id" value="<%=id%>">
  <input class=inputstyle type="hidden" name="operation">
 
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title> 
      <TH colSpan=2>科目维护</TH>
    </TR>
    <TR class=Spacing> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <tr> 
      <td>名称</td>
      <td class=Field>
        <input class=inputstyle name=name size="30" onchange='checkinput("name","nameimage")' 
        value="<%=name%>">
        <SPAN id=nameimage></SPAN>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr> 
      <td>金蝶科目编码</td>
      <td class=Field>
        <input class=inputstyle name=code size="30" onchange='checkinput("code","codeimage")' 
        value="<%=code%>">
        <SPAN id=codeimage></SPAN>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
        <tr> 
      <td>备注</td>
      <td class=Field>
        <input class=inputstyle name=remark size="30"  value="<%=remark%>">
        <SPAN id=depimage></SPAN>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    </TBODY> 
  </TABLE>
</FORM>
<script>
function doEdit(obj){
        if(check_form(frmmain,"name,code")){
            frmmain.submit();
        }
}
function doDelete(obj){
		if(confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>")) {
			frmmain.operation.value="delete";
			frmmain.submit();
        }
}
</script>
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

</BODY>

</HTML>
