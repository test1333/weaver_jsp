<%@ page import="weaver.general.Util" %>
<%@ page import="htkj.alarm.CreateXunJiaServiceAction" %>
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
	CreateXunJiaServiceAction aa= new CreateXunJiaServiceAction();
    String result =aa.CreateXunJiaService(ids,sqr);
	out.print(ids+"sssqr:"+sqr+" result"+result);
%>