<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.displaycenter.GetBOMData" %>
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
    String I_MATNR = Util.null2String(request.getParameter("I_MATNR"));//物料号
	String I_MENGE = Util.null2String(request.getParameter("I_MENGE"));//数量
	String I_WERKS = Util.null2String(request.getParameter("I_WERKS"));//工厂
	GetBOMData gbd= new GetBOMData();
	 String result=gbd.getDetialinfo(I_MATNR,I_MENGE,I_WERKS);

	out.print(result);
%>