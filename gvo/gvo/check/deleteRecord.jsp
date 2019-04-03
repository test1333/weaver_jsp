<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
   // BaseBean log = new BaseBean();
    String ids = request.getParameter("id");
	ids=ids+"0";
    String sql ="delete from uf_month_check where id in("+ids+")";
	//log.writeLog("不处理"+sql);
	RecordSet.executeSql(sql);
	out.print(ids);
%>