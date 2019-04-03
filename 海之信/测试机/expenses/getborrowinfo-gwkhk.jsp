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
	 StringBuffer sb = new StringBuffer();
	 
	 String sjly="";
	 String bz = "";
	 String jkye = "";
	 String sjskr = "";
	 String jksm = "";
	 String sql_dt="";
	 String xglc="";
	 String requestname="";
	 String id="";
	 String sql="select id,'1' as sjly,bz,jkye,sjskr,jksm,xglc,(select requestname from workflow_requestbase where requestid=xglc) as requestname from uf_personal_borrow where ISNULL(jkye,0)>0  and gwk='"+gwkid+"'";

	 
	 sql +=" order by bz asc";
    rs.executeSql(sql);
	while(rs.next()){
         sjly = Util.null2String(rs.getString("sjly"));
		 bz = Util.null2String(rs.getString("bz"));
		 jkye = Util.null2String(rs.getString("jkye"));
		 sjskr = Util.null2String(rs.getString("sjskr"));
		 jksm = Util.null2String(rs.getString("jksm"));
		 xglc = Util.null2String(rs.getString("xglc"));
		 requestname = Util.null2String(rs.getString("requestname"));
		 id = Util.null2String(rs.getString("id"));
		  
		sb.append(sjly);
		sb.append("###");
		sb.append(bz);	
		sb.append("###");
		sb.append(jkye);
		sb.append("###");
		sb.append(sjskr);	
		sb.append("###");
		sb.append(jksm);
		sb.append("###");
		sb.append(xglc);
		sb.append("###");
		sb.append(requestname);
		sb.append("###");
		sb.append(id);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>