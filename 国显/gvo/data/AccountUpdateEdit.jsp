<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>	
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<%

 //   if(!HrmUserVarify.checkUserRight("Posco_custom:Edit",user)) {
  //      response.sendRedirect("/notice/noright.jsp") ;
   //     return ;
    //}
   
    String id=Util.fromScreen(request.getParameter("id"),user.getLanguage());
    // message,url_str,mess_name
 	String lastname = "";
    String workcode = "";
    String accounttype = "";
	String subcompanyname = "";
	String departmentname = "";
	String jobtitlename = "";
	String managername = "";
	String loginid = "";
	String account = "";
   	RecordSet.executeSql(" select h.lastname,h.workcode,decode(nvl(h.accounttype,'0'),'1','次帐号','主帐号') as accounttype,hs.subcompanyname,hp.departmentname,hr.lastname as managername,hj.jobtitlename,h.loginid,h.account"
       +" from HrmResource h " 
       +" left join hrmsubcompany hs on(hs.id=h.subcompanyid1) "
       +" left join hrmdepartment hp on(hp.id=h.departmentid) "
       +" left join hrmjobtitles hj on(hj.id=h.jobtitle) " 
       +" left join hrmresource hr on(hr.id=h.managerid) "
       +" where h.id = " + id);

   	if( RecordSet.next() ) {
	    lastname = Util.null2String(RecordSet.getString("lastname"));
	    workcode = Util.null2String(RecordSet.getString("workcode"));
	    accounttype = Util.null2String(RecordSet.getString("accounttype"));
		subcompanyname = Util.null2String(RecordSet.getString("subcompanyname"));
		departmentname = Util.null2String(RecordSet.getString("departmentname"));
		jobtitlename = Util.null2String(RecordSet.getString("jobtitlename"));
        managername = Util.null2String(RecordSet.getString("managername"));
        loginid = Util.null2String(RecordSet.getString("loginid"));
		account = Util.null2String(RecordSet.getString("account"));
	}
	
   
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<SCRIPT language="javascript"  defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker.js?rnd="+Math.random()+"'></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "维护系统信息" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doEdit(this),_TOP} " ;
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

<FORM id=weaver name=weaver style="MARGIN-TOP: 0px" name=right method=post action="AccountUpdate.jsp" >
  <input class=inputstyle type="hidden" name="operation" value="edit">
  <input class=inputstyle type="hidden" name="mid" value="<%=id%>">
  
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="35%"><COL width="15%"> <COL width="35%"><TBODY> 
    <TR class=Title
      <TH colSpan=4>系统信息维护</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
	<TR style="height: 2px"><TD class=Line colSpan=4><font color="red" size="5px">如果填写重复的登录名，其他重复的登录名会被更新成空！</font> </TD></TR> 
	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
	 <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>账号类型</td>
	  <td class=Field><%=accounttype%></td>

	  <td>编号</td>
	  <td class=Field><%=workcode%></td>
    </tr>

      <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
	  <td>姓名</td>
	  <td class=Field><%=lastname%></td>

	  <td>分部</td>
      <td class=Field><%=subcompanyname%></td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
	  <td>部门</td>
      <td class=Field><%=departmentname%></td>
	  
	  <td>直接上级</td>
      <td class=Field><%=managername%></td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
	  <td>岗位</td>
      <td class=Field><%=jobtitlename%></td>

	  <td>登录名</td>
      <td class=Field><%=loginid%></td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
	  <td>域账号</td>
      <td class=Field colSpan=3>
	  <input class=inputstyle id='account' name=account value="<%=account%>" ></td>
   

    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    </TBODY> 
  </TABLE>
</FORM>
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

<SCRIPT language=VBS>
sub onShowMould(tdname,inputename)
	
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&document.all(inputename).value)
	if NOT isempty(id) then
		document.all(tdname).innerHtml = id(1)
		document.all(inputename).value=id(0)
	end if
end sub

sub onShowTime(spanname,inputename)
	returntime = window.showModalDialog("/systeminfo/Clock.jsp",,"dialogHeight:360px;dialogwidth:275px")
	document.all(spanname).innerHtml = returntime
	document.all(inputename).value=returntime
end sub
</script> 
<SCRIPT language="javascript"  src="/js/datetime.js"></script>
<Script language=javascript>	
function doEdit(obj) {
	if(check_form(weaver,"account")){
		weaver.submit();
		obj.disabled=true;
	}
}
</script> 
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>