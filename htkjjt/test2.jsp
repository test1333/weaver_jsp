<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="htkjjt.pm.webService.notice.CreateService" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%

	CreateService cs = new CreateService();
	cs.doServerForAfter(1);
	out.print("aaaa");
%>
