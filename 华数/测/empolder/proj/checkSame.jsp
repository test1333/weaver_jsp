<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rec" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

StringBuffer json = new StringBuffer();
String nameID = request.getParameter("nameID");//��Ʒ������ID
String vval = request.getParameter("vval");//��Ʒ�߰汾
// new BaseBean().writeLog(">>>>>>>"+nameID+">>>>>>>>"+vval);

String cvval = vval.toLowerCase();

if(!"".equals(nameID) && nameID != null && !"".equals(vval) && vval != null){	
	String isHave = "";
	 String sql = "select * from projectInfo where name = '"+nameID+"' and upper(version) = upper('"+vval+"')";
	 rs.executeSql(sql);
	 if(rs.next()){
		 isHave = "Y";
	 }
	 
		json.append("{");
		json.append("'isHave':").append("'").append(isHave).append("'");
		json.append("}");
		
		out.println(json.toString());
}
%>

