<%@ page import="weaver.general.Util" %>
<%@ page import="hhgd.sap.GetBudgetAmount" %>
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
    String I_DEPNUM = Util.null2String(request.getParameter("I_DEPNUM"));
	String I_FANUM = Util.null2String(request.getParameter("I_FANUM"));
	String I_PPNUM = Util.null2String(request.getParameter("I_PPNUM"));
	GetBudgetAmount gba= new GetBudgetAmount();
	 String result=gba.getDetialinfo(I_DEPNUM,I_FANUM,I_PPNUM);

	out.print(result);
%>