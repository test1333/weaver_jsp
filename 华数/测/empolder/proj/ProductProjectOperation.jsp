<%@ page buffer="4kb" autoFlush="true" errorPage="/notice/error.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ProvinceComInfo" class="weaver.hrm.province.ProvinceComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String operation = Util.fromScreen(request.getParameter("operation"),user.getLanguage());

String id = Util.fromScreen(request.getParameter("id"),user.getLanguage());

String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());
String order_o = Util.fromScreen(request.getParameter("order_o"),user.getLanguage());
String description = Util.fromScreen(request.getParameter("description"),user.getLanguage());
String forServerLine = Util.fromScreen(request.getParameter("forServerLine"),user.getLanguage());

String sql = "";

if(!"".equals(id)){
	if("delete".equals(operation)){
		sql = "update productProject set isShow = '1' where id = '"+id+"'";
		RecordSet.executeSql(sql);
	}else{
		sql = "update productProject set name = '"+name+"',order_o='"+order_o+"',description = '"+description+"',forServerLine = '"+forServerLine+"' where id = '"+id+"'";
		RecordSet.executeSql(sql);
	}
	response.sendRedirect("ProductProjectList.jsp");
 }else {
	 sql = "insert into productProject(name,order_o,isShow,description,forServerLine) values ('"+name+"','"+order_o+"','0','"+description+"','"+forServerLine+"')";
	 if(RecordSet.executeSql(sql)){
		   %>
		   <script>
		   	alert("保存成功");
		   	location.href = 'ProductProjectList.jsp';
		   </script>
		   <%	 
		 }else{
			 %>
			   <script>
			   	alert("保存失败");
			   	location.href = 'ProductProjectList.jsp';
			   </script>
			   <% 
		 }
// 	 response.sendRedirect("hrmresourceList.jsp");
 }
new BaseBean().writeLog(sql);
// response.sendRedirect("ProductProjectList.jsp");
%>
