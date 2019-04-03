
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
	String pernr_f="";
	String sql="select lc_no,pernr_f from zoat00020 where oa_md5='"+saprequestid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		requestid = Util.null2String(rs.getString("lc_no"));
		pernr_f = Util.null2String(rs.getString("pernr_f"));
	}
	if("".equals(requestid)){
		sql="select lc_no,pernr_f from zoat00030 where oa_md5='"+saprequestid+"'";
		rs.executeSql(sql);
		if(rs.next()){
			requestid = Util.null2String(rs.getString("lc_no"));
			pernr_f = Util.null2String(rs.getString("pernr_f"));
		}
	}
	if("".equals(requestid)){
		response.sendRedirect("/notice/noright.jsp");
		return;
	}else{
		request.getRequestDispatcher("/workflow/request/WorkflowPictureStatusZOA1.jsp?requestid="+requestid+"&pernr_f="+pernr_f).forward(request, response);
		

		//response.sendRedirect("/workflow/request/WorkflowPictureStatus1.jsp?requestid="+requestid);
	}
		
%>

