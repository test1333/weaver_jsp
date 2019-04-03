<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="gvo.passwd.GvoEmcPasswd" %>
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
	
	String ip = request.getHeader("x-forwarded-for");    
    	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
      	  ip = request.getHeader("Proxy-Client-IP");    
   	 }    
   	 if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
    	    ip = request.getHeader("WL-Proxy-Client-IP");    
   	 }    
    	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {    
    	    ip = request.getRemoteAddr();    
    	}  
	
	
	GvoEmcPasswd gmp = new GvoEmcPasswd();
	userCode = gmp.getPassword(userCode);
	
	new weaver.general.BaseBean().writeLog("EMC 访问: ip:"+ip + ";用户id:"+id  + ";userCode = " + userCode);
	
	url_str = "http://10.80.5.61:8080/dfcr/indexDoc/index?ticket="+userCode;
	
	response.sendRedirect(url_str);

%>