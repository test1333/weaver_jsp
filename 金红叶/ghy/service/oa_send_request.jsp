<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.system.SystemComInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="ghy.service.updateSapStatus" %>
<%@ page import="CHQ.InsertUtil" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.general.Util,java.sql.Timestamp" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	
	updateSapStatus grs = new updateSapStatus();
	grs.sendSAP();

	
%>