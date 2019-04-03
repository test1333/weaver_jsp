<%@ page buffer="4kb" autoFlush="true" errorPage="/notice/error.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ProvinceComInfo" class="weaver.hrm.province.ProvinceComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
String operation = Util.fromScreen(request.getParameter("operation"),user.getLanguage());

String id = Util.fromScreen(request.getParameter("id"),user.getLanguage());

String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());
String code = Util.fromScreen(request.getParameter("code"),user.getLanguage());
String remark = Util.fromScreen(request.getParameter("remark"),user.getLanguage());

String sql = "";

if(!"".equals(id)){
	if("delete".equals(operation)){
		sql = "delete from subjectDeatil where id = '"+id+"'";
		if(RecordSet.executeSql(sql)){
			%>
			   <script>
			   	alert("删除成功");
			   	location.href = 'subjectList.jsp';
			   </script>
			   <%
		}else{
			 %>
			   <script>
			   	alert("删除失败");
			   	location.href = 'subjectList.jsp';
			   </script>
			   <% 
		}
	}else{
		sql = "update subjectDeatil set name = '"+name+"',remark='"+remark+"',code = '"+code+"' where id = '"+id+"'";
		if(RecordSet.executeSql(sql)){
			%>
			   <script>
			   	alert("更新成功");
			   	location.href = 'subjectList.jsp';
			   </script>
			   <%
		}else{
			%>
			   <script>
			   	alert("更新失败");
			   	location.href = 'subjectList.jsp';
			   </script>
			   <%
		}
	}
// 	 response.sendRedirect("hrmresourceList.jsp");
 }else {
	 sql = "insert into subjectDeatil(name,code,remark) values ('"+name+"','"+code+"','"+remark+"')";
	 if(RecordSet.executeSql(sql)){
	   %>
	   <script>
	   	alert("保存成功");
	   	location.href = 'subjectList.jsp';
	   </script>
	   <%	 
	 }else{
		 %>
		   <script>
		   	alert("保存失败");
		   	location.href = 'subjectList.jsp';
		   </script>
		   <% 
	 } 
// 	 response.sendRedirect("hrmresourceList.jsp");
 }

%>
