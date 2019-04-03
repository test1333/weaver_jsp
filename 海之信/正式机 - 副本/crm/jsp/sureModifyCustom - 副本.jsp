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
    String ssjt = request.getParameter("ssjt");
	 String lx = request.getParameter("lx");
	 StringBuffer sb = new StringBuffer();
	 if("".equals(ssjt)||"".equals(lx)){
		 out.print(sb.toString()); 
	 }
	 String gs="";
	 String customName = "";
	 String sql="select id,customName from uf_custom where superid is null and dbo.gs_status(CutomStatus,'"+lx+"')='1' and customGroup ="+ssjt+" order by CutomStatus asc";
    rs.executeSql(sql);
	while(rs.next()){
         gs = Util.null2String(rs.getString("id"));
		 customName = Util.null2String(rs.getString("customName"));
		sb.append(gs);
		sb.append("###");
		sb.append(customName);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>