<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    int count = 0;
    BaseBean log = new BaseBean();
    String GYSMC= request.getParameter("GYSMC");
    String DZXX = request.getParameter("DZXX");
    log.writeLog("gysmc------"+GYSMC+","+DZXX);
    RecordSet rs = new RecordSet();
    String sql = "";
    sql = "select count(1) as count from uf_suppmessForm where GYSMC = '" + GYSMC + "' and " +
            "DZXX = '" + DZXX + "'";
    rs.execute(sql);
    log.writeLog("sql------"+sql);
    if(rs.next()){
        count = rs.getInt("count");
    }
    out.print(count);
%>
