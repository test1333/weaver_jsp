<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil"%>
<%@ page import="weaver.workflow.webservices.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

<%
	String opt = Util.null2String(request.getParameter("opt"));  
	String gsmc = Util.null2String(request.getParameter("gsmc"));
	String tydm = Util.null2String(request.getParameter("tydm"));
	String zzdm = Util.null2String(request.getParameter("zzdm"));
	
	String sql = "";
	if("getCheckGCMC".equals(opt)){
		sql = " select * from uf_hq_cri_involcomp where gsmc = '"+gsmc+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			out.print("{\"result\":\"500\"}");
		}else{
			out.print("{\"result\":\"200\"}");
		}
	}else if("getCheckTYDM".equals(opt)){
		sql = " select * from uf_hq_cri_involcomp where zch = '"+tydm+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			out.print("{\"result\":\"500\"}");
		}else{
			out.print("{\"result\":\"200\"}");
		}
	}else if("getCheckZZDM".equals(opt)){
		sql = " select * from uf_hq_cri_involcomp where zzjgdm = '"+zzdm+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			out.print("{\"result\":\"500\"}");
		}else{
			out.print("{\"result\":\"200\"}");
		}
	}
%>

