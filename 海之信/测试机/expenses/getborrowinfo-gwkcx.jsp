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
    String gwkid = request.getParameter("gwkid");
	 String jkrid = request.getParameter("jkrid");
	 String jklcdh = request.getParameter("jklcdh");

	 StringBuffer sb = new StringBuffer();
	 
	 String id="";
	 String jkje = "";
	 String jkye = "";
	 String sql="select  id,jkje,jkye from uf_personal_borrow where ISNULL(jkye,0)>0  and gwk='"+gwkid+"' and jkr='"+jkrid+"' and xglc='"+jklcdh+"'";

	 
	 sql +=" order by bz asc";
    rs.executeSql(sql);
	while(rs.next()){
         id = Util.null2String(rs.getString("id"));
		 jkje = Util.null2String(rs.getString("jkje"));
		 jkye = Util.null2String(rs.getString("jkye"));
		  
		sb.append(id);
		sb.append("###");
		sb.append(jkje);	
		sb.append("###");
		sb.append(jkye);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>