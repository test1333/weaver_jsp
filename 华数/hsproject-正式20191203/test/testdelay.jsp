<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="hsproject.impl.UpdateProjectStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
	UpdateProjectStatus ups = new UpdateProjectStatus();
	ups.execute();
	out.print("123");
%>
