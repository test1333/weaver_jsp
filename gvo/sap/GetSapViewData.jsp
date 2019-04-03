<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.sap.GetSapViewDataAction" %>
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
    String I_MATNR = Util.null2String(request.getParameter("I_MATNR"));
	String I_VIEW = Util.null2String(request.getParameter("I_VIEW"));
	GetSapViewDataAction gsvd= new GetSapViewDataAction();
	//String result =aa.getResult("11","J",qj_id,custom);
	String result =gsvd.getSapData(I_MATNR,I_VIEW);

	out.print(result);
%>