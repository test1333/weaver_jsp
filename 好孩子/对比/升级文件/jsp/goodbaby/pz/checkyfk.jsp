<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<%@ page import="goodbaby.pz.GetGNSTableName"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
BaseBean log = new BaseBean();
GetGNSTableName gg = new GetGNSTableName();
String yfkxx = Util.null2String(request.getParameter("yfkxx"));
String tablename_rk = gg.getTableName("RKD");//入库单
String tablename_dd = gg.getTableName("CGDD");//订单
String result = "0";
int count = 0;
String sql="select count(b.id) as count from "+tablename_rk+" a,"+tablename_rk+"_dt1 b,workflow_requestbase c where a.id=b.mainid and a.requestid=c.requestid and c.currentnodetype=3 and b.cgsqd=(select requestid from "+tablename_dd+" where contactdtid = '"+yfkxx+"')";
rs.executeSql(sql);
if(rs.next()){
	count = rs.getInt("count");
}
if(count >0){
	result = "1";
}
out.print(result);
%>