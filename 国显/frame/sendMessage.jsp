<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="gvo.passwd.GvoEmcPasswd" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	// userCode=0002&folderId
	String folderId = Util.null2String(request.getParameter("folderId"));
	String userCode = "";
	String url_str = "";
	
	int id = user.getUID();
	
	String sql = "select loginid from hrmresource where id="+id;
	rs.executeSql(sql);
	if(rs.next()){
		userCode = Util.null2String(rs.getString("loginid"));
	}
	
	GvoEmcPasswd gmp = new GvoEmcPasswd();
	userCode = gmp.getPassword(userCode);
	
	url_str = "http://10.80.5.61:8080/dfcr/doclist/listDocsByFid?ticket="+userCode+"&folderId="+folderId;
	
	response.sendRedirect(url_str);

%>