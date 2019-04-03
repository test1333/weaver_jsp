<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<HTML>
<HEAD>
</HEAD>
<%
	String messid = Util.null2String(request.getParameter("messid"));
	String info = Util.null2String(request.getParameter("info"));
	String titlename = "错误提示信息...";
	String needfav ="";
	String needhelp ="";
	
	String message = "";
	if("001".equals(messid)){
		message = "连接对应公司请求错误!";
	}else if("002".equals(messid)){
		message = "连接对应公司请求无效!";
	}else if("003".equals(messid)){
		message = "系统安全错误，请联系系统管理员!";
	}else if("101".equals(messid)){
		message = "系统连接请求错误!";
	}else if("102".equals(messid)){
		message = "系统安全错误，请联系系统管理员!";
	}else if("103".equals(messid)){
		message = "连接系统无此账号或者账号无效!";
	}
%>

<BODY>

<div style="width:100%;position:absolute;top:20%;text-align:center;vertical-align:middle;">
	<img src="/images/ecology8/noright_wev8.png" width="40px" height="40px"/>
	<div style="color:rgb(255,187,14);"><font size="4px"><%=message%></font></div>
</div>

</BODY>
</HTML>