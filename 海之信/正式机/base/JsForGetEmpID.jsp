<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%

	Enumeration enu=request.getParameterNames(); 
	
	while(enu.hasMoreElements()){  
		String paraName=(String)enu.nextElement();  
		out.println(paraName+": "+request.getParameter(paraName)); 
		out.print("<br>"); 
	}
	
	String emp_id = Util.null2String(request.getParameter("emp_id"));
	
	out.print(emp_id);
%>