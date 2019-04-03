<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>


<html>
<head>
<script type="text/javascript" src="/js/weaver.js"></script>
<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>

<%

String department = Util.null2String(request.getParameter("dept"));

int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 20;

String imagefilename = "/images/hdDOC.gif";
String titlename = "提示页面";
String needfav ="1";
String needhelp ="";
%>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.SearchForm.submit(),_top} " ;
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

<FORM id=weaver NAME=SearchForm STYLE="margin-bottom:0" action="" method="post">
<input type=hidden name=operation>


<table width=100% class=ViewForm>
<colgroup>
<col width="8%"/>
<col width="12%"/><col width="1%"/>
<col width="8%"/>
<col width="12%"/><col width="1%"/>
<col width="8%"/>
<col width="12%"/><col width="1%"/>
<col width="8%"/>
<col width="12%"/>
</colgroup>
<tr>
	<td class="field">
	</td>
	<td>
			<%
			String message = request.getParameter("mess");
			if("-1".equals(message)){
		%>
			<h3>成功</h3>
		<%}else if("0".equals(message)){%>
			<h3>失败：工资项信息未找到</h3>
		<%}else{%>
			<h3>失败：xxxx</h3>
		<%}%>
	</td>
	<td><a href="javascript:window.opener=null;window.open('','_self');window.close();"><h4>关闭</h4></a>
</td>
</tr>
<tr style="height:1px;"><td class=Line colspan=11></td></tr>
</table>


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

</BODY>
</HTML>
