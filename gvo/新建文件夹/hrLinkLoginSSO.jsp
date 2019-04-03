<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="gvo.hrLink.WebApiRes" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
	function formSubmit(){
		document.getElementById("fLogin").submit();
	}
</script>
</head>
<%
	WebApiRes wb = new WebApiRes();
	
	String ticketUrl = "/HRLINK_OA_Interface/OAapp.asmx/ApplicationToken";;
	String username = "xxx";//hr提供
	String pwd = "xxxx";//hr提供
	String workcode = "";
	
	int userid = user.getUID();  // d当前用户
	RecordSet.executeSql("SELECT * FROM HrmResource WHERE ID = '" + userid + "'");
	if(RecordSet.next()){
		workcode = Util.null2String(RecordSet.getString("workcode"));
	}
	if(workcode.length()< 1){
		return;
	}
	String workcode_new = wb.encrypt(workcode);
	String str = "username=" + username + "&pwd=" + pwd + "&workcode="+ workcode_new;
	String token = wb.postConn(ticketUrl,str);
	

%>

	<body>
		<div>

		<div>
		<form name="fLogin" id="fLogin" method="post" action="/HRLINK_OA_Interface/OAHRLINKInterface.aspx">
			<input type="hidden" name="menuid" value="Menuitem1000" />
			<input type="hidden" name="token" value="<%=token%>" />
			<input type="hidden" name="Workcode" value="<%=workcode_new%>"/>
			
		</form>
		
		
		
	</body>

</html>