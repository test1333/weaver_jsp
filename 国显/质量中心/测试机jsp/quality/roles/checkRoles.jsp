<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="com.javen.gvo.quality.util.CheckRoles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="com.javen.Util.Util"%>
<%
	String workcode = Util.null2String((String)request.getSession(true).getAttribute("workcode"));//(String)request.getAttribute("workcode");
	CheckRoles cr = new CheckRoles();
	String cd = request.getParameter("cd");
	if("".equals(workcode)){
		request.getRequestDispatcher("/jsp/quality/note/noright.jsp").forward(request,response);
	}else if(!"sysadmin".equals(workcode)){
		String result = cr.getReturn(workcode, cd);
		if(!result.equals("1")){
			request.getRequestDispatcher("/jsp/quality/note/noright.jsp").forward(request,response);
		}
	}
	//out.print("workcode:"+workcode);
	
%>