<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.sap.GetSupplierBankAccount" %>
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
    String I_LIFNR = Util.null2String(request.getParameter("I_LIFNR"));
	GetSupplierBankAccount gsvd= new GetSupplierBankAccount();
	//String result =aa.getResult("11","J",qj_id,custom);
	String result =gsvd.getDetialinfo(I_LIFNR);

	out.print(result);
%>