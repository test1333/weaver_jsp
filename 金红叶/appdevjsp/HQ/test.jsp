<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="ghy.SendEmailFJ" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	BaseBean log = new BaseBean();
	SendEmailFJ cft = new SendEmailFJ();
	cft.sendEmail();
	out.print("aaaa");
%>
