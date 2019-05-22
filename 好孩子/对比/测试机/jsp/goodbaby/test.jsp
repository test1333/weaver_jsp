<%@ page import="goodbaby.hr.rz.UpdateName" %>
<%@ page import="weaver.soa.workflow.request.RequestInfo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
	
	RequestInfo requestaaa = new RequestInfo();
	UpdateName updateName = new UpdateName();
	updateName.execute(requestaaa);
	

%>   