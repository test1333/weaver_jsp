<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="hhgd.doc.MoveISODoc" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);

	String oaseccode = request.getParameter("oaseccode");
	String isoseccode = request.getParameter("isoseccode");
//	out.print("oaseccode"+oaseccode+"isoseccode="+isoseccode); 
	MoveISODoc mid = new MoveISODoc();
	String result = mid.getDocList(isoseccode,oaseccode);
		out.print(result); 
%>