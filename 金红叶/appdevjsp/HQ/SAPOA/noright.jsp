<%@ page import="weaver.general.Util" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<HTML>
<HEAD>
<LINK rel="stylesheet" type="text/css" href="/css/Weaver_wev8.css">
</HEAD>

<%
String imagefilename = "/images/hdNoAccess_wev8.gif";
String titlename ="";
String needfav ="";
String needhelp ="";
int saplan = Util.getIntValue(request.getParameter("lan"),7) ;
String  showvalue="";
if(saplan==7){
	showvalue="流程不存在";
}else{
	showvalue="request is not exists";
}
%>
<BODY>

<div style="width:100%;position:absolute;top:20%;text-align:center;vertical-align:middle;">
	<img src="/images/ecology8/noright_wev8.png" width="162px" height="162px"/>
	<div style="color:rgb(255,187,14);"><%=showvalue%></div>
</div>

</BODY>
</HTML>