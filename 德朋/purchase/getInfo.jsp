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
    StringBuffer dataBuff = new StringBuffer();
    String qj_id = request.getParameter("id");
	 String sql="select b.id from uf_orders a,uf_orders_dt1 b where a.id=b.mainid and a.lastversion='1' and a.requestid="+qj_id;
     rs.executeSql(sql);
	 String valid="";
	 String pm = "";
	 String km = "";
	 String bma = "";
     String bm = "";
     String gg = "";
     String dw = "";
     String sl = "";
     String dj = "";
     String je = "";
     String xqrq = "";
     String bz = "";
	 while(rs.next()){
        valid = Util.null2String(rs.getString("id"));
		
		dataBuff.append(valid);
		dataBuff.append("@@@");
	 }
	out.print(dataBuff.toString());
%>