 <%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<%
	String ids = Util.null2String(request.getParameter("idds"));
	String rid = Util.null2String(request.getParameter("rid"));
	String groupid = Util.null2String(request.getParameter("groupid"));
	String groupids [] = groupid.split(",");
	for(int i=0;i<groupids.length;i++){
		String sql = "update uf_hrmgroup set bs = '1'  where id in ("+ids+") and rid = '"+rid+"' and  groupid ='"+groupids[i]+"'";
		rs.executeSql(sql);
		sql = "update uf_hrmgroup set bs = '0'  where id not in ("+ids+") and rid = '"+rid+"' and  groupid ='"+groupids[i]+"'";
		rs.executeSql(sql);
	}
	
%>
