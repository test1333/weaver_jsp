<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String userCode = "";
	String url_str = "";
	
	int id = user.getUID();
	
	String sql = "select loginid from hrmresource where id="+id;
	rs.executeSql(sql);
	if(rs.next()){
		userCode = Util.null2String(rs.getString("loginid"));
	}
	
	url_str = "http://172.20.70.218:9990/zh-CN/OA/OA_Scheduling/"+id;
	
	response.sendRedirect(url_str);

%>