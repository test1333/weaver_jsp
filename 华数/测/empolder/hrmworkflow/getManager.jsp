<%@page import="com.mk.webservice.service.WsEmployee"%>
<%@page import="weaver.leadership.GetHrEmployeeUtil"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
User user = HrmUserVarify.checkUser(request,response);//获取当前登录者
String loginid = String.valueOf(user.getUID());
//User user1 = (User)request.getSession().getAttribute("weaver_user@bean");//获取当前登录者
new BaseBean().writeLog(">>>>>>>loginid>>>>>>>>"+loginid);
GetHrEmployeeUtil ghe = new GetHrEmployeeUtil();
WsEmployee we =  ghe.getWsEmployeeByLoginId("0789");

// String departmentcode = "ws1001";
String depid = request.getParameter("depid");
String year = request.getParameter("nfv");
String imptype = request.getParameter("amOrpmv");
// new BaseBean().writeLog(">>>>>>>depid>>>>>>>>"+depid+">>>>>>>year>>>>>>>>"+year+">>>>>>>imptype>>>>>>>>"+imptype);
StringBuffer json = new StringBuffer();
String titlecodes = "";
	 String sql = "select titlecode from ls_title where deleted is null and (departmentcode = (select hrdepartmentcode from hrmdepartment where id = '"+depid+"') or departmentcode in (select hrdepartmentcode from hrmdepartment where supdepid = '"+depid+"' and hrdepartmentcode is not null)) and impyear = '"+year+"' and imptype = '"+imptype+"' order by titlecode";
	 new BaseBean().writeLog(">>>>>>>sql>>>>>>>>"+sql);	 
	 rs.executeSql(sql);
		 while(rs.next()){
			 titlecodes += rs.getString("titlecode")+",";
		 }
// new BaseBean().writeLog(">>>>>>>titlecodes>>>>>>>>"+titlecodes);
		json.append("{");
		json.append("'titlecodes':").append("'").append(titlecodes).append("'");
		json.append("}");
		
		out.println(json.toString());
%>

