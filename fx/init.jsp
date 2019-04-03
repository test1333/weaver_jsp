<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.general.StaticObj" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.settings.RemindSettings" %>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%
	User user = HrmUserVarify.checkUser(request , response);
	if(user == null) {
		out.println("登录超时，请重新登录！");
		return;
	}
	Log logger= LogFactory.getLog(this.getClass());
%>