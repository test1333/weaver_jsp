<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util"%>
<%@ page import="APPDEV.HQ.OTC.OTC_SPL_GETMODE"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String xc = Util.null2String(request.getParameter("xc"));
	String rqid = Util.null2String(request.getParameter("rqid"));
	String wfid = Util.null2String(request.getParameter("wfid"));
	String result="";
	OTC_SPL_GETMODE osg = new OTC_SPL_GETMODE();
	result=osg.getItemData(xc,rqid,wfid);
	out.print(result);
		
		
	

%>