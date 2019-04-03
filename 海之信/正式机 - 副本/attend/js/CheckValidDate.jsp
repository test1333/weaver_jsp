<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
  //StringBuffer json = new StringBuffer();
  String holidayApp = request.getParameter("holidayApp");//假期ID
  String newDate = request.getParameter("newDate");//新有效期
  String v_num = "";
  String sql = "";
  if (!"".equals(holidayApp)) {
      sql = " select applyuser,applyholidays from uf_holiday_apply where id ="+holidayApp;
      rs.executeSql(sql);
      //log.writeLog("log.sql---------" + sql);
      if(rs.next()) {
        String empid = Util.null2String(rs.getString("applyuser"));
        String holidayType = Util.null2String(rs.getString("applyholidays"));
        if(!"".equals(empid)&&!"".equals(holidayType)){
          sql = " select COUNT(id) as v_num from uf_holiday_apply where applyuser = "+empid+"  and applyholidays="+holidayType+" and enddate='"+newDate+"' ";
          res.executeSql(sql);
          if(res.next()){
            v_num = Util.null2String(res.getString("v_num"));
          }
        }
      }
    }
    //json.append("{");
    //json.append("v_num:").append("'").append(v_num).append("'");
    //json.append("}");
    out.println(v_num);
%>