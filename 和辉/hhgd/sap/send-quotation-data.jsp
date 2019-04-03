<%@ page import="weaver.general.Util" %>
<%@ page import="hhgd.sap.SendQuotationToSAP" %>
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
    String dtids = Util.null2String(request.getParameter("dtids"));
	SendQuotationToSAP gbd= new SendQuotationToSAP();
	 String result=gbd.getDetialinfo(dtids);

	out.print(result);
%>