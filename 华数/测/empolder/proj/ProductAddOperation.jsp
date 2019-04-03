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

String num = Util.fromScreen(request.getParameter("num"),user.getLanguage());
String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());
String version = Util.fromScreen(request.getParameter("version"),user.getLanguage());
String forLine = Util.fromScreen(request.getParameter("forLine"),user.getLanguage());
String priority = Util.fromScreen(request.getParameter("priority"),user.getLanguage());
String timeLine = Util.fromScreen(request.getParameter("timeLine"),user.getLanguage());
String execution = Util.fromScreen(request.getParameter("execution"),user.getLanguage());
String overTime = Util.fromScreen(request.getParameter("overTime"),user.getLanguage());
String productManager = Util.fromScreen(request.getParameter("productManager"),user.getLanguage());
String projectManager = Util.fromScreen(request.getParameter("projectManager"),user.getLanguage());
String members = Util.fromScreen(request.getParameter("members"),user.getLanguage());
String target = Util.fromScreen(request.getParameter("target"),user.getLanguage());

String[] quesid = request.getParameterValues("quesid");//问题主键ID
String[] chanid = request.getParameterValues("chanid");//变更主键ID
String[] description1 = request.getParameterValues("description1");//问题描述1
String[] description2 = request.getParameterValues("description2");//变更描述1

String sql = "";

if(!"".equals(id)){
	if("delete".equals(operation)){
		sql = "update projectInfo set isShow = '1' where id = '"+id+"'";
		RecordSet.executeSql(sql);
	}else{
		sql = "update projectInfo set num = '"+num+"',name='"+name+"',forLine = '"+forLine+"',version = '"+version+"',priority = '"+priority+"',timeLine = '"+timeLine+"',execution = '"+execution+"',overTime = '"+overTime+"',productManager = '"+productManager+"',projectManager = '"+projectManager+"',members = '"+members+"',target = '"+target+"' where id = '"+id+"'";
		RecordSet.executeSql(sql);
		/* if(quesid != null && quesid.length > 0){
			for(int i = 0;i < quesid.length ; i++){
					sql = "UPDATE questionInfo SET description1 = '" + description1[i] + "' WHERE ID = '" + quesid[i] + "'";
					RecordSet.executeSql(sql);
			}
		}
		if(chanid != null && chanid.length > 0){
			for(int i = 0;i < chanid.length ; i++){
					sql = "UPDATE changeInfo SET description1 = '" + description2[i] + "' WHERE ID = '" + chanid[i] + "'";
					RecordSet.executeSql(sql);
			}
		} */
	}
	response.sendRedirect("ProductList.jsp");
 }else {
	 sql = "insert into projectInfo(num,name,version,forLine,priority,timeLine,execution,overTime,productManager,projectManager,members,target,isShow) values ('"+num+"','"+name+"','"+version+"','"+forLine+"','"+priority+"','"+timeLine+"','"+execution+"','"+overTime+"','"+productManager+"','"+projectManager+"','"+members+"','"+target+"','0')";
	 if(RecordSet.executeSql(sql)){
		   %>
		   <script>
		   	alert("保存成功");
		   	location.href = 'ProductList.jsp';
		   </script>
		   <%	 
		 }else{
			 %>
			   <script>
			   	alert("保存失败");
			   	location.href = 'ProductList.jsp';
			   </script>
			   <% 
		 }
// 	 response.sendRedirect("hrmresourceList.jsp");
 }
new BaseBean().writeLog(sql);
// response.sendRedirect("ProductList.jsp");
%>
