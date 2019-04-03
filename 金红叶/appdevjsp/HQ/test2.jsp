<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="APPDEV.HQ.DOC.UpdateDealPerson" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%

	UpdateDealPerson udp = new UpdateDealPerson();
	udp.execute();
	out.print("aaaa");
%>
