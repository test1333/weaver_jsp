<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="hsproject.impl.*" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
	
<%
	int userid = user.getUID();
	
    String ids = Util.null2String(request.getParameter("ids"));//提交类型
	ProjectInfoImpl pii = new ProjectInfoImpl();
	if(!"".equals(ids)){
		pii.deleteCheckDoc(ids);
	}
	out.print(ids);
%>	