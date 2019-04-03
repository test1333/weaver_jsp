<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
    RecordSetDataSource rsd = new RecordSetDataSource("kronos");
	String hour = "";
	String sql="select Cux_getOTHours.Fn_getothours('009118','2018-06-30') as hour from dual";
	rsd.executeSql(sql);
	if(rsd.next()){
		hour = Util.null2String(rsd.getString("hour"));
	}
	out.print(hour);


%>