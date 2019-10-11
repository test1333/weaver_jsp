<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<%@ page import="goodbaby.pz.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
BaseBean log = new BaseBean();
GetGNSTableName gg = new GetGNSTableName();
String yjcbzx = Util.null2String(request.getParameter("yjcbzx"));
String begindate = Util.null2String(request.getParameter("begindate"));
String enddate = Util.null2String(request.getParameter("enddate"));
String scr = Util.null2String(request.getParameter("scr"));
String tablename = gg.getTableName("RKD");
String rqids = "";
String flag = "";
int count =0;
String sql = "select count(1) as count from "+tablename+" a,workflow_requestbase b "+
"where a.requestid=b.requestid and a.cgdl='1' and b.currentnodetype=3 and (select yjcbzx from uf_cbzx where id=a.cbzx) = '"+yjcbzx+"' and b.lastoperatedate<='"+enddate+"' and b.lastoperatedate>='"+begindate+"'";
rs.executeSql(sql);
if(rs.next()){
	count = rs.getInt("count");
}
if(count <=0){
	out.print("1");
	return;
}
out.print("0");
%>