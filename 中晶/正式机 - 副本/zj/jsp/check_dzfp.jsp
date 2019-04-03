<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
    String fphm = Util.null2String(request.getParameter("fphm"));
	String requestid = Util.null2String(request.getParameter("requestid"));
	
	String result="";
	String sql="select dbo.check_dzfp('"+fphm+"','"+requestid+"') as result";
	rs.executeSql(sql);
	if(rs.next()){
		result=Util.null2String(rs.getString("result"));
	}
	out.print(result);
%>