<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="hsproject.util.SysnoUtil"%>
<%@page import="org.json.JSONObject"%>
<%@page import="hsproject.util.ValueTransMethod"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
ValueTransMethod vtm = new ValueTransMethod();
String seqno = Util.null2String(request.getParameter("seqno"));
String fieldid = Util.null2String(request.getParameter("fieldid"));
String newvalue = "";
String oldvalue = "";
String result = "";
String sql = "select newvalue,oldvalue from uf_prj_changedetail where seqno='"+seqno+"'";
rs.executeSql(sql);
if(rs.next()){
 	newvalue = vtm.doTrans2(fieldid,Util.null2String(rs.getString("newvalue")),"0");
 	oldvalue =  vtm.doTrans2(fieldid,Util.null2String(rs.getString("oldvalue")),"0");
	result="{'newvalue':'"+newvalue+"','oldvalue':'"+oldvalue+"'}";
}else{
	result = "null";
}
out.print(result);
%>

