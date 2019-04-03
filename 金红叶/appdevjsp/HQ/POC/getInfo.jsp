<%@ page import="weaver.general.Util" %>
<%@ page import="APPDEV.HQ.SERVICE.Test" %>
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
    Test aa1 = new Test();
	

		String result = aa1.test3();

	out.print(result);
%>