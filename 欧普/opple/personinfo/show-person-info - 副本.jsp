<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>	
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	
	int userid = user.getUID();
	String billid="";
	String sql="select b.id from hrmresource a,uf_person_detail b where a.loginid=b.loginid and a.id="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		billid = Util.null2String(rs.getString("id"));
	}

    //个人借款余额
	if(!"".equals(billid)){
		 response.sendRedirect("/formmode/view/AddFormMode.jsp?type=0&modeId=183&formId=-69&billid="+billid+"&opentype=0");  
	}else{
		response.sendRedirect("/formmode/view/AddFormModeIframe.jsp?isPreview=1&modeId=183&formId=-69&type=0&layoutid=245");  
	}
	
%>