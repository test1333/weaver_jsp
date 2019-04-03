<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
    String empid = request.getParameter("sqr");//ÉêÇëÈË
    String holiday = request.getParameter("holiday");//ÉêÇë¼ÙÆÚ

    String sql = "";
    if (!"".equals(empid)&&!"".equals(holiday)) {
        sql=" select convert(decimal(10,2),dayleft) as  dayleft from holiday_view where applyuser="+empid+" and applyholidays="+holiday+" ";
        rs.executeSql(sql);
        //log.writeLog("log.sql---------" + sql);
        if(rs.next()) {
            String dayleft = Util.null2String(rs.getString("dayleft"));
            out.println(dayleft);
        }
    }
%>