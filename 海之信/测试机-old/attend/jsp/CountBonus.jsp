<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />

<%
    String sql = "";
    String startdate = request.getParameter("startdate");
    String enddate = request.getParameter("enddate");
    String year_name = request.getParameter("year_name");
    String month_name = request.getParameter("month_name");
    //out.print("year_name="+year_name);
    if(!"".equals(startdate)&&!"".equals(enddate)){
        sql = " select * from HrmResource where id not in(select EmployeeName from uf_Exclude_table) ";
        rs.executeSql(sql);
        //log.writeLog("sql1="+sql);
		while(rs.next()){
			String id = Util.null2String(rs.getString("id"));
            out.print("id="+id);
            sql = " exec sh_bonus_count @emp_id = "+id+", @startdate = '"+startdate+"', @enddate = '"+enddate+"' ";
            res.executeSql(sql);
            out.print("sql1="+id);
            //log.writeLog("sql1="+sql);
            sql = " exec sh_bonus_report_pro @empid = "+id+", @attend_start_date = '"+startdate+"', @attend_end_date = '"+enddate+"' ";
            res.executeSql(sql);
            out.print("sql2="+id);
            //log.writeLog("sql2="+sql);
            sql = " exec sh_bonus_sum_count @empid = "+id+", @startdate = '"+startdate+"', @enddate = '"+enddate+"' ";
            res.executeSql(sql);
            out.print("sql3="+id);
            //log.writeLog("sql3="+sql);
        }

    }
    response.sendRedirect("/seahonor/attend/jsp/BonusPersonalAll.jsp");
    //response.sendRedirect("BonusPersonalAll.jsp?year_name="+year_name+"&month_name="+month_name+" ");
%>


