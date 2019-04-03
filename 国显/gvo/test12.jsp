<%@page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=GBK"  pageEncoding="GBK"%>
<%@ include file="/systeminfo/init.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Create Request</title>
</head>
<body>
<%
	 Enumeration enumeration = request.getSession(true).getAttributeNames();   //遍历enumeration中的 
	 while(enumeration.hasMoreElements()){   //获取session键值     
		 String name = enumeration.nextElement().toString();   //根据键值取session中的值     
		 Object value = request.getSession(true).getAttribute(name);   //打印结果     
		 out.println("<B>" + name +  "</B> = " + value + "<br>");       
	 }
%>
</body>
</html>
