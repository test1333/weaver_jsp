<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String isCheck = Util.null2String(request.getParameter("checkid"));//ÅÌµãID
String type = Util.null2String(request.getParameter("type"));

if("0".equals(type)){
String sql = "update uf_checkrecord set checkwriteend = 1 where id = "+isCheck+"";
    rs.executeSql(sql);

String sql2 = "update uf_checkrecord_dt1 set actual = 0 where mainid = '"+isCheck+"' and actual is null";
    rs.executeSql(sql2);
    rs.executeSql("update uf_checkrecord_dt1 set monitornum=actual ");
    rs.executeSql("update uf_goodsinforecord set isshow = null");
    
}else if("1".equals(type)){
	rs.executeSql("update uf_checkrecord set workprocess = 1 where id = "+isCheck+"");
}
   response.sendRedirect("/seahonor/jsp/AssetsCheck.jsp?Checkid="+isCheck+"");

%>


