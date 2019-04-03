<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="APPDEV.HQ.SAPOAInterface.Action.AgainRunAction" %>
<%@ page import="weaver.conn.RecordSet" %>
	<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
AgainRunAction  sr= new AgainRunAction();
 sr.doService();
 out.print("success");
%>