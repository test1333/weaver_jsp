<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="AssetComInfo" class="weaver.lgc.asset.AssetComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="LgcAssortmentComInfo" class="weaver.lgc.maintenance.LgcAssortmentComInfo" scope="page" />
<%
String loginid = "";
String password = "";
int user_id = user.getUID();
String sql ="select * from hrmresource where id = '"+user_id+"'";
RecordSet.execute(sql);
if(RecordSet.next()){
	loginid = RecordSet.getString("loginid");
	password = RecordSet.getString("password");
	RecordSet.writeLog("登录名---"+loginid+"密码---"+password);
}
%>
<head>
    <title>查分系统登陆</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		function logincf(){
			document.forms[0].submit();
		}
	</script>
  </head>
 <body onload="logincf()">
    <form id="form1" name="form1" action="http://query.shmeea.edu.cn/shmeeacx/login/auth" method="post">
    	<input type="hidden" name="type" value="hidden">
    	<input type="hidden" name="userName" value="<%=loginid %>">
    	<input type="hidden" name="passwd" value="<%=password %>">
    </form>
  </body>