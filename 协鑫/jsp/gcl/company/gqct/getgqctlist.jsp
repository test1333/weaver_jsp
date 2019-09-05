<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.company.CompanyChangeUtil" %>
<%@ page import="weaver.general.Util" %>
<%

	String dataid = Util.null2String(request.getParameter("dataid"));
	CompanyChangeUtil ccu = new CompanyChangeUtil();
	String result = ccu.getGqctString(dataid);
	out.print(result);
%>