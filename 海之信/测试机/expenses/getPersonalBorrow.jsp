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
	 StringBuffer sb = new StringBuffer();
	 
	 String bz="";
	 String jkye = "";
	 String yqje = "";
	 String jkyespan = "";
	 String yqjespan = "";
	 String sql_dt="";
	 String sql="select bz,SUM(ISNULL(jkye,0)) as jkye,SUM(ISNULL(yqje,0)) as yqje,convert(varchar, convert(money,SUM(ISNULL(jkye,0))), 1) as jkyespan,convert(varchar, convert(money,SUM(ISNULL(yqje,0))), 1) as yqjespan   from (select t.id,t.bz,t.jkye,isnull((select jkye from uf_personal_borrow where sfyq='0' and id=t.id),0) as yqje from uf_personal_borrow t where t.jkr="+jkrid+" and ISNULL(t.jkye,0)>0 ) a group by bz";

	 
	 sql +=" order by bz asc";
    rs.executeSql(sql);
	while(rs.next()){
         bz = Util.null2String(rs.getString("bz"));
		 jkye = Util.null2String(rs.getString("jkye"));
		 yqje = Util.null2String(rs.getString("yqje"));
		 jkyespan = Util.null2String(rs.getString("jkyespan"));
		 yqjespan = Util.null2String(rs.getString("yqjespan"));
		  
		sb.append(bz);
		sb.append("###");
		sb.append(jkye);	
		sb.append("###");
		sb.append(jkyespan);
		sb.append("###");
		sb.append(yqje);	
		sb.append("###");
		sb.append(yqjespan);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>