<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.company.exception.YearCheckUtil" %>
<%@ page import="weaver.general.Util" %>
<%
	String njid = Util.null2String(request.getParameter("njid"));
    String jbr = Util.null2String(request.getParameter("jbr"));
    String njdate = Util.null2String(request.getParameter("njdate"));
	YearCheckUtil ycu = new YearCheckUtil();
    ycu.UpdateNjdata(njid,jbr,njdate);

	out.print("123");
%>