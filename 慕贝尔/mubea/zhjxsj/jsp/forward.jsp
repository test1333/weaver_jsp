<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
<%@ page import="mubea.zhjxsj.impl.doDataConnectAction"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>	
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String typex = Util.null2String(request.getParameter("typex"));
	String resArr[] = typex.split(",");
	String type="";
	String remark="";
	String starttime="";
	String endtime="";
    if(resArr.length > 0) {
		type = resArr[0];
	}
		
	if(resArr.length > 1) {
		remark = resArr[1];
	}
	
	if(resArr.length > 2) {
		starttime = resArr[2];
	}
	if(resArr.length > 3) {
		endtime = resArr[3];
	}
	int userid  = user.getUID();
    String falg="0";
	
	
    
	if("ck".equals(type)){
		 doDataConnectAction  da= new doDataConnectAction();
		 String modeid=Util.null2String(da.getmodeid(remark,"","",starttime,endtime,""));
		 if(!"".equals(modeid)){
			 response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=91&formId=-149&type=0&Id=424&billid="+modeid);  	
		 }
		
		
	}
	if("dp".equals(type)){
		 response.sendRedirect("/mubea/zhjxsj/skip.jsp");  	
		
	}
	

%>