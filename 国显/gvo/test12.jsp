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
	 Enumeration enumeration = request.getSession(true).getAttributeNames();   //����enumeration�е� 
	 while(enumeration.hasMoreElements()){   //��ȡsession��ֵ     
		 String name = enumeration.nextElement().toString();   //���ݼ�ֵȡsession�е�ֵ     
		 Object value = request.getSession(true).getAttribute(name);   //��ӡ���     
		 out.println("<B>" + name +  "</B> = " + value + "<br>");       
	 }
%>
</body>
</html>
