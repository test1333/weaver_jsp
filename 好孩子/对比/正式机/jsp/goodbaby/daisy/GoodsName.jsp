<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    String result = "";
    String wlmc= request.getParameter("wlmc");
    String gg = request.getParameter("gg");
    String pp = request.getParameter("pp");
    String xh = request.getParameter("xh");
    RecordSet rs = new RecordSet();
    String sql = "";
    if(!"".equals(wlmc)){
        sql = "select WLMC from formtable_main_216 where WLMC like '%" + wlmc + "%' and " +
                "PP = '" +pp+"' and XH = '" + xh + "' and GG = '" + gg + "'";
        rs.execute(sql);
        JSONArray jsonArray = new JSONArray();
        while (rs.next()) {
            try {
                JSONObject jsonObject = new JSONObject();
                String wpmc = Util.null2String(rs.getString("WLMC"));
                jsonObject.put("wpmc", wpmc);
                jsonArray.put(jsonObject);
            } catch (Exception e) {
                e.getMessage();
            }
        }
        result = jsonArray.toString();
    } else {
        result = "";
    }
    out.print(result);
%>
