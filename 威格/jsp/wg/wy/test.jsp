<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="wg.bank.PostToBank"%>
<%
PostToBank aa = new PostToBank();
String result = aa.test();
out.print(aa);
%>