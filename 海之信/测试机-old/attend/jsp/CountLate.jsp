<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
    String sql = "";
    String startdate = request.getParameter("startdate");
    String enddate = request.getParameter("enddate");
    //out.print("year_name="+year_name);
    if(!"".equals(startdate)&&!"".equals(enddate)){
        sql = " select * from HrmResource where id not in(select EmployeeName from uf_Exclude_table) and status<5 ";
        rs.executeSql(sql);
        out.println("sql1="+sql);
		while(rs.next()){
			String id = Util.null2String(rs.getString("id"));
            sql = " exec sh_leave_deduction @emp_id = "+id+", @startdate = '"+startdate+"', @enddate = '"+enddate+"' ";
            rs.executeSql(sql);
            out.println("sql2="+sql);
        }

    }
    response.sendRedirect("LeaveDeductionAll_2.jsp");
%>


