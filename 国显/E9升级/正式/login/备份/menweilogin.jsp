<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.User" %>
<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%

	  // 获取session
     //HttpSession session = request.getSession();
//	 session = request.getSession(true);
   // 泛型
   Enumeration<Object> et = session.getAttributeNames();
    	while(et.hasMoreElements()){
        out.println(et.nextElement()+"<br>");
      }
	 // 在session放置对象
	// 如何放置对象？  放置什么对象
  User user = new User();
	user.setUid(-10);


	request.getSession(true).setAttribute("weaver_user@bean",user);
	String szcq_fk = request.getParameter("szcq_fk");
	String szcq_wpfx = request.getParameter("szcq_wpfx");
	request.getSession(true).setAttribute("szcq_fk",szcq_fk);
	request.getSession(true).setAttribute("szcq_wpfx",szcq_wpfx);
 // 跳转到  目标界面
 // response.sendRedirect("/gvo/visitor/visitorInfo.jsp");
	response.sendRedirect("/gvo/redirect.jsp");
%>