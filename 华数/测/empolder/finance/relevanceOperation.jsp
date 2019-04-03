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

String subjectid = Util.fromScreen(request.getParameter("subjectid"),user.getLanguage());
String subjectcode = Util.fromScreen(request.getParameter("subjcetcode"),user.getLanguage());
String description = Util.fromScreen(request.getParameter("description"),user.getLanguage());
String falg = Util.fromScreen(request.getParameter("falg"),user.getLanguage());

String parentDepID = Util.fromScreen(request.getParameter("parentID"),user.getLanguage());

String depCode = "";

String sql = "";

if(!"".equals(id)){
	if("delete".equals(operation)){
		sql = "delete from relevance where id = '"+id+"'";
		if(RecordSet.executeSql(sql)){
			%>
			   <script>
			   var parentid=<%=parentDepID%>
			   	alert("删除成功");
			   	location.href = 'firstDepList.jsp';
			   </script>
			   <%
		}else{
			 %>
			   <script>
			   	alert("删除失败");
			   	location.href = 'firstDepList.jsp';
			   </script>
			   <% 
		}
	}else{
		sql = "update relevance set subjectid = '"+subjectid+"',subjcetcode='"+subjectcode+"',description = '"+description+"',isfalg = '"+falg+"' where id = '"+id+"'";
// 		System.out.println("=========="+sql);
		if(RecordSet.executeSql(sql)){
			%>
			   <script>
			   	alert("更新成功");
			   	location.href = 'firstDepList.jsp';
			   </script>
			   <%
		}else{
			%>
			   <script>
			   	alert("更新失败");
			   	location.href = 'firstDepList.jsp';
			   </script>
			   <%
		}
	}
// 	 response.sendRedirect("hrmresourceList.jsp");
 }else {
	 sql = "insert into relevance(subjectid,subjcetcode,description,parentdepid,isfalg) values ('"+subjectid+"','"+subjectcode+"','"+description+"','"+parentDepID+"','"+falg+"')";
	 if(RecordSet.executeSql(sql)){
	   %>
	   <script>
	   	alert("保存成功");
	   	location.href = 'firstDep.jsp';
	   </script>
	   <%	 
	 }else{
		 %>
		   <script>
		   	alert("保存失败");
		   	location.href = 'firstDep.jsp';
		   </script>
		   <% 
	 } 
// 	 response.sendRedirect("hrmresourceList.jsp");
 }

%>
