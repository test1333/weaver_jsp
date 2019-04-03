<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%
	gvo.emc.RequestFileToLoad rft = new gvo.emc.RequestFileToLoad();
	rft.execute();
	
	gvo.emc.EmcFileLoadJob efl = new gvo.emc.EmcFileLoadJob();
	efl.execute();
	out.print("123123123");
%>
