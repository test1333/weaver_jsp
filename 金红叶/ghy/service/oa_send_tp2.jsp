<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.system.SystemComInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="ghy.service.GhyRequestService" %>
<%@ page import="CHQ.InsertUtil" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.general.Util,java.sql.Timestamp" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
		String requestId = "208";
		weaver.soa.workflow.request.RequestService requestService = 
				new weaver.soa.workflow.request.RequestService();
		
		weaver.workflow.webservices.WorkflowRequestInfo ws = 
				new weaver.workflow.webservices.WorkflowRequestInfo();

		weaver.workflow.webservices.WorkflowRequestLog los[] = ws.getWorkflowRequestLogs();
		
		weaver.soa.workflow.request.Log[] logs = requestService.getRequestLogs(requestId, 1000, 0);
		
		for(int index=0;index<logs.length;index++){
			weaver.soa.workflow.request.Log lo = logs[index];

			out.println("getOptime = " + lo.getOptime() + "<br>");
			out.println("getOperatorid = " + lo.getOperatorid()+ "<br>");
			out.println("getOperator = " + lo.getOperator()+ "<br>");
		}
%>