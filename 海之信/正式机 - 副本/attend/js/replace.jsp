<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
  StringBuffer json = new StringBuffer();
  String ids[] = request.getParameter("arrengedStaff").split(",");//安排人员
  //String arrengedStaff = request.getParameter("arrengedStaff");
  String startDate = request.getParameter("startDate");//开始日期
  String endDate = request.getParameter("endDate");//结束日期
  int v_num = 0;
  int tmp_v_num = 0;
  for(int i=0;i<ids.length;i++){
      String empid = ids[i].toString();
      if (!"".equals(empid)) {
          String sql = " select count(*) as z_num from formtable_main_2 where "
          +" ((AttendanceStartDate < '"+ startDate+ "' and AttendanceEndDate > '"+ startDate+ "') "
          +" or  (AttendanceEndDate > '"+ startDate+ "' and AttendanceStartDate < '" + endDate + "')) "
          +" and (','+cast(ArrangedStaff as varchar(7998))+',') like '%,"+empid+",%' ";
      rs.executeSql(sql);
      //log.writeLog("log.sql---------" + sql);
      while(rs.next()) {
        tmp_v_num = rs.getInt("z_num");
        v_num += tmp_v_num;
      }
    }
  }
    json.append("{");
    json.append("v_num:").append("'").append(v_num).append("'");
    json.append("}");
    out.println(json.toString());
%>