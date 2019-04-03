<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
//	 java.util.List<String> session_list = new java.util.ArrayList<String>();
//	 java.util.Enumeration enumeration = request.getSession(true).getAttributeNames();   //遍历enumeration中的 
//	 while(enumeration.hasMoreElements()){   //获取session键值     
//		 String name = enumeration.nextElement().toString();
//		 session_list.add(name);
//	}
	
//	for(int i=0;i<session_list.size();i++){
//		request.getSession(true).removeAttribute(session_list.get(i));
//	}
	
	//request.getSession(true).invalidate(); 
		
	request.getSession(true).removeAttribute("weaver_user@bean");
	request.getSession(true).removeAttribute("curloginid");
	
	String loginfile = Util.null2String(request.getParameter("loginfile")) ;
	String logintype = Util.null2String(request.getParameter("logintype")) ;
	String loginid = Util.null2String(request.getParameter("loginid")) ;
	String forwardpage = Util.null2String(request.getParameter("forwardpage")) ;
	String userpassword = Util.null2String(request.getParameter("userpassword"));
	String message = Util.null2String(request.getParameter("message"));
	String isIE = Util.null2String(request.getParameter("isie"));
	String agent = request.getHeader("user-agent");
	 if(agent.indexOf("rv:11") == -1 && agent.indexOf("MSIE") == -1){
		isIE = "false";
	 }

	 if(agent.indexOf("rv:11") > -1 && agent.indexOf("Mozilla") > -1){
			isIE = "true";
	 }

 	 if(!isIE.equals("false")){
		isIE = "true";
	 }
	session.setAttribute("browser_isie",isIE);
	
	%>
<script language="javascript">
	alert("loginid = " + loginid);
</script>
<%

	String requestMethod = Util.null2String(request.getMethod());
	if(requestMethod.equalsIgnoreCase("GET122")){
%>
<script language="javascript">
//	alert("非法登录方式");
//	window.close();
</script>
<%
	return;
}
%>
<%
	if(!logintype.equalsIgnoreCase("1")){
%>
<script language="javascript">
	alert("异常登录方式!");
	window.close();
</script>
<%
	return;
	}
%>
<%

	
	String sql = "select * from hrmresource where upper(loginid)=upper('"+loginid+"') and  status in(0,1,2,3) ";
	rs.executeSql(sql);
	int xxxid = 0;
	if(rs.next()){
		xxxid = rs.getInt("id");
		loginid = Util.null2String(rs.getString("loginid"));
	}
	
	User user = new User();
	user = User.getUser(xxxid, 0);
	
	request.getSession(true).setMaxInactiveInterval(60 * 60 * 24);
	request.getSession(true).setAttribute("curloginid",loginid);
	request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
	request.getSession(true).setAttribute("SESSION_CURRENT_THEME","ecology7");
	request.getSession(true).setAttribute("SESSION_TEMP_CURRENT_THEME","ecology7"); 
	request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
	request.getSession(true).setAttribute("weaver_user@bean", user);
	
	if (user.getUID() != 1) {  //is not sysadmin
		java.util.List accounts = new weaver.login.VerifyLogin().getAccountsById(rs.getInt("id"));
		request.getSession(true).setAttribute("accounts", accounts);
	}
	
	String comid = "";
	if(xxxid != 1){
		sql = "select id,supsubcomid from hrmsubcompany where id=(select subcompanyid1 from hrmresource where id="+xxxid+")";
		rs.executeSql(sql);
		if(rs.next()){
			comid = Util.null2String(rs.getString("id"));
		}
	}
 // 跳转到  目标界面
  if(forwardpage.equalsIgnoreCase("A")){
	 if("224".equals(comid)){
		response.sendRedirect("/bsdt/portv3.jsp");
		return;
	 } 
 	 response.sendRedirect("/bsdt/port.jsp");
  }else if(forwardpage.equalsIgnoreCase("B")){
  	response.sendRedirect("/wui/main.jsp");
  }
  return;
%>