<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="APPDEV.HQ.Contract.OTC.TEMPLATE.WordToPdf" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	WordToPdf aa = new WordToPdf();
	String sourcePath = "/weaver/ecology/appdevjsp/HQ/Contract/OTC/ContractFile/2017AFHCONTACTTEMPLATE-GHY2017SALSE10000005.docx";  
      String destFile = "/weaver/ecology/appdevjsp/HQ/Contract/OTC/ContractFile/2017AFHCONTACTTEMPLATE-GHY2017SALSE10000005-pdf.pdf";  
      int result =aa.office2PDF(sourcePath,destFile);
	  out.print("aa+:"+result);
%>
