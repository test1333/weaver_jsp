<%@ page import="weaver.general.Util" %>
<%@ page import="zj.certificate.UpdateCerificateNo" %>
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
 
	  UpdateCerificateNo uc = new UpdateCerificateNo();
	  uc.execute();
	  out.println("success:");
%>