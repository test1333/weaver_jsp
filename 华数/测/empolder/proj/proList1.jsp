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
			<td><strong>���</strong></td>
			<td><strong>��Ʒ��</strong></td>
			<td><strong>��Ʒ�汾</strong></td>
			<td><strong>&nbsp;���ȼ�</strong><br/>(��/��/��)</td>
			<td><strong>����ʱ��</strong></td>
			<td><strong>&nbsp;��Ʒ�汾Ŀ��</strong><br/>����Ʒ���������߷�Χ��</td>
			<td><strong>���ʱ��</strong></td>
			<td><strong>������</strong></td>
			<td><strong>���ڵ����⼰����</strong></td>
			<td><strong>��ƷĿ�꼰���ȱ����¼</strong></td>
			<td><strong>&nbsp;��Ʒ����</strong><br/>(��Ʒ����)</td>
			<td><strong>��Ŀ����</strong></td>
		</tr>
	 	<%
	 	    for(int i=0;i<2;i++){ 
	 	    int flag = 1;
	 	%>
	 	   <tr bgcolor="#FDF6AD">
	 	   		<td colspan="2"><%=i+1 %>��xxxx</td>
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