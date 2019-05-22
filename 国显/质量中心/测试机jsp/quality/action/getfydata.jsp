
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.javen.gvo.quality.kh.*"%>
<%@ page import="com.javen.Util.Util"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="com.javen.gvo.quality.ks.*"%>
<%@ page import="com.javen.gvo.quality.kx.*"%>
<%@page import="java.net.URLDecoder"%>
<%
String type = Util.null2String(request.getParameter("type"));
String pagenum = Util.null2String(request.getParameter("pagenum"));
String rows = Util.null2String(request.getParameter("rows"));
String pagestart = Util.null2String(request.getParameter("pagestart"));
String sort = Util.null2String(request.getParameter("sort"));
String sortOrder = Util.null2String(request.getParameter("sortOrder"));
String queryCondition = Util.null2String(request.getParameter("queryCondition"));
String result = "";
if("khminnew".equals(type)){
	KhxxfyListNew khy = new KhxxfyListNew(); 
	result = khy.getKhMinInfo(Util.getIntValue(rows,-1),Util.getIntValue(pagestart, 1),sort,sortOrder);
	
}else if("ksdt".equals(type)){
	GetKsdtList gkl = new GetKsdtList(); 
	result = gkl.getKsdtInfo(Util.getIntValue(rows,-1),Util.getIntValue(pagestart, 1),sort,sortOrder);
	
}else if("ksfy".equals(type)){
	GetKsfyList gkl = new GetKsfyList();  
	result = gkl.getKsfyInfo(Util.getIntValue(rows,-1),Util.getIntValue(pagestart, 1),sort,sortOrder,queryCondition);
	
}else if("ksfydt".equals(type)){
	GetKsfyDtList gkl = new GetKsfyDtList();  
	result = gkl.getKsfyDtInfo(Util.getIntValue(rows,-1),Util.getIntValue(pagestart, 1),sort,sortOrder,queryCondition);
	
}else if("kxdt".equals(type)){ 
	GetKxdtList gkl = new GetKxdtList();  
	result = gkl.getKxdtInfo(Util.getIntValue(rows,-1),Util.getIntValue(pagestart, 1),sort,sortOrder,queryCondition);
	
}else if("khxx".equals(type)){ 
	GetKhxxdtList gkl = new GetKhxxdtList();   
	result = gkl.getKhxxdtInfo(Util.getIntValue(rows,-1),Util.getIntValue(pagestart, 1),sort,sortOrder,queryCondition);	
}
out.print(result);
%>