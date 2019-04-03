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
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page"/>
<%
	String gs = Util.null2String(request.getParameter("gs"));
	String year = Util.null2String(request.getParameter("year")); 
	String month = Util.null2String(request.getParameter("month")); 
	 StringBuffer sb = new StringBuffer();
	 String sql = "";
	 String sql_dt = "";
	 sql="select srlb,nvl(sum(nvl(jhsrje_rmb,0)),0) as jhsrje_rmb,nvl(sum(nvl(jhsrje1_rmb,0)),0) as jhsrje1_rmb,nvl(sum(nvl(jhsrje2_rmb,0)),0) as jhsrje2_rmb,nvl(sum(nvl(jhsrje_rmb,0)),0)+nvl(sum(nvl(jhsrje1_rmb,0)),0)+nvl(sum(nvl(jhsrje2_rmb,0)),0) as hj from uf_zjjh_sk where gs='"+gs+"' and year='"+year+"' and month='"+month+"' group by srlb";
	 rs.executeSql(sql);
	 while(rs.next()){
		sb.append(rs.getString("srlb"));
		sb.append("###");
		sb.append(rs.getString("jhsrje_rmb"));		
		sb.append("###");
		sb.append(rs.getString("jhsrje1_rmb"));
		sb.append("###");
		sb.append(rs.getString("jhsrje2_rmb"));
		sb.append("###");
		sb.append(rs.getString("hj"));
		sb.append("@@@");
	 }
	 
	out.print(sb.toString()); 
%>