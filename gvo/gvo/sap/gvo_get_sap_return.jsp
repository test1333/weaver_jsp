<%@ page import="weaver.general.Util" %>
<%@ page import="self.BringMainAndDetailByMain" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String emp_code= Util.null2String(request.getParameter("emp_code"));
	String com_code = Util.null2String(request.getParameter("com_code"));
//	System.out.println("emp_code =  " + emp_code + " ,com_code = " + com_code);
//	emp_code = "B0320";
//	com_code = "1000";
	
	String workflowId = "103";
	String formid = "-37";
	
	java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
	oaDatas.put("GH", emp_code);
	oaDatas.put("GSDM", com_code);
	
	BringMainAndDetailByMain bmb = new BringMainAndDetailByMain();
	String result = bmb.getReturn(oaDatas,workflowId,formid);
		
	out.print(result);
%>
