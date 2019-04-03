<%@ page import="weaver.general.Util" %>
<%@ page import="APPDEV.HQ.SAP.DATA.GetSapCompanyInfoAction" %>
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
 
	GetSapCompanyInfoAction gsc = new GetSapCompanyInfoAction();
	gsc.execute();
	out.print("success");
	//String result = gsc.getSapData();
	//out.print(result);
%>