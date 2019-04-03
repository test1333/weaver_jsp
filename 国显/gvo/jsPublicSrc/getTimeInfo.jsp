<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
  StringBuffer json = new StringBuffer();
  String yjjyksrq = request.getParameter("yjjyksrq");//开始日期
  String yjjyjsrq = request.getParameter("yjjyjsrq");//结束日期
  String yjjykssj = request.getParameter("yjjykssj");//开始时间
  String yjjyjssj = request.getParameter("yjjyjssj");//结束时间
  String beginDateTime = yjjyksrq + ' ' + yjjykssj;
  String endDateTime = yjjyjsrq + ' ' + yjjyjssj;
  String zymc = request.getParameter("zymc");
  int x_num = 0;
  if (zymc.length() > 0) {
       String sql = " select * from (select count(*) as z_num from formtable_main_220 where requestid in "
       +" (select requestid from  workflow_requestbase where currentnodetype > 0) and zymc = '"+zymc+"' "+ " and "
       +" ((yjjyksrq||' '||yjjykssj <= '"+beginDateTime+"' and yjjyjsrq||' '||yjjyjssj > '"+beginDateTime+"') "
       +" or (yjjyksrq||' '||yjjykssj > '"+beginDateTime+"' and yjjyksrq||' '||yjjykssj <= '"+endDateTime+"')))x ";
       rs.executeSql(sql);
       //new BaseBean().writeLog("sql---------" + sql);
       if(rs.next()){
          x_num = rs.getInt("z_num");
       }
       json.append("{");
       //json.append("srcID:").append("'").append(srcID).append("'").append(",");
       json.append("x_num:").append("'").append(x_num).append("'");
       json.append("}");
  }
  out.println(json.toString());
%>