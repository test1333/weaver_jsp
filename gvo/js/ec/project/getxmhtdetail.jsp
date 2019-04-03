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
    String hth = request.getParameter("hth");
	 StringBuffer sb = new StringBuffer();
	 
	 String jd="";
	 String bl="";
	 String je="";
	 String yfje="";
	 String ljbxje="";
	 String id="";
	 String sql="select b.* from uf_projectcontra a ,uf_projectcontra_dt1 b where a.id=b.mainid  and a.id="+hth+" order by b.id asc";
   	 rs.executeSql(sql);
	while(rs.next()){
         jd = Util.null2String(rs.getString("jd"));
		 bl  = Util.null2String(rs.getString("bl"));
		 je = Util.null2String(rs.getString("je"));
		 yfje=Util.null2String(rs.getString("yfje"));
		 ljbxje = Util.null2String(rs.getString("ljbxje"));
		 id = Util.null2String(rs.getString("id"));
		sb.append(jd);
		sb.append("###");
		sb.append(bl);	
		sb.append("###");
		sb.append(je);	
		sb.append("###");
		sb.append(yfje);
		sb.append("###");
		sb.append(ljbxje);
		sb.append("###");
		sb.append(id);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>