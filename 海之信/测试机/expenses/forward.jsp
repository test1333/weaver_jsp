<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
<%@ page import="seahonor.action.custom.EditCustom"%>
<%@ page import="seahonor.action.custom.EditContact"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>	
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String typex = Util.null2String(request.getParameter("typex"));
	String resArr[] = typex.split(",");
	String type="";
	String cs1="";
	String cs2="";
	String cs3="";
    if(resArr.length > 0) {
		type = resArr[0];
	}
		
	if(resArr.length > 1) {
		cs1 = resArr[1];
	}
	
	if(resArr.length > 2) {
		cs2 = resArr[2];
	}
	if(resArr.length > 3) {
		cs3 = resArr[3];
	}
    //个人借款余额
	if("1".equals(type)){
		 response.sendRedirect("/seahonor/expenses/get-person-borrow.jsp?jkr="+cs1+"&bz="+cs2);  
	}
	if("2".equals(type)){
		 response.sendRedirect("/seahonor/expenses/get-person-borrow-yq.jsp?jkr="+cs1+"&bz="+cs2);  
	}
	
%>