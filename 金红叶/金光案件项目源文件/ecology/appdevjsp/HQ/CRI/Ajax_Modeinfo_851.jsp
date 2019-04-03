<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />


<%
	String opt = Util.null2String(request.getParameter("opt"));  
	String fzcd = Util.null2String(request.getParameter("fzcd")); 
	String jbbh = Util.null2String(request.getParameter("jbbh")); 
	String durrdate = TimeUtil.getCurrentDateString();
	User userpd = HrmUserVarify.checkUser(request,response);
	int subcompanyidhr = userpd.getUserSubCompany1();
	
	int rq = 0;
	String resultdate = "";
	if("getJARQ".equals(opt)){
		if("1".equals(fzcd)){
			rq = 7;
			resultdate = getJARADAYS(durrdate,rq,subcompanyidhr);
		}else{
			rq = 50;
			resultdate = getJARADAYS(durrdate,rq,subcompanyidhr);
		}
		out.print("{\"resultdate\":\""+resultdate+"\"}");
	}else if("optJBBH".equals(opt)){
		rs.executeSql(" select * from uf_hq_cri_noticeoao where dyjbbh = '"+jbbh+"' ");
		if(rs.next()){
			out.print("{\"result\":\"500\"}");
		}else{
			out.print("{\"result\":\"200\"}");
		}
	}
	
%>


<%!
	public String getJARADAYS(String durrdate,int dates,int subcompanyidhr){
		HrmScheduleDiffUtil gzr = new HrmScheduleDiffUtil();
		for(int i=0;i<dates;){
			durrdate = TimeUtil.dateAdd(durrdate,1);
			boolean sfgzr = gzr.getIsWorkday(durrdate,subcompanyidhr,""); 
			if(sfgzr){
				i++;
			}
		}
		return durrdate;
	}
%>