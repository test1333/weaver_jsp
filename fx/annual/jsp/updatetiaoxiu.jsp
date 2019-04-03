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
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String tiaoxiuid = Util.null2String(request.getParameter("tiaoxiuid"));
	 String overtimenew =  Util.null2String(request.getParameter("overtimenew"));
	 if("".equals(overtimenew)){
		 overtimenew = "0";
	 }
	 if(!"".equals(tiaoxiuid)&&!"".equals(overtimenew)){
    String sql="update formtable_main_60 set overTime="+overtimenew+" where id="+tiaoxiuid;
	rs.executeSql(sql);
	out.print("修改成功");
	}else{
     out.print("修改失败");
	}
%>