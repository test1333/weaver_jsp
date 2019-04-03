<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="htkj.doc.CreateUtil" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="rsd" class="weaver.conn.RecordSetDataSource" scope="page"/>
<%

	
	CreateUtil gwi = new CreateUtil();
	gwi.updateDocCreateData();
	out.print("success");
     
%>