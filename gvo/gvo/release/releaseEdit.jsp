<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>	
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>

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
	String csmc = "";
	String sjfxrq = "";
  //out.println("id= "+id);
   	RecordSet.executeSql(" select f2.sqr,f2.sqrq,f2.dcr1,f2.sqrbm,f2.sqfxrq,f2.sqqrlxfs,f2.sjfxrq,f2.csmc,f1.wpmc,f1.ggxh,f1.dw,f1.sl from formtable_main_234_dt1 f1  left join formtable_main_234 f2 on f1.mainid = f2.id where f2.id= " + id);
	
	 
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
		csmc = Util.null2String(RecordSet.getString("csmc"));
		sjfxrq = Util.null2String(RecordSet.getString("sjfxrq"));
	}
	
	String sql = "";
   
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="/js/weaver_wev8.js"></script>
</head>
<%
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename = "���������Ϣ" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
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
      <TH colSpan=4>������Ϣ����</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=4></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
      <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>������</td>
      <td class=Field>
        <%=ResourceComInfo.getLastname(sqr)%>
      </td>
	  <td>��������</td>
      <td class=Field>
        <%=sqrq%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>�����˲���</td>
      <td class=Field>
        <%=DepartmentComInfo.getDepartmentname(sqrbm)%>
      </td>
	  <td>��������ϵ��ʽ</td>
      <td class=Field>
        <%=sqqrlxfs%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>������</td>
      <td class=Field>
        <%=dcr1%>
      </td>
	  <td>��������</td>
      <td class=Field>
        <%=csmc%>
      </td>
    </tr>

	<TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>��Ʒ����</td>
      <td class=Field>
	    <%=wpmc%>
	  </td>
	  <td>����ͺ�</td>
      <td class=Field>
	    <%=ggxh%>
	  </td>
	 </tr>
	 <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>����</td>
      <td class=Field>
	    <%=sl%>
	  </td>
	  <td>��λ</td>
      <td class=Field>
        <%=dw%>
      </td>
	 </tr>

    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR> 
    <tr> 
      <td>�����������</td>
      <td class=Field>
		<%=sqfxrq%>
      </td>
	  <td>ʵ�ʷ���ʱ��</td>
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
	if(confirm("ȷ��ɾ��")) {
		right.operation.value="delete";
		right.submit();
		obj.disabled=true;
	}
}
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>