
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.systeminfo.SystemEnv"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.TimeUtil"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%

	String saprequestid = Util.null2String(request.getParameter("requestid")) ;
    String requestid="";
	String sql="select oa_no from uf_zoa002 where oa_md5='"+saprequestid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		requestid = Util.null2String(rs.getString("oa_no"));
	}
	if("".equals(requestid)){
		response.sendRedirect("/notice/noright.jsp");
		return;
	}else{
		request.getRequestDispatcher("/workflow/request/WorkflowPictureStatus1.jsp?requestid="+requestid).forward(request, response);
		

		//response.sendRedirect("/workflow/request/WorkflowPictureStatus1.jsp?requestid="+requestid);
	}
		
%>

