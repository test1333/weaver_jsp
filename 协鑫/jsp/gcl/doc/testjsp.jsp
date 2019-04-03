<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.TestAction" %>
<%
TestAction ta = new TestAction();
String result = ta.test();
out.print(result);

%>