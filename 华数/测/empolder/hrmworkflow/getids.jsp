<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String ids = "";
	 String sql = "select * from temtable order by tem_group asc,id asc";
		 rs.executeSql(sql);
		 while(rs.next()){
			 ids += rs.getString("id")+",";
		 }
new BaseBean().writeLog(">>>>>>>ids>>>>>>>>"+ids);
		json.append("{");
		json.append("'ids':").append("'").append(ids).append("'");
		json.append("}");
		
		out.println(json.toString());
%>

