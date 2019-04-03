<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String wk = Util.null2String(request.getParameter("wk"));
	String name = Util.null2String(request.getParameter("name"));;
	String tmp_cc = "";	
	
	String sql = "select count(id) as count_cc from hrmresource where workcode='"
		+wk+"' and lastname in(select lastname from hrmresource where id="+name+") and status in(0,1,2,3)";
	System.out.println("sql = " + sql);	

	rs.executeSql(sql);
	
	while(rs.next()){
		tmp_cc = rs.getString("count_cc");
	}

	out.print(tmp_cc);
%>
