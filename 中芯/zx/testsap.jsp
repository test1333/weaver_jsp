<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="zx.workflow.AutoclearPaymentJob" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
	
<%
	AutoclearPaymentJob aa = new AutoclearPaymentJob();
	aa.doYbwl("formtable_main_35","3400");
	out.print("123");
%>	