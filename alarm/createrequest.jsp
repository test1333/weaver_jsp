<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.system.SystemComInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="seahonor.action.purchsse.AutoCreatePurchase" %>
<%@ page import="weaver.general.Util,java.sql.Timestamp" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	
	AutoCreatePurchase grs = new AutoCreatePurchase();
    String result=grs.AutoCreateRequest();
    out.print(result);
	
%>