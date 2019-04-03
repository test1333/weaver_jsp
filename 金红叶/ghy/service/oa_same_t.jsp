<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	String emp = request.getParameter("emp"); 
	String startTime = request.getParameter("startTime"); 
	String endTime = request.getParameter("endTime"); 
	int ct = 0;
	String sql = "select count(1) as ct from APROJECT_IN_view  where emp_id = '"+emp
		+"' and ((begindate < '"+startTime+"' and enddate > '"+startTime+"') or "
		+"(begindate > '"+startTime+"' and begindate < '"+endTime+"') or "
		+"(begindate = '"+startTime+"' and enddate = '"+endTime+"'))";
	rs.executeSql(sql);
	if(rs.next()){
		ct = rs.getInt("ct");
	}
	out.print(ct);
%>