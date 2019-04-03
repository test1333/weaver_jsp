<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<table border="1">
		<tr bgcolor="#F6BEAB">
			<td><strong>ÐòºÅ</strong></td>
			<td><strong>²úÆ·Ïß</strong></td>
			<td><strong>²úÆ·°æ±¾</strong></td>
			<td><strong>&nbsp;ÓÅÏÈ¼¶</strong><br/>(¸ß/ÖÐ/µÍ)</td>
			<td><strong>ÉÏÏßÊ±¼ä</strong></td>
			<td><strong>&nbsp;²úÆ·°æ±¾Ä¿±ê</strong><br/>£¨²úÆ·ÌØÕ÷¡¢ÉÏÏß·¶Î§£©</td>
			<td><strong>Íê³ÉÊ±¼ä</strong></td>
			<td><strong>Íê³ÉÇé¿ö</strong></td>
			<td><strong>´æÔÚµÄÎÊÌâ¼°·çÏÕ</strong></td>
			<td><strong>²úÆ·Ä¿±ê¼°½ø¶È±ä¸ü¼ÇÂ¼</strong></td>
			<td><strong>&nbsp;²úÆ·¸ºÔð</strong><br/>(²úÆ·¹ÜÀí²¿)</td>
			<td><strong>ÏîÄ¿¾­Àí</strong></td>
		</tr>
	 	<%
	 	    for(int i=0;i<2;i++){ 
	 	    int flag = 1;
	 	%>
	 	   <tr bgcolor="#FDF6AD">
	 	   		<td colspan="2"><%=i+1 %>¡¢xxxx</td>
	 	   		<td></td><td></td><td></td><td></td><td></td>
	 	   		<td></td><td></td><td></td><td></td><td></td>
	 	   </tr>
	 	   <%
	 	   	for(int j=0;j<2;j++){
	 	    %>
		 	   <tr>
		 	   		<td><%=i+1 %>.<%=flag++ %></td><td></td><td></td><td></td><td></td>
		 	   		<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
		 	   </tr>
	 	   <% }%>
	 		
	 	<%} %>
	</table>
	
	
</body>
</html>