<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="APPDEV.HQ.DECODE.EncodeUtil" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />

<%
	BaseBean log= new BaseBean();
	log.writeLog("kaishiceshi");
    String oldvalue = request.getParameter("oldvalue");
	String type= request.getParameter("type");
	 EncodeUtil rda = new EncodeUtil();
	 String value="";
	 if("0".equals(type)){
		 value= rda.decode(oldvalue);
	 }else{
		 value= rda.decodeCLOB(oldvalue);
	 }
	

	out.print(value); 
%>