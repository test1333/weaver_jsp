<%@ page import="weaver.general.Util" %>
<%@ page import="feilida.finance.GetFinanceFI08" %>
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

	  String qj_id = request.getParameter("id");
	String custom = request.getParameter("custom");
	String arr[] = qj_id.split(",");
	StringBuffer sb = new StringBuffer();
	GetFinanceFI08 fi08= new GetFinanceFI08();
	for(int i=0;i<arr.length;i++){
		String result = fi08.getDetialinfo(arr[i],custom);
		sb.append(result);
    }
	out.print(sb.toString());
%>