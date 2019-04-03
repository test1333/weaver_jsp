<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String ktext = "";
String xmcbzx = Util.null2String(request.getParameter("xmcbzx"));//
if("".equals(xmcbzx)){
	out.print("");
}
String  sql="select ktext from zv_projectrefCSKT where kostl='"+xmcbzx+"'";
rs.executeSql(sql);
if(rs.next()){
	ktext = Util.null2String(rs.getString("ktext"));
}
out.print(ktext);
%>

