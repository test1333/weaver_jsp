<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />	
<%
	// type,custom,id
	String typex = Util.null2String(request.getParameter("typex"));

	String resArr[] = typex.split(",");
	String type = "";
	String customID = "";
	String id = "";
	
	
	if(resArr.length > 0) {
		type = resArr[0];
	}
		
	if(resArr.length > 1) {
		customID = resArr[1];
	}
	
	if(resArr.length > 2) {
		id = resArr[2];
	}
	out.println("typex="+typex+";type="+type+";id="+id);
	
	
	if("foMe".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=97&formId=-142&type=1&field8086=1&field8092="+id);  
//	out.println(tmp_val);
	}
	if("dyMe".equals(type)){
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=98&formId=-143&type=1&field8097="+id);  
//	out.println(tmp_val);
	}
	if("dyMe2".equals(type)){
		String cc = "";
		String cid = "";
		if(id.length() == 0) id = "-1";
		String sql = "select modedatacreater,contactsname from uf_ContactsDy where id="+id;
		RecordSet.executeSql(sql);
		String tmpEmp = "";
		if(RecordSet.next()){
			tmpEmp = Util.null2String(RecordSet.getString("modedatacreater"));
			cc = "@"+ResourceComInfo.getResourcename(tmpEmp)+"%20%20";
			cid = Util.null2String(RecordSet.getString("contactsname"));
		}	
		//out.println("tmpEmp = " + tmpEmp + " ; cc=" + cc + " ; sql=" + sql);
		response.sendRedirect("/formmode/view/AddFormMode.jsp?modeId=98&formId=-143&type=1&field8097="+cid+"&field8095="+tmpEmp+"&field8094="+cc);  
	}

%>