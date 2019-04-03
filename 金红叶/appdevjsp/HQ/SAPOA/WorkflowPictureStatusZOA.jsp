
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
	int saplan = Util.getIntValue(request.getParameter("lan"),7) ;
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
		response.sendRedirect("/appdevjsp/HQ/SAPOA/noright.jsp?lan="+saplan);
		return;
	}else{
		//request.getSession().setAttribute("weaver_user@bean", User.getUser(Integer.valueOf(pernr_f), 0));
//User user = HrmUserVarify.getUser (request , response);
//int langu=user.getLanguage();
		request.getRequestDispatcher("/appdevjsp/HQ/SAPOA/WorkflowPictureStatusZOA1.jsp?requestid="+requestid+"&pernr_f=11000209&lan="+saplan).forward(request, response);
//user.setLanguage(langu);		

		//response.sendRedirect("/workflow/request/WorkflowPictureStatus1.jsp?requestid="+requestid);
	}
		
%>

