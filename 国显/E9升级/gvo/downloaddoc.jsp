<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="weaver.systeminfo.*" %>
<%
String imagefileid = Util.null2String(request.getParameter("fileid")); 
String url = "/download/weaver.file.getFileDownLoad?fileid="+ imagefileid + "&download=1";
response.sendRedirect(url);
%>