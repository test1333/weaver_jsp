<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
<%@ page import="seahonor.action.custom.EditCustom"%>
	
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
	 if("editcustom".equals(type)){
       EditCustom ec= new EditCustom();
	   String billid1=ec.getID(customID,empID);
	 response.sendRedirect("/formmode/view/AddFormMode.jsp?mainid=0&modeId=172&formId=-298&type=2&Id=768&billid="+billid1);  
	}
	if("addrc".equals(type)){
		response.sendRedirect("/workplan/data/WorkPlanEdit.jsp");  
	}
	if("customzz".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=60&formId=-67&type=1&field6813="+customID);  
	}
	if("customzz1".equals(type)){
		response.sendRedirect("/formmode/view/ViewMode.jsp?modeId=60&formId=-67&type=0&viewfrom=fromsearchlist&billid="+customID);  
	}
	if("gyspj".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=150&formId=-260&type=1&field12465="+customID);  
	}
	if("ctnew".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=56&formId=-63&type=1&field10159=1&field6714="+customID);  
	}
	if("ctgnew".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=56&formId=-63&type=1&field10159=0&field6727="+customID);  
	}
    if("groupedit".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?mainid=0&modeId=58&formId=-65&type=2&Id=41&billid="+customID);  
//	out.println(tmp_val);
	}
	if("groupnew".equals(type)){
		response.sendRedirect( "/formmode/view/AddFormMode.jsp?modeId=58&formId=-65&type=1&field6747="+customID);  
//	out.println(tmp_val);
	}
	if("custom".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=57&formId=-64&type=1&field6741="+customID+"&field6737="+tmp_val+"&field6743="+empID);  
//	out.println(tmp_val);
	}
	if("group".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=62&formId=-64&type=1&field6742="+customID+"&field6737="+tmp_val+"&field6743="+empID);  
//	out.println(tmp_val);
	}

%>