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
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
    String checkids = Util.null2String(request.getParameter("checkids"));
	 

	 StringBuffer sb = new StringBuffer();
	 String sql="select id,WLBM,WLMC from uf_inquiryForm where id in("+checkids+")";
    //out.print(sql);
	rs.executeSql(sql);
	while(rs.next()){
         
		sb.append(Util.null2String(rs.getString("id")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("WLMC")));	
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>