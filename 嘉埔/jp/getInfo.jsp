<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
   
    String sqr = request.getParameter("sqr");
	String reid = request.getParameter("reid");
	String ccsjval = request.getParameter("ccsjval");
	String fhsjval = request.getParameter("fhsjval");
	String countnum="0";
	 String sql="select COUNT(1) count from formtable_main_27 where  requestId <>"+reid+" and sqr='"+sqr+"' and '"+ccsjval+"' <=fhsj and ccsj<='"+fhsjval+"'";
     rs.executeSql(sql);
	
	 if(rs.next()){
        countnum = Util.null2String(rs.getString("count"));

	 }
	out.print(countnum);
%>