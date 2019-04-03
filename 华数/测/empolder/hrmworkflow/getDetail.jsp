<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
String id = request.getParameter("id");
new BaseBean().writeLog(">>>>>>>id>>>>>>>>"+id);
StringBuffer json = new StringBuffer();
String requestids = "";
String ldlxm = "";//领导力项目
String xwms = "";//行为描述
String fzbs = "";//分组标识
	 String sql = "select * from temtable where id = '"+id+"'";
		 rs.executeSql(sql);
		 if(rs.next()){
			 ldlxm = rs.getString("name");
			 xwms = rs.getString("description");
			 fzbs = rs.getString("tem_group");
		 }
// new BaseBean().writeLog(">>>>>>>requestids>>>>>>>>"+requestids);
		json.append("{");
		json.append("'ldlxm':").append("'").append(ldlxm).append("'").append(",");
		json.append("'fzbs':").append("'").append(fzbs).append("'").append(",");
		json.append("'xwms':").append("'").append(xwms).append("'");
		json.append("}");
		
		out.println(json.toString());
%>

