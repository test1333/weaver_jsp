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
 	String sqr = "";
    String sl = "";
    String sqrq = "";
    String dcr1 = "";
	String sqrbm = "";
	String sqfxrq = "";
	String sqqrlxfs = "";
	String wpmc = "";
	String ggxh = "";
	String dw = "";
	String bz = "";
	String sjfxrq = "";
  //out.println("id= "+id);
   	RecordSet.executeSql(" select f2.sqr,f2.sqrq,f2.dcr1,f2.sqrbm,f2.sqfxrq,f2.sqqrlxfs,f2.sjfxrq,f2.bz,f1.wpmc,f1.ggxh,f1.dw,f1.sl from formtable_main_234_dt1 f1  left join formtable_main_234 f2 on f1.mainid = f2.id where f2.id= " + id);
	
	 
   	if( RecordSet.next() ) {
	    sqr = Util.null2String(RecordSet.getString("sqr"));
	    sqrq = Util.null2String(RecordSet.getString("sqrq"));
	    dcr1 = Util.null2String(RecordSet.getString("dcr1"));
		sqrbm = Util.null2String(RecordSet.getString("sqrbm"));
		sqfxrq = Util.null2String(RecordSet.getString("sqfxrq"));
		sqqrlxfs = Util.null2String(RecordSet.getString("sqqrlxfs"));
        wpmc = Util.null2String(RecordSet.getString("wpmc"));
		ggxh = Util.null2String(RecordSet.getString("ggxh"));
		dw = Util.null2String(RecordSet.getString("dw"));
		sl = Util.null2String(RecordSet.getString("sl"));
		bz = Util.null2String(RecordSet.getString("bz"));
		sjfxrq = Util.null2String(RecordSet.getString("sjfxrq"));
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
String titlename = "处理放行信息" ;
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
      <TH colSpan=4>放行信息处理</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
      <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>申请人</td>
      <td class=Field>
        <%=ResourceComInfo.getLastname(sqr)%>
      </td>
	  <td>申请日期</td>
      <td class=Field>
        <%=sqrq%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>申请人部门</td>
      <td class=Field>
        <%=sqrbm%>
      </td>
	  <td>申请人联系方式</td>
      <td class=Field>
        <%=sqqrlxfs%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>带出人</td>
      <td class=Field>
        <%=dcr1%>
      </td>
	  <td>单位</td>
      <td class=Field>
        <%=dw%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>物品名称</td>
      <td class=Field>
	    <%=wpmc%>
	  </td>
	  <td>规格型号</td>
      <td class=Field>
	    <%=ggxh%>
	  </td>
	 </tr>
	 <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>数量</td>
      <td class=Field>
	    <%=sl%>
	  </td>
	  <td>备注</td>
      <td class=Field>
	    <%=bz%>
	  </td>
	 </tr>

    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>申请放行日期</td>
      <td class=Field>
		<%=sqfxrq%>
      </td>
	  <td>实际放行时间</td>
      <td class=Field>
			<button class=Clock onClick="onShowTime('monstarttime2span','monstarttime2')"></button>
			    <span id="monstarttime2span"><%=sjfxrq%></span>
			    <input class=inputstyle type=hidden name="monstarttime2" value="<%=sjfxrq%>">
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