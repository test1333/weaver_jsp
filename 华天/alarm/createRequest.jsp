<%@ page import="weaver.general.Util" %>
<%@ page import="htkj.alarm.CreateAlarmServiceAction" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
    String ids = request.getParameter("id");
	String sqr = request.getParameter("sqr");
	CreateAlarmServiceAction aa= new CreateAlarmServiceAction();
    aa.CreateAlarmService(ids,sqr);
	out.print(ids+"sqr:"+sqr);
%>