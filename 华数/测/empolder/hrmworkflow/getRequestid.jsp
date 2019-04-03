<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String requestid = request.getParameter("requestid");

StringBuffer json = new StringBuffer();
new BaseBean().writeLog(">>>>>>>requestid>>>>>>>>"+requestid);
		json.append("{");
		json.append("'requestid':").append("'").append(requestid).append("'");
		json.append("}");
		
		out.println(json.toString());
%>

