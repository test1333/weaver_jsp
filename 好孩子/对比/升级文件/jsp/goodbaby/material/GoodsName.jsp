<%@ page import="weaver.conn.RecordSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String wlmc= request.getParameter("wlmc");
    RecordSet rs = new RecordSet();
    String sql = "";
    int count = 0;
    if(!"".equals(wlmc)){
        sql = "select count(1) as count from uf_materialData_dt1 where WLMC_1 like '%" + wlmc + "%'";
        rs.execute(sql);
        if(rs.next()){
            count=rs.getInt("count");
        }
    }
    out.print(count);
%>
