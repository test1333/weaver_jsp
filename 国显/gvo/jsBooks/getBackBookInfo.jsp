<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String bookID = request.getParameter("id");//图书ID

String bookName = "";//图书名称
String csxz = "";//藏书性质
String tsszd = "";//图书所在地
String tsbh = "";//图书编号
String sslb = "";//所属类别

if(bookID.length()>0){	
	
	String sql = "select tsmc,tsbh,csxz,tsbh,sslb, case tsszd when 0 then '昆山AM' else '昆山PM' end as tsszd from formtable_main_91 where id = "+bookID;
	rs.executeSql(sql);
	if(rs.next()){
		bookName = rs.getString("tsmc");
		csxz = rs.getString("csxz");
		tsszd = rs.getString("tsszd");
		tsbh = rs.getString("tsbh");
   		sslb = rs.getString("sslb");
	}
	json.append("{");
	json.append("bookID:").append("'").append(bookID).append("'").append(",");
	json.append("csxz:").append("'").append(csxz).append("'").append(",");
	json.append("tsszd:").append("'").append(tsszd).append("'").append(",");
	json.append("tsbh:").append("'").append(tsbh).append("'").append(",");
	json.append("sslb:").append("'").append(sslb).append("'").append(",");
// 	json.append("bookID:").append("'").append(bookID).append("'").append(",");
	json.append("bookName:").append("'").append(bookName).append("'");
	json.append("}");
	
	
}
out.println(json.toString());

%>

