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
    String bzid = request.getParameter("bz");
	 StringBuffer sb = new StringBuffer();
	 
	 String id="";
	 String jkr = "";
	 String lastname = "";
	 String bz = "";
	 String jkye = "";
	 String jkrq = "";
	 String yqts = "";
	 String jksm = "";
	 String sql="";
	 if("0".equals(bzid)){
		 sql="select id,jkr,(select lastname from hrmresource where id=jkr) as lastname,bz,jkye,jkrq,yqts,jksm from uf_personal_borrow where ISNULL(jkye,0)>0 and sfyq='0' and bz='0' ";
	 }else{
		 sql="select id,jkr,(select lastname from hrmresource where id=jkr) as lastname,bz,jkye,jkrq,yqts,jksm from uf_personal_borrow where ISNULL(jkye,0)>0 and sfyq='0' and bz<>'0' ";
	 }
	 
	 sql +=" order by jkr asc,id desc";
    rs.executeSql(sql);
	while(rs.next()){
         id = Util.null2String(rs.getString("id"));
		 jkr = Util.null2String(rs.getString("jkr"));
		 lastname = Util.null2String(rs.getString("lastname"));
		 bz = Util.null2String(rs.getString("bz"));
		 jkye = Util.null2String(rs.getString("jkye"));
		 jkrq = Util.null2String(rs.getString("jkrq"));
		 yqts = Util.null2String(rs.getString("yqts"));
		 jksm = Util.null2String(rs.getString("jksm"));
		  
		sb.append(id);
		sb.append("###");
		sb.append(jkr);	
		sb.append("###");
		sb.append(lastname);
		sb.append("###");
		sb.append(bz);
		sb.append("###");
		sb.append(jkye);
		sb.append("###");
		sb.append(jkrq);
		sb.append("###");
		sb.append(yqts);
		sb.append("###");
		sb.append(jksm);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>