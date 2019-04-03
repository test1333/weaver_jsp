<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>	
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<%

    String multiRequestIds = Util.fromScreen(request.getParameter("multiRequestIds"),user.getLanguage());
	
	String sql = "";
	
	boolean isShow = false;
	
	String showStr = "";
	if("YES".equals(multiRequestIds)){
		isShow = true;
		int tmp_in = ext.zmm.validator.DesInterface.init_x();
		
		if(tmp_in ==0){
			showStr = "刷新连接成功，连接正常！";
		}else{
			showStr = "刷新连接错误，错误码：" + tmp_in + ".";
		}
	}
   
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>

</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "连接加密系统" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
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

<FORM id=weaver name=weaver style="MARGIN-TOP: 0px" name=right method=post action="SystemRefresh.jsp" >
  <input type="hidden" name="multiRequestIds" value="">
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="35%"> <COL width="30%"><TBODY> 
    <TR class=Title
      <TH colSpan=4>刷新连接加密系统</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=3></TD></TR> 
    <tr> 
      <td>不要频繁点击</td>
      <td class=Field>
           <button onclick="doDelete(this)">点击刷新</button>
      </td>
    <td></td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
	  <td>连接的结果</td>
      <td class=Field>
        <%=showStr%>
      </td>
          <td></td>
    </tr>

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
<Script language=javascript>

function doDelete(obj){
	if(confirm("确认刷新！")) {
		weaver.multiRequestIds.value = "YES";
		weaver.submit();
		obj.disabled=true;
	}
}
</script>
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
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>