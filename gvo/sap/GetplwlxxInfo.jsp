<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.sap.GetplwlxxAction" %>
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
    String MATNR = request.getParameter("MATNR");
	String gc = request.getParameter("gc");
	GetplwlxxAction gl= new GetplwlxxAction();
	//String result =aa.getResult("11","J",qj_id,custom);
	String result =gl.getDetialinfo(MATNR,gc);

	out.print(result);
%>