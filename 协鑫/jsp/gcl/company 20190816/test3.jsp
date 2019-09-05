<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="gcl.company.exception.SendExceptionRemindEmail" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
	SendExceptionRemindEmail usu = new SendExceptionRemindEmail();
	usu.execute();
	out.print("result:123");
%>