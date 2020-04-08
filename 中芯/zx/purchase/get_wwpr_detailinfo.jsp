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
	 
	 String cgz="";
	 String wlz = "";
	 String dw = "";
	 StringBuffer sb = new StringBuffer();
	 String sql="select wlbh,wlms,ywms"+
				" from formtable_main_176_dt1 a where id in("+checkids+") order by id asc";
    //out.print(sql);
	rs.executeSql(sql);
	while(rs.next()){
         
		sb.append(Util.null2String(rs.getString("wlbh")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("wlms")));		
		sb.append("###");
		sb.append(Util.null2String(rs.getString("ywms")));
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>