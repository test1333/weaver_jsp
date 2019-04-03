<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="seahonor.action.custom.wcc.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%

	
	GetWCCImplAction gwi = new GetWCCImplAction();
	gwi.GetWCCContactDataInfo();
	out.print("success");
    
%>