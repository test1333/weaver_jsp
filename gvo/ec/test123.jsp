<%@ page import="weaver.general.Util" %>
<%@ page import="gvo.webservice.CreateRequestServiceEC" %>
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

<%
  RecordSet rs = new RecordSet();
  String sql="select a.lastname,b.departmentname from hrmresource a ,hrmdepartment b where a.departmentid=b.id ";
  rs.executeSql(sql);
  String aa[]=rs.getColumnName();
for(int i=0; i<aa.length;i++){
		out.println(aa[0]);	
	}
%>