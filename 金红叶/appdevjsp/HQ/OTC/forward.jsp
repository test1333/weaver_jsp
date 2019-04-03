<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util"%>
<%@ page import="APPDEV.HQ.OTC.OTC_SPL_GETMODE"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>	
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String xc = Util.null2String(request.getParameter("xc"));
	String dqczr = Util.null2String(request.getParameter("dqczr"));
	String rqid = Util.null2String(request.getParameter("rqid"));
	String wfid = Util.null2String(request.getParameter("wfid"));
	String url="";
	OTC_SPL_GETMODE osg = new OTC_SPL_GETMODE();
	url=osg.getModeUrl(xc,rqid,dqczr,wfid);
	response.sendRedirect(url);  
		
		
	

%>