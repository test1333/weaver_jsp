<%@ page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.*"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="weaver.conn.*"%>
<%@ page import="org.apache.commons.lang.*" %>
<%
response.setContentType("application/json;charset=UTF-8");
BaseBean base=new BaseBean();
String email = Util.null2String(request.getParameter("email")).trim();

RecordSet rs =new RecordSet();
	String sqlWhere = " where 1=1 ";
	sqlWhere+= " and  lower(rtrim(ltrim(useremail ))) = '" + email.trim().toLowerCase() + "'   and  (nvl(currentstatus, -1) = -1 or (nvl(currentstatus, -1) = 0 and  lower(rtrim(ltrim(creater)))  = '"+ email.trim().toLowerCase() +"'))   ";
rs.executeSql("select count(1) as num from FOSUN_INTEGRATION_VIEW"+sqlWhere);
int isexist=rs.getCounts();
String num="";
if(isexist>0){
	rs.next();
	num=rs.getString("num");
}else{
	num="0";
}

RecordSetDataSource rs2 = new RecordSetDataSource("E7OA");
	String sqlWhere2 = " where 1=1 ";
	sqlWhere2+= " and  lower(rtrim(ltrim(useremail ))) = '" + email.trim().toLowerCase() + "'   and  (nvl(currentstatus, -1) = -1 or (nvl(currentstatus, -1) = 0 and  lower(rtrim(ltrim(creater)))  = '"+ email.trim().toLowerCase() +"'))   ";
rs2.executeSql("select count(1) as num from FOSUN_INTEGRATION_E7VIEW"+sqlWhere2);
int isexist2=rs2.getCounts();
String num2="";
if(isexist2>0){
	rs2.next();
	num2=rs2.getString("num");
}else{
	num2="0";
}

int sum = Util.getIntValue(num) + Util.getIntValue(num2);

Map result = new HashMap();
result.put("num", sum);
JSONObject jo = JSONObject.fromObject(result);
out.println(jo);
%>