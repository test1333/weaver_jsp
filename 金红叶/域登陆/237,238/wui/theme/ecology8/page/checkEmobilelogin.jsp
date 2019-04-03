<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%

BaseBean log = new BaseBean();
String result = "0";
int count = 0;
String loginid = Util.null2String(request.getParameter("loginid"));
String field139="";//
String sql="select b.field139 from hrmresource a,cus_fielddata b where a.id=b.id and a.loginid='"+loginid+"' and b.scopeid=-1 and b.scope='HrmCustomFieldByInfoType'";
rs.executeSql(sql);
if(rs.next()){
	field139 = Util.null2String(rs.getString("field139"));
}
if("1".equals(field139)){
	result="1";
}
out.print(result);
%>

