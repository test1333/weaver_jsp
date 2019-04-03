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
	GetFinanceFI08 fi03= new GetFinanceFI08();
	//String result =aa.getResult("11","J",qj_id,custom);
	String result =fi03.getDetialinfo(qj_id,custom);

	out.print(result);
%>