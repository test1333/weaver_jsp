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
			<td><strong>序号</strong></td>
			<td><strong>产品线</strong></td>
			<td><strong>产品版本</strong></td>
			<td><strong>&nbsp;优先级</strong><br/>(高/中/低)</td>
			<td><strong>上线时间</strong></td>
			<td><strong>&nbsp;产品版本目标</strong><br/>（产品特征、上线范围）</td>
			<td><strong>完成时间</strong></td>
			<td><strong>完成情况</strong></td>
			<td><strong>存在的问题及风险</strong></td>
			<td><strong>产品目标及进度变更记录</strong></td>
			<td><strong>&nbsp;产品负责</strong><br/>(产品管理部)</td>
			<td><strong>项目经理</strong></td>
		</tr>
	 	<%
	 	    for(int i=0;i<2;i++){ 
	 	    int flag = 1;
	 	%>
	 	   <tr bgcolor="#FDF6AD">
	 	   		<td colspan="2"><%=i+1 %>、xxxx</td>
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