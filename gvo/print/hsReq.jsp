<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script LANGUAGE="JavaScript" SRC="/js/checkinput_wev8.js"></script>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
</head>
  
<BODY> 
	<%
		String requestidstemp = Util.null2String(request.getParameter("requestids"));
		String sql = "select * from workflow_requestbase where requestmark='"+requestidstemp.trim()+"'";
	//	out.print("sql " + sql + "<br>");
		RecordSet.executeSql(sql);
		String requestid = "";
		if(RecordSet.next()){
			requestid = RecordSet.getString("requestid");
		}
		if(requestid.length() < 1){
		//	out.println("123123123123 = " + requestidstemp);
	%>
		<script language=javascript>  
			alter("该流程不在您的待办！");  
			<!--
			this.window.opener = null;  
			window.close();  
			//-->  
		</script>
	<%
		}else{
			String url = "/workflow/request/ViewRequest.jsp?requestid="+requestid;
			response.sendRedirect(url);
		}
	%>
</BODY>
