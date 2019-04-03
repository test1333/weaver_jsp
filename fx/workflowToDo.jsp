<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
	
<%
	String company = Util.null2String(request.getParameter("company"));
	String type = Util.null2String(request.getParameter("type"));
	
	String url_for = "";
	if(company.length() < 1){
		url_for = "/fx/tmcMessage.jsp?messid=001";
		response.sendRedirect(url_for);
  		return;
	}
	String url_suff = "";
	String allKey = "";
	if ("yut".equalsIgnoreCase(company)){
		url_suff = "http://oa.shytic.com";
		allKey = "68421921";
	}else if ("ztr".equalsIgnoreCase(company)){
		url_suff = "http://oa.ztrong.com";
		allKey = "72499428";
	}else if ("ych".equalsIgnoreCase(company)){
		url_suff = "http://211.152.53.156:8088";
		allKey = "61992331";
	}else if ("yit".equalsIgnoreCase(company)){
		url_suff = "http://101.230.205.163";
		allKey = "23484325";
	}
	if(url_suff.length() < 1){
		url_for = "/fx/tmcMessage.jsp?messid=002";
		response.sendRedirect(url_for);
  		return;
	}
	//  
	System.out.println("allKey = " + allKey );
	fx.TmcProMethod tpm = new fx.TmcProMethod(allKey);
	
	String nameCode = "";
	int userID = user.getUID();
	String sql =  "select * from hrmresource where id="+userID;
	rs.executeSql(sql);
	if(rs.next()){
		nameCode = Util.null2String(rs.getString("loginid"));
	}
	Date date = new Date();
	String ranNo = String.valueOf(date.getTime());
	String userName = tpm.getPassword(ranNo);
	String randTime = tpm.getPassword(nameCode);
	
	if(userName.length() < 1 || randTime.length() < 1){
	//	url_for = "/fx/tmcMessage.jsp?messid=003&info="+userName+"0"+randTime+"";
		url_for = "/fx/tmcMessage.jsp?messid=003";
		response.sendRedirect(url_for);
  		return;
	}
	
	String url_x = url_suff+"/fx/ProTmcFor.jsp?src=group&userName="+userName+"&randTime="+randTime+"&fost="+type;
 	// 跳转到  目标界面
  	response.sendRedirect(url_x);
  	return;
%>