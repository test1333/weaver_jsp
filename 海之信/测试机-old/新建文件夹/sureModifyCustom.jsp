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
	 String gs="";
	 String sql="select id from uf_custom where (case CutomStatus when 1 then 0 when 2 then 1 else CutomStatus end) = "+lx+" and customGroup ="+ssjt;
    rs.executeSql(sql);
	while(rs.next()){
         gs = Util.null2String(rs.getString("id"));
		sb.append(gs);
		sb.append("@@@");
	}

	out.print(dataBuff.toString());
%>