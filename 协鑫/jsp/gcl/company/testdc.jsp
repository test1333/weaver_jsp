<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="gcl.doc.workflow.DeleteCyReq" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>

<%
	DeleteCyReq dcr =  new DeleteCyReq();
	dcr.deleteRq("2178843");
	out.print("123");
%>