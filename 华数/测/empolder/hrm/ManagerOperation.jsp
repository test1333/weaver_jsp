<%@ page buffer="4kb" autoFlush="true" errorPage="/notice/error.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ProvinceComInfo" class="weaver.hrm.province.ProvinceComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String operation = Util.fromScreen(request.getParameter("operation"),user.getLanguage());

String id = Util.fromScreen(request.getParameter("id"),user.getLanguage());

String Manager = Util.fromScreen(request.getParameter("Manager"),user.getLanguage());
String code = Util.fromScreen(request.getParameter("code"),user.getLanguage());
String description = Util.fromScreen(request.getParameter("description"),user.getLanguage());

String resourceID = Util.fromScreen(request.getParameter("resourceID"),user.getLanguage());

String temp = "||����---";
String sql = "";

if(!"".equals(id)){
	if("delete".equals(operation)){
		sql = "update hrmManager set isShow = '1' where id = '"+id+"'";
		if(RecordSet.executeSql(sql)){
			%>
			   <script>
			   	alert("ɾ���ɹ�");
			   	location.href = 'ManagerList.jsp';
			   </script>
			   <%
		}else{
			 %>
			   <script>
			   	alert("ɾ��ʧ��");
			   	location.href = 'ManagerList.jsp';
			   </script>
			   <% 
		}
	}else{
		sql = "update hrmManager set name = '"+Manager+"',code='"+code+"',memo = '"+temp+code+Manager+"',description = '"+description+"',resourceID = '"+resourceID+"' where id = '"+id+"'";
		if(RecordSet.executeSql(sql)){
			%>
			   <script>
			   	alert("���³ɹ�");
			   	location.href = 'ManagerList.jsp';
			   </script>
			   <%
		}else{
			%>
			   <script>
			   	alert("����ʧ��");
			   	location.href = 'ManagerList.jsp';
			   </script>
			   <%
		}
	}
// 	 response.sendRedirect("hrmresourceList.jsp");
 }else {
	 sql = "insert into hrmManager(name,code,memo,isShow,description,resourceID) values ('"+Manager+"','"+code+"','"+temp+code+Manager+"','0','"+description+"','"+resourceID+"')";
	 if(RecordSet.executeSql(sql)){
	   %>
	   <script>
	   	alert("����ɹ�");
	   	location.href = 'ManagerList.jsp';
	   </script>
	   <%	 
	 }else{
		 %>
		   <script>
		   	alert("����ʧ��");
		   	location.href = 'ManagerList.jsp';
		   </script>
		   <% 
	 } 
// 	 response.sendRedirect("hrmresourceList.jsp");
 }

%>
