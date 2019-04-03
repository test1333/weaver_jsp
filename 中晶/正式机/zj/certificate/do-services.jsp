<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="zj.certificate.InsertRequestHBRecord" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
    InsertRequestHBRecord irf = new InsertRequestHBRecord();
    String requestids = request.getParameter("requestids");
	requestids = requestids+"0";
    irf.insertInfo(requestids);
	//out.print(requestids);
	
%>