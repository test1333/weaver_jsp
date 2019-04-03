<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="APPDEV.HQ.PM.GetOpexFileUrl" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	String IV_PERNR = Util.null2String(request.getParameter("IV_PERNR"));
	String IV_ZOPID = Util.null2String(request.getParameter("IV_ZOPID"));
	GetOpexFileUrl gof = new GetOpexFileUrl();
	String result=gof.getFileUrl(IV_PERNR,IV_ZOPID);
	response.sendRedirect(result);
%>
