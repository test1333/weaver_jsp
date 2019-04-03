<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String bookID = request.getParameter("id");//Í¼ÊéID

String bookName = "";//Í¼ÊéÃû³Æ

if(bookID.length()>0){	
	
	String sql = "select * from formtable_main_91 where id = "+bookID;
	rs.executeSql(sql);
	if(rs.next()){
		bookName = rs.getString("tsmc");
	}
	json.append("{");
	json.append("bookID:").append("'").append(bookID).append("'").append(",");
	json.append("bookName:").append("'").append(bookName).append("'");
	json.append("}");
	
	
}
out.println(json.toString());

%>

