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
String field59="";//
String sql="select b.field59 from hrmresource a,cus_fielddata b where a.id=b.id and a.loginid='"+loginid+"' and b.scopeid=-1 and b.scope='HrmCustomFieldByInfoType'";
rs.executeSql(sql);
if(rs.next()){
	field59 = Util.null2String(rs.getString("field59"));
}
if("1".equals(field59)){
	result="1";
}
out.print(result);
%>

