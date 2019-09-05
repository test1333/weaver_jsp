<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.company.exception.SysnQccDataInfo" %>
<%@ page import="gcl.company.exception.SysnQCCDataInfoImpl" %>
<%@ page import="gcl.company.exception.YearCheckUtil" %>
<%@ page import="weaver.general.Util" %>
<%
	//SysnQCCDataInfoImpl sii = new SysnQCCDataInfoImpl();
	//sii.sysnCompanyNameAddressInfo("");
	SysnQccDataInfo ccu = new SysnQccDataInfo();
	ccu.sysnCompanyInfoMasterData();
	//YearCheckUtil ycu = new YearCheckUtil();
	//ycu.insertNjjl();
	out.print("123");
%>