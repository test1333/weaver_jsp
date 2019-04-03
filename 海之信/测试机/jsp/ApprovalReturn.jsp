<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String checkid = request.getParameter("checkid");//idֵ

	String sql_return =" update uf_checkrecord set approve = '',checkwriteend = ''  where id in ("+checkid+")";
    rs.executeSql(sql_return);
        rs.executeSql("update uf_goodsinforecord set isshow = 1");

   response.sendRedirect("/seahonor/jsp/AssetsCheck.jsp?Checkid="+checkid+"");

%>

