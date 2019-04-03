<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%@ page import="weaver.general.Util"%>
	
<%

	String prjid = Util.null2String(request.getParameter("prjid"));
    String sql = "select id from uf_project_it where prjid='"+prjid+"'";
	rs.executeSql(sql);
	String billid="";
	if(rs.next()){
      billid =Util.null2String(rs.getString("id"));
	}
	if(!"".equals(billid)){
		response.sendRedirect("/formmode/view/AddFormModeIframe.jsp?modeId=181&formId=-93&type=0&billid="+billid);
		//response.sendRedirect("/formmode/view/ViewMode.jsp?modeId=561&formId=-98&type=0&viewfrom=fromsearchlist&billid="+billid);  
	}

	

%>