<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String bookID = Util.null2String(request.getParameter("id"));//Í¼ÊéID 

String flag_x = "0";
if(bookID.length()>0){	
	
	String sql = "select count(*) from formtable_main_91 where tszt=2 and id=" + bookID;
    int num_cc = 0;
	rs.executeSql(sql);
	if(rs.next()){
		num_cc = rs.getInt("num_cc");
	}
	
	if(num_cc>0) flag_x = "1";
	
	sql = "select count(*) as num_cc from formtable_main_125 where guihuantushu=" + bookID + " and requestid  in  "
			   +" (select requestid from workflow_requestbase where currentnodetype in(1,2) and workflowid=323 )";
	rs.executeSql(sql);
	if(rs.next()){
		num_cc = rs.getInt("num_cc");
	}
	
	if(num_cc>0) flag_x = "2";
	
	json.append(flag_x);

}
out.println(json.toString());

%>

