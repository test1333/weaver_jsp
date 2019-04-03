<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="hsproject.impl.SysnPurchaseMoneyAction" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%

	SysnPurchaseMoneyAction pid = new SysnPurchaseMoneyAction();
	 pid.doSysn("3","23","10","","");
	out.print("aaa");
%>
