<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%

BaseBean log = new BaseBean();
String KJKMDM = "";
String fyxmmc = Util.null2String(request.getParameter("fyxmmc"));//申请日期
if("".equals(fyxmmc)){
	out.print("");
}
String  sql="select KJKMDM from uf_fyxmdzb where id="+fyxmmc;
rs.executeSql(sql);
if(rs.next()){
	KJKMDM = Util.null2String(rs.getString("KJKMDM"));
}
out.print(KJKMDM);
%>

