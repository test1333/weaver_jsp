<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
	
<%
	// type,custom,empID
	String typex = Util.null2String(request.getParameter("typex"));
//	String customID = Util.null2String(request.getParameter("customIDx"));
//	String empID = Util.null2String(request.getParameter("empIDx"));
//	String type = Util.null2String(request.getParameter("typex"));
	


	String resArr[] = typex.split(",");
	String type = "";
	String customID = "";
	String empID = "";
	
	
	if(resArr.length > 0) {
		type = resArr[0];
	}
		
	if(resArr.length > 1) {
		customID = resArr[1];
	}
	
	if(resArr.length > 2) {
		empID = resArr[2];
	}
	
//	out.println("customID = "+customID+";empID = " + empID + " ; type = " + type);
//	String tmp_val = "@"+java.net.URLEncoder.encode(ResourceComInfo.getResourcename(empID))+"%20%20";
	
	String tmp_val = "";
	if(empID.length()>0){
		tmp_val = "@"+ResourceComInfo.getResourcename(empID)+"%20%20";
	}
	if("addRecord".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=2001&formId=-542&type=1");  
	}
	if("editRecord".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=2001&formId=-542&type=2&viewfrom=fromsearchlist&billid="+customID);  
	}
	

%>