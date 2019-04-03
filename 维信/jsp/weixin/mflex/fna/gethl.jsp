<%@ page import="weaver.general.Util" %>
<%@ page import="weixin.mflex.fna.UpdateEPARFormInfo" %>
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
	String curreny = request.getParameter("curreny");
	 UpdateEPARFormInfo uei= new UpdateEPARFormInfo();
	 String result=uei.getJDEHL(curreny,"formtable_main_45");
	 out.print(result);

%>