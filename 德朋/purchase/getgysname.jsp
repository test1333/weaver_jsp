<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.BaseBean"%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

	String sql="";
     String qj_id = request.getParameter("id");
	
	
String name="";
	sql="select gyshmch from uf_cgcgbd where id="+qj_id;
	rs.executeSql(sql);
	if(rs.next()){
			name = Util.null2String(rs.getString("gyshmch"));
	}
		
	out.print(name);
%>