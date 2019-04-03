<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>	
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String typex = Util.null2String(request.getParameter("typex"));
	String resArr[] = typex.split(",");
	String type="";
	String xgid="";
	String xgseq="";
	String requestid="";
    if(resArr.length > 0) {
		type = resArr[0];
	}
		
	if(resArr.length > 1) {
		xgid = resArr[1];
	}
	
	if(resArr.length > 2) {
		xgseq = resArr[2];
	}
	if(resArr.length > 3) {
		requestid = resArr[3];
	}
	int userid  = user.getUID();
    String falg="0";
	
	

	if("ck".equals(type)){
		 response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=86&formId=-144&type=0&Id=405&billid=1");  	
		
	}
	if("dp".equals(type)){
		 response.sendRedirect("/mubea/zhjxsj/skip.jsp");  	
		
	}
	

%>