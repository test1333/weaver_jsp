<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.system.SystemComInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="lfjc.AutoRequestService" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.general.Util,java.sql.Timestamp" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	
	AutoRequestService grs = new AutoRequestService();
    String result=grs.getDocId("aa.txt","sssss","6");
     out.print(result);

	
%>