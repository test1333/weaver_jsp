<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
	
<%
	// type,custom,empID
	String typex = Util.null2String(request.getParameter("typex"));
//	String customID = Util.null2String(request.getParameter("customIDx"));
//	String empID = Util.null2String(request.getParameter("empIDx"));
//	String type = Util.null2String(request.getParameter("typex"));
	


	response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=100&formId=-146&type=1&field8140="+typex);  


%>