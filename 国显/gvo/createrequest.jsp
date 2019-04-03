<%@page import="gvo.book.BookServceDoWorkflow"%>
<%@page import="weaver.general.Util"%>
<%@ page language="java" contentType="text/html; charset=GBK"  pageEncoding="GBK"%>
<%@ include file="/systeminfo/init.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Create Request</title>
</head>
<body>
<%
	String dataformid = Util.null2String(request.getParameter("datafromid"));
	String dataid = Util.null2String(request.getParameter("dataid"));
	String workflowid = Util.null2String(request.getParameter("workflowid"));
	String userid = user.getUID()+"";
	new BaseBean().writeLog("dataformid"+dataformid+"dataid"+dataid+"workflowid"+workflowid);
	///formmode/createrequest.jsp?datafromid=&dataid=&workflowid=
	BookServceDoWorkflow csdw = new BookServceDoWorkflow();
	csdw.setIsdebug(true);
	int requestid = Util.getIntValue(csdw.getRequestId(dataformid, dataid, workflowid, userid));
	if(requestid<0){
		out.println("创建流程出现异常！ "+requestid);
	}else{
		//<A href="javascript:openFullWindowHaveBarForWFList('/workflow/request/ViewRequest.jsp?requestid=483&amp;isovertime=0',483)">内部邮件-袁涛-2011-01-17</A>
		response.sendRedirect("/workflow/request/ViewRequest.jsp?requestid="+requestid+"&isovertime=0");
	}
%>
</body>
</html>
