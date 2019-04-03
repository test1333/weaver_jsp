<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%

BaseBean log = new BaseBean();
String result = "0";
int count = 0;
String wjbh = Util.null2String(request.getParameter("wjbh"));
String rqid = Util.null2String(request.getParameter("rqid"));
String revision = Util.null2String(request.getParameter("revision"));
String  sql="select count(1) as count from formtable_main_88 where upper(num1)=upper('"+wjbh+"')  and upper(revision)=upper('"+revision+"') and requestid <> '"+rqid+"'";
rs.executeSql(sql);
if(rs.next()){
	count = rs.getInt("count");
}
if(count >0){
	result = "1";
}
out.print(result);
%>

