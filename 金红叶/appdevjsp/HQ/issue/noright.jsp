<%@ page import="weaver.general.Util" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<HTML>
<HEAD>
<LINK rel="stylesheet" type="text/css" href="/css/Weaver_wev8.css">
</HEAD>

<%
int isovertime= Util.getIntValue(request.getParameter("isovertime"),0) ;
String imagefilename = "/images/hdNoAccess_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(2011,user.getLanguage())+"...";
String needfav ="";
String needhelp ="";
%>
<script language="JavaScript">
<%if(isovertime==1){%>
        window.opener.location.href=window.opener.location.href;
<%}%>
</script>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<div style="width:100%;position:absolute;top:20%;text-align:center;vertical-align:middle;">
	<img src="/images/ecology8/noright_wev8.png" width="162px" height="162px"/>
	<div style="color:rgb(255,187,14);">您没有任务监控权限，如需开通相关权限请联系系统管理员</div>
</div>

</BODY>
</HTML>