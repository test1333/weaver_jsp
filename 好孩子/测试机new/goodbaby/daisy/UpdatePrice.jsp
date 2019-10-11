<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    String result = "";
    String requestid = request.getParameter("requestid");
    String gys = request.getParameter("gys");
    RecordSet rs = new RecordSet();
    String sql = "";
    sql = " select BJJE from formtable_main_227 where aid = " + requestid + " and GYSBM1 = " + gys;
    rs.execute(sql);
    if(rs.next()){
        result = Util.null2String(rs.getString("BJJE"));
    }
    out.print(result);
%>
