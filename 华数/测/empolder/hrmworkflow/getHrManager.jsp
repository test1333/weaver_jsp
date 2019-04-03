<%@page import="com.mk.webservice.service.WsPostNum"%>
<%@page import="com.mk.webservice.service.WsDepartment"%>
<%@page import="com.mk.webservice.service.WsEmployee"%>
<%@page import="weaver.leadership.GetHrEmployeeUtil"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
String titlecode = request.getParameter("titlecode");

new BaseBean().writeLog(">>>>>>>titlecode>>>>>>>>"+titlecode);

GetHrEmployeeUtil ghe = new GetHrEmployeeUtil();
WsDepartment wsd[] =  ghe.getWSDepartmentByPostId(titlecode);
WsEmployee title[] = ghe.getWsEmployeeBypostId(titlecode);
WsPostNum wsp[] = ghe.getNumByPostCode(titlecode);

WsEmployee we;
String names = "";
String depnames = "";
String gwnames = "";
String zjnames = "";
String jobNumbers = "";

new BaseBean().writeLog(">>>>>>>wsp[0]>>>>>>>>"+wsp);
Integer budgetnumber = wsp[0].getBudgetnumber();
Integer employeenum = wsp[0].getEmployeenum();


depnames = wsd[0].getDeptname();
for(int i = 0;i<title.length;i++){
 	we = title[i];
 	names += we.getName()+",";
 	depnames = we.getDeptname();
 	gwnames = we.getPostname();
 	zjnames = we.getRankidname();
}
StringBuffer json = new StringBuffer();
new BaseBean().writeLog(">>>>>>>names>>>>>>>>"+names);
		json.append("{");
		json.append("'names':").append("'").append(names).append("'").append(",");
		json.append("'budgetnumber':").append("'").append(budgetnumber).append("'").append(",");
		json.append("'employeenum':").append("'").append(employeenum).append("'").append(",");
		json.append("'depname':").append("'").append(depnames).append("'").append(",");
		json.append("'gwname':").append("'").append(gwnames).append("'").append(",");
		json.append("'zjname':").append("'").append(zjnames).append("'");
		json.append("}");
		
		out.println(json.toString());
%>

