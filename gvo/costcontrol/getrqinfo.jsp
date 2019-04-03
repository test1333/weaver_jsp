<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%

BaseBean log = new BaseBean();
String cgddhs = Util.null2String(request.getParameter("cgddhs"));
String type = Util.null2String(request.getParameter("type"));
if("".equals(cgddhs)||"".equals(type)){
	out.print("");
}
 StringBuffer dataBuff = new StringBuffer();
String workflowid = "";
String tableName = "";
String rqname="";
String rqid="";
String sql="select wfid from uf_purchase_flow_mt where code='"+type+"'";
rs.executeSql(sql);
if(rs.next()){
	workflowid = Util.null2String(rs.getString("wfid"));
}
sql = " select tablename from workflow_bill where id in (select formid from workflow_base where id = "
				+ workflowid + ")";
rs.execute(sql);
if (rs.next()) {
	tableName = Util.null2String(rs.getString("tablename"));
}
sql="select a.orderno,a.requestid,b.requestnamenew from "+tableName+" a,workflow_requestbase b where a.requestid=b.requestid and a.orderno in("+cgddhs+")";
rs.executeSql(sql);
while(rs.next()){
	rqname = Util.null2String(rs.getString("requestnamenew"));
	rqid = Util.null2String(rs.getString("requestid"));
	dataBuff.append(rqname);
	dataBuff.append("###");
	dataBuff.append(rqid);
	dataBuff.append("@@@");
}
out.print(dataBuff.toString());
%>

