<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="tmc.BringMainAndDetailByMain" %>
<%@ page import="ghy.InsertUtil" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	String alermID="N";
	
	ghy.ghyAlarmInfo gai = new ghy.ghyAlarmInfo();
	String alarmInfo= gai.getAlarmInfo(alermID);
	out.println("-----------------test--------------------<br>");
	String str = gai.addAlarmInfo(alarmInfo); 
	out.println("str=" + str+"<br>");
	out.println("---------------------------------AlarmInfo插入成功------------------------------------------------------<br>");
	
%>