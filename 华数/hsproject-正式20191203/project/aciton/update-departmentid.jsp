<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
	
<%
	String sql = "update uf_prj_depbudget a set a.department =(select id from hrmdepartment where subcompanyid1=a.company and departmentname=(select departmentname from hrmdepartment where id=a.department) and nvl(canceled,0)<>1 and nvl(supdepid,0)<1) "+
		       " where (a.company<>(select subcompanyid1 from hrmdepartment where id=a.department) or exists(select 1 from hrmdepartment where id=a.department and (nvl(canceled,0)=1 or nvl(supdepid,0)>=1)))";
	rs.executeSql(sql);

%>	