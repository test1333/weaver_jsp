<%@ page import="weaver.general.Util" %>

<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.workflow.webservices.WorkflowRequestInfo" %>
<%@ page import="weaver.workflow.webservices.WorkflowServiceImpl" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
    WorkflowServiceImpl ws = new WorkflowServiceImpl();
	  WorkflowRequestInfo wri = new WorkflowRequestInfo();
	  String result=ws.submitWorkflowRequest(wri, Integer.valueOf("158"), Integer.valueOf("13"), "reject", "自动退回");   
	out.print(result);
%>