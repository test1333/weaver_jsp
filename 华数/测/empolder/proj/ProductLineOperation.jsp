<%@ page buffer="4kb" autoFlush="true" errorPage="/notice/error.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.sql.Timestamp" %>
<jsp:useBean id="ProvinceComInfo" class="weaver.hrm.province.ProvinceComInfo" scope="page" />
<jsp:useBean id="SysMaintenanceLog" class="weaver.systeminfo.SysMaintenanceLog" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String operation = Util.fromScreen(request.getParameter("operation"),user.getLanguage());

String id = Util.fromScreen(request.getParameter("id"),user.getLanguage());
String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());
String description = Util.fromScreen(request.getParameter("description"),user.getLanguage());
String o_order = Util.fromScreen(request.getParameter("o_order"),user.getLanguage());
String forServerLine = Util.fromScreen(request.getParameter("forServerLine"),user.getLanguage());
String createPerson = Util.fromScreen(request.getParameter("createPerson"),user.getLanguage());
String dutyNameID = Util.fromScreen(request.getParameter("dutyName"),user.getLanguage());

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);


String sql = "";

if(!"".equals(id)){
	if("delete".equals(operation)){
		sql = "update ProductDictionary set isShow = '1' where id = '"+id+"'";
		RecordSet.executeSql(sql);
	}else{
		sql = "update ProductDictionary set name = '"+name+"',description = '"+description+"',o_order = '"+o_order+"',forServerLine = '"+forServerLine+"',dutyNameID='"+dutyNameID+"' where id = '"+id+"'";
		RecordSet.executeSql(sql);
	}
	response.sendRedirect("ProductLineList.jsp");
 }else {
	 sql = "insert into ProductDictionary(name,isShow,description,o_order,forServerLine,createPerson,dutyNameID,createDate,createTime) values ('"+name+"','0','"+description+"','"+o_order+"','"+forServerLine+"','"+createPerson+"','"+dutyNameID+"','"+CurrentDate+"','"+CurrentTime+"')";
	 if(RecordSet.executeSql(sql)){
		   %>
		   <script>
		   	alert("保存成功");
		   	location.href = 'ProductLineList.jsp';
		   </script>
		   <%	 
		 }else{
			 %>
			   <script>
			   	alert("保存失败");
			   	location.href = 'ProductLineList.jsp';
			   </script>
			   <% 
		 }
// 	 response.sendRedirect("hrmresourceList.jsp");
 }
new BaseBean().writeLog("--------------"+sql);
// response.sendRedirect("ProductLineList.jsp");
%>
