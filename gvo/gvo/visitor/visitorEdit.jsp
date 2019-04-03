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
 	String bfz = "";
    String lfrq = "";
    String lfr = "";
	String lfdw = "";
	String lfrs = "";
	String cphm = "";
	String lfsjbn = "";
	String lksjbn = "";
	String zjh = "";
    String fzc = "";
   	RecordSet.executeSql(" select * from formtable_main_124 where id = " + id);
   	if( RecordSet.next() ) {
	    bfz = Util.null2String(RecordSet.getString("bfz"));
	    lfrq = Util.null2String(RecordSet.getString("lfrq"));
	    lfr = Util.null2String(RecordSet.getString("lfr"));
		lfdw = Util.null2String(RecordSet.getString("lfdw"));
		lfrs = Util.null2String(RecordSet.getString("lfrs"));
		cphm = Util.null2String(RecordSet.getString("cphm"));
        zjh = Util.null2String(RecordSet.getString("zjh"));
		fzc = Util.null2String(RecordSet.getString("fzc"));
		lfsjbn = Util.null2String(RecordSet.getString("lfsjbn"));
		lksjbn = Util.null2String(RecordSet.getString("lksjbn"));
	}
	
	String sql = "";
   
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<SCRIPT language="javascript"  defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker.js?rnd="+Math.random()+"'></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "处理来访信息" ;
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

<FORM id=weaver name=weaver style="MARGIN-TOP: 0px" name=right method=post action="PoscoCustomOper.jsp" >
  <input class=inputstyle type="hidden" name="operation" value="edit">
  <input class=inputstyle type="hidden" name="mid" value="<%=id%>">
  
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="35%"><COL width="15%"> <COL width="35%"><TBODY> 
    <TR class=Title
      <TH colSpan=4>来访信息处理</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
      <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>被访者</td>
      <td class=Field>
        <%=ResourceComInfo.getLastname(bfz)%>
      </td>
	  <td>来访日期</td>
      <td class=Field>
        <%=lfrq%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>来访人</td>
      <td class=Field>
        <%=lfr%>
      </td>
	  <td>来访单位</td>
      <td class=Field>
        <%=lfdw%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>来访人数</td>
      <td class=Field>
        <%=lfrs%>
      </td>
	  <td>车牌号码</td>
      <td class=Field>
        <%=cphm%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>证件号</td>
      <td class=Field>
	  <input class=inputstyle id='zjh' name=zjh value="<%=zjh%>" ></td>
	  <td>放置处</td>
      <td class=Field>
	  <input class=inputstyle id='fzc' name=fzc value="<%=fzc%>" ></td>

    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>来访时间</td>
      <td class=Field>
			<button class=Clock onclick="onShowTime('monstarttime1span','monstarttime1')"></button>
			    <span id="monstarttime1span"><%=lfsjbn%></span>
			    <input class=inputstyle type=hidden name="monstarttime1" value="<%=lfsjbn%>">
      </td>
	  <td>离开时间</td>
      <td class=Field>
			<button class=Clock onclick="onShowTime('monstarttime2span','monstarttime2')"></button>
			    <span id="monstarttime2span"><%=lksjbn%></span>
			    <input class=inputstyle type=hidden name="monstarttime2" value="<%=lksjbn%>">
      </td>
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

function doEdit(obj) {

		weaver.submit();
		obj.disabled=true;

}
function doDelete(obj){
	if(confirm("确认删除")) {
		right.operation.value="delete";
		right.submit();
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