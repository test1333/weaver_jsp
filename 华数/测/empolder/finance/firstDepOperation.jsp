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

String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());
String code = Util.fromScreen(request.getParameter("code"),user.getLanguage());
String depID = Util.fromScreen(request.getParameter("depID"),user.getLanguage());
String description = Util.fromScreen(request.getParameter("description"),user.getLanguage());
String depCode = "";

String sql_str = "select departmentcode from hrmdepartment where id = '"+depID+"'";
rs.executeSql(sql_str);
if(rs.next()){
	depCode = rs.getString("departmentcode");
}


String sql = "";

if(!"".equals(id)){
	if("delete".equals(operation)){
		sql = "delete from firstDepLeft where id = '"+id+"'";
		if(RecordSet.executeSql(sql)){
			%>
			   <script>
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
		sql = "update firstDepLeft set name = '"+name+"',description='"+description+"',code = '"+code+"' where id = '"+id+"'";
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
	 sql = "insert into firstDepLeft(name,code,description,deplevel) values ('"+name+"','"+code+"','"+description+"','1')";
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
