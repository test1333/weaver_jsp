<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String Name = request.getParameter("Name");//Ö¤ÕÂÃû³Æ

int count_cc = 0;
if(Name.length()>0){	
	
	String sql = "select COUNT(id) as count_cc from  uf_badges where Name= '"+Name+"'";
	rs.executeSql(sql);
	if(rs.next()){
		count_cc = rs.getInt("count_cc");
	}
	
}
out.print(count_cc);

%>

