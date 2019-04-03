<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="irf" class="zj.certificate.InsertRequestFKRecord" scope="page" />
<%
 
    String requestids = request.getParameter("requestids");
	requestids = requestids+"0";
	int count =0 ; 
	String sql="select count(1) as count from (select distinct fkfs from v_fukuan_requestFlow where requestid in ("+requestids+")) a";
	rs.executeSql(sql);
	if(rs.next()){
		count = rs.getInt("count");
	}
	if(count >1){
		out.print("0");
	}else{
	irf.insertInfo(requestids);
	out.print("1");
	}
%>