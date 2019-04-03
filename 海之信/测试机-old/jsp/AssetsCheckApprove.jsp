<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String isCheck = Util.null2String(request.getParameter("checkid"));//ÅÌµãID


String sql = "update uf_checkrecord set workprocess=3,status=1 where id = "+isCheck+"";
    rs.executeSql(sql);

    response.sendRedirect("/seahonor/jsp/AssetsCheck.jsp?Checkid="+isCheck+"");

%>

