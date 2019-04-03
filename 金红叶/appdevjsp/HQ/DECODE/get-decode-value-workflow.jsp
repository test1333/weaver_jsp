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
    String oldvalue = request.getParameter("oldvalue");
	String djxs[]=oldvalue.split(",");
	String newvalue = "";
	String sql="";
	String flag="";
	for(int i=0;i<djxs.length;i++){
		String yjx="";
		String djx=djxs[i];
		sql="select mydecrypt('"+djx+"','ZHULINJUN._ROW@KEY-CITOA8888') as yjx from dual";
		rs.executeSql(sql);
		if(rs.next()){
			yjx=Util.null2String(rs.getString("yjx"));
		}
		newvalue=newvalue+flag+yjx;
		flag="###";
	}

	out.print(newvalue); 
%>