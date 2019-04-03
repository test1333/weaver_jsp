<%@ page import="weaver.general.Util" %>
<%@ page import="htkj.services.CreateAlarmService" %>
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
    CreateAlarmService aa = new CreateAlarmService();
	JSONObject json = new JSONObject();
		JSONObject header = new JSONObject();
		json.put("HEADER", header);
		header.put("wheresystem" , "1");
		header.put("aramid" , "2");
		header.put("remark" , "3");
		header.put("gxbh" , "4");
		header.put("pc" , "5");
		header.put("lh" , "6");
		header.put("sbbh" , "7");
		header.put("ygxm" , "8");

		String result = aa.createAlarm(json.toString());

	out.print(result);
%>