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
    String jkrid = request.getParameter("jkrid");
	String bz_1 = request.getParameter("bz1");

	 StringBuffer sb = new StringBuffer();
	 
	 String bz="";
	 String jkye = "";
	  String sql="";
	if("0".equals(bz_1)){
	 sql="select bz,SUM(jkye) as jkye from uf_personal_borrow  where jkr='"+jkrid+"' and bz='0' and ISNULL(jkye,0)>0 group by bz ";
	}else{
		  sql="select bz,SUM(jkye) as jkye from uf_personal_borrow  where jkr='"+jkrid+"' and bz <>'0' and ISNULL(jkye,0)>0 group by bz ";
	}
    rs.executeSql(sql);
	while(rs.next()){
         bz = Util.null2String(rs.getString("bz"));
		 jkye = Util.null2String(rs.getString("jkye"));
		
		  
		sb.append(bz);
		sb.append("###");
		sb.append(jkye);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>