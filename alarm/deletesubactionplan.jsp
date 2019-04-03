<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String sql = "";
	String requestId = "";//id
	StringBuffer dataBuff = new StringBuffer();



	
	
	String val = request.getParameter("val");

	    sql = "delete from uf_sub_action where id="+val;
	    rs.executeSql(sql);       
	   
				
	
		out.print("success");
	//}	
%>