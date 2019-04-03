<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />

<%
	 StringBuffer sb = new StringBuffer();
	 
	 String jkr = "";
	 String lastname = "";
	 String sql="select distinct jkr,(select lastname from hrmresource where id=jkr) as lastname from uf_personal_borrow where ISNULL(jkye,0)>0 and sfyq='0'";
	 
    rs.executeSql(sql);
	while(rs.next()){
		 jkr = Util.null2String(rs.getString("jkr"));
		 lastname = Util.null2String(rs.getString("lastname"));
		  
		sb.append(jkr);
		sb.append("###");
		sb.append(lastname);	
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>