<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.ecsysn.Ecsysnorganize" %>
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
out.print("111");
    Ecsysnorganize aa = new Ecsysnorganize();
	aa.operSubCompany();
	aa.operDepartment();
	aa.operjobtitle();

	out.print("success");
%>