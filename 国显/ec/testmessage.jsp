<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.mobile.SendMessageService" %>
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
out.print("111");
    SendMessageService aa = new SendMessageService();
	boolean result= aa.sendSMS("111","15261175783","哈哈哈你在哪里呀");

	out.print("success:"+result);
%>