<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
    String sql = "";
	//String ids = request.getParameter("id");
	String year_name = request.getParameter("year_name");
	String month_name = request.getParameter("month_name");
    String countDate = request.getParameter("countDate");
    //out.print("countDate="+countDate);
    if(!"".equals(countDate)){
        //获取需要操作的记录
        sql = " select * from uf_deduction_detail where deduDate='"+countDate+"' and isnull(isCount,0)=0 ";
        rs.executeSql(sql);
        //out.println("sql1="+sql);
		while(rs.next()){
			String id = Util.null2String(rs.getString("empid"));
            sql = " exec sh_late_deduction_pro @emp_id = "+id+", @countdate = '"+countDate+"' ";
            rs.executeSql(sql);
            //out.println("sql2="+sql);
        }

    }
    response.sendRedirect("LeaveDeductionEnd.jsp?year_name="+year_name+"&month_name="+month_name+" ");
%>


