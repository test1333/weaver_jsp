<%@ page import="weaver.general.Util" %>

<%@ page import="hsproject.impl.UpdateProcessStatus" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
	
<%
	
     String type = Util.null2String(request.getParameter("type"));//提交类型
	 String processid = Util.null2String(request.getParameter("processid"));
	 String updatetype = Util.null2String(request.getParameter("updatetype"));
	 String result = "";
	 UpdateProcessStatus ups = new UpdateProcessStatus();
	 if("check".equals(type)){
		 result = ups.checkCanUpdate(processid);
	 }else if("update".equals(type)){
		 result = ups.updateProcessStatus(processid,updatetype);
	 }


	 out.print(result);
%>	