<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%
StringBuffer json = new StringBuffer();
String srcID = request.getParameter("id");//资源ID
String srcName = "";//资源名称
if(srcID.length()>0){
String sql = "select * from formtable_main_215 where id = "+srcID;
rs.executeSql(sql);
new BaseBean().writeLog("sql---zymc------" + sql);
if(rs.next()){
srcName = rs.getString("zcmc");
}
json.append("{");
json.append("srcID:").append("'").append(srcID).append("'").append(",");
json.append("srcName:").append("'").append(srcName).append("'");
json.append("}");
}
out.println(json.toString());
%>