<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.javen.Util.Util"%>
<%@ page import="java.util.ResourceBundle"%>
<%
	ResourceBundle bundle = ResourceBundle.getBundle("ks");
// 增加参数判断缓存
int isIncludeToptitle = 0;
response.setHeader("cache-control", "no-cache");
response.setHeader("pragma", "no-cache");
response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
String forwardurl = bundle.getString("oaurl")+"/login/Login.jsp?logintype=1";
String workcode = Util.null2String((String)session.getAttribute("workcode"));
//out.print(workcode);
if("".equals(workcode)){
	response.sendRedirect(forwardurl);
    return;
}

%>
