<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<%
	
	request.getSession(true).removeAttribute("weaver_user@bean");
	request.getSession(true).removeAttribute("curloginid");

	String workcode = Util.null2String(request.getParameter("workcode"));
	
	String sql = "select * from hrmresource where workcode='"+workcode+"'";
	rs.executeSql(sql);
	rs.next();
	User user = new User();
    user=User.getUser(rs.getInt("id"), 0);
    String tmp_loginid = rs.getString("loginid");             
    request.getSession(true).setAttribute("curloginid",tmp_loginid);
	request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
	request.getSession(true).setAttribute("SESSION_CURRENT_THEME","ecology8");
	request.getSession(true).setAttribute("SESSION_TEMP_CURRENT_THEME","ecology8"); 
    	request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
	request.getSession(true).setAttribute("weaver_user@bean", user);
	request.getSession(true).setAttribute("browser_isie", "true");	
	if (user.getUID() != 1) {  //is not sysadmin
		java.util.List accounts = new weaver.login.VerifyLogin().getAccountsById(rs.getInt("id"));
		request.getSession(true).setAttribute("accounts", accounts);
	}
	
	
 // 跳转到  目标界面
  response.sendRedirect("/wui/main.jsp?templateId=1");
  return;
%>