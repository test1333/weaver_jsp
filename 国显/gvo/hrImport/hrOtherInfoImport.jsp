<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>	
<%

    if(!HrmUserVarify.checkUserRight("HrmResourceOtherInfoEdit:Edit",user)) {
        response.sendRedirect("/notice/noright.jsp") ;
        return ;
    }
   
    char flag = Util.getSeparator() ;

	int who_oper = user.getUID();
	
	String message = request.getParameter("mess");
//	if("-1".equals(message)){
		
//	}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
<SCRIPT language="javascript"  defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript"  src="/js/selectDateTime.js"></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker.js?rnd="+Math.random()+"'></script>
</head>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "人员其他信息 : 导入" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

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

<FORM id=frmMain name=frmMain action="fest_exec.jsp" method=post enctype="multipart/form-data" target="subframe" onsubmit="return Chk();">
      <input class=inputstyle type="hidden" name="who_oper" value="<%=who_oper%>">
      	  
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title
      <TH colSpan=2>人员信息导入维护</TH>
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=2></TD></TR> 
      <tr> 
      <td>操作人 </td> 
      	<td class=Field> <%=ResourceComInfo.getLastname(""+who_oper)%>
      </td>
    </tr>
      <TR style="height: 2px"><TD class=Line colSpan=2></TD></TR> 
	<tr class=spacing> 
      <td>Excel文件</td>
      <td class=Field>
        <input class=inputstyle style="width: 360px" type="file" name="excelfile" onchange='checkinput("excelfile","excelfilespan");this.value=trim(this.value)'><SPAN id=excelfilespan>
               <IMG src="/images/BacoError.gif" align=absMiddle>
              </SPAN>
      </td>
    </tr>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
    <tr><TD></TD><td ><input type="submit" value="导入数据"/></td></tr> 
    <TR style="height: 1px"><TD class=Line colSpan=2></TD></TR> 
      <tr> 
      <td>请点击右键用“目标另存为”下载</td>
      <td><a href='/gvo/hrImport/hrOtherInfoImport.xls'>导入数据Excel模板 </a>&nbsp;</td>
    </tr> 
    <tr class=spacing><td colspan="2" height="8px"></td></tr>
    <TR style="height:2px"><TD class=Line1 colSpan=2></TD></TR>
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
	  
	function Chk(){
		
		if(document.frmMain.excelfile.value==""){
			alert("文件不能为空！");
			return false;
		}

	}

</script>


</BODY>
</HTML>