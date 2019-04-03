<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="weaver.general.MD5" %>
<%@ page import="weaver.hrm.User"%>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
	BaseBean log = new BaseBean();
	String ssokey = Util.null2String(request.getParameter("ssokey")) ;
	log.writeLog("test ssokey:"+ssokey);
	SimpleDateFormat dateFormate = new SimpleDateFormat("yyyyMMdd");
		String nowDate = dateFormate.format(new Date());
		String workcode = "";
		String key = "sYWf5fhsB5drv80jUi5Q3HJZKyK8in8YnIjyF3gognH9vV2KiMMe97KpVx6VXDNjOQK6D8opqLOVs2CmFi3KWdPZRMIAuvtMrtJ";
		String token = "";
		String result = "";
		MD5 md5 = new MD5();
		if("".equals(ssokey)) {
			result = "0";
		}else {
			try {
				workcode = ssokey.substring(1,ssokey.lastIndexOf("/"));
				token = ssokey.substring(ssokey.lastIndexOf("/")+1,ssokey.length());
			}catch(Exception e) {
				result = "0";
			}
		}
		if(!"0".equals(result)) {
			String str=key+workcode+nowDate;
			//System.out.println(md5.getMD5ofStr(str));
			//System.out.println(token.toUpperCase());
			if(token.toUpperCase().equals(md5.getMD5ofStr(str).toUpperCase())) {
				result ="1";
			}else{
				result = "0";
			}
		}
		if("1".equals(result)){
			String sql = "select * from hrmresource where workcode = '" + workcode + "'";
			String loginid = "";
			rs.executeSql(sql);
			int xxxid = 0;
			if(rs.next()){
				xxxid = rs.getInt("id");
				loginid = Util.null2String(rs.getString("loginid"));
			}
			if(xxxid < 1 ) {
				String toRedirect = "/login/Login.jsp?logintype=1";
				response.sendRedirect(toRedirect);
			}else{
				User user1 = new User();
				user1 = User.getUser(xxxid, 0);
				
				request.getSession(true).setMaxInactiveInterval(60 * 60 * 24);
				request.getSession(true).setAttribute("curloginid",loginid);
				request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
				request.getSession(true).setAttribute("SESSION_CURRENT_THEME","ecology8");
				request.getSession(true).setAttribute("SESSION_TEMP_CURRENT_THEME","ecology8"); 
				request.getSession(true).setAttribute("SESSION_CURRENT_SKIN","default");
				request.getSession(true).setAttribute("weaver_user@bean", user1);
				request.getSession(true).setAttribute("browser_isie", "true");	
				
				String toRedirect = "/wui/main.jsp";
				response.sendRedirect(toRedirect);
			}
		}else{
			String toRedirect = "/login/Login.jsp?logintype=1&issso=1";
				response.sendRedirect(toRedirect);
		}
		
%>

