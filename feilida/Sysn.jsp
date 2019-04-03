<%@ page import="weaver.general.Util" %>
<%@ page import="tmc.BringMainAndDetailByMain" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="xx" class="feilida.HrmSynchronization" scope="page" />
	<%
      xx.execute();
      out.println("---------------------------------分部插入成功------------------------------------------------------<br>");
	%>