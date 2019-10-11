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
String rqid = Util.null2String(request.getParameter("rqid"));
String tablename_rk = gg.getTableName("RKD");//入库单
String tablename_dd = gg.getTableName("CGDD");//订单
String tablename_ht = gg.getTableName("FKJHT");//非框架合同
String result = "0";
String sfys = "";
String htrqid = "";
String htmxid = "";
int count =0;
String sql_dt = "";
String sql="select e.sfys,d.requestid as htrqid,e.id as htmxid  from "+tablename_rk+"  a,"+tablename_rk+"_dt1 b ,"+tablename_dd+" c,"+tablename_ht+" d,"+tablename_ht+"_dt1 e" + 
				"	where a.id=b.mainid  and b.cgsqd = c. requestid and c.contactReq = d.requestid and d.id=e.mainid and c.contactDtId=e.id and a.requestid in("+rqid+")";
rs.executeSql(sql);
if(rs.next()){
	sfys = Util.null2String(rs.getString("sfys"));
	htrqid = Util.null2String(rs.getString("htrqid"));
	htmxid = Util.null2String(rs.getString("htmxid"));
}
//log.writeLog("sfys:"+sfys);
if(!"1".equals(sfys)){
	result = "0";
}else{
	sql = "select b.id from "+tablename_ht+" a,"+tablename_ht+"_dt1 b where a.id=b.mainid and a.requestid='"+htrqid+"' and b.id<"+htmxid;
	//log.writeLog("sfys sql:"+sql);
	rs.executeSql(sql);
	while(rs.next()){
		String ctdtid = Util.null2String(rs.getString("id"));
		sql_dt = "select count(a.id) as count from "+tablename_rk+"  a,"+tablename_rk+"_dt1 b,"+tablename_dd+" c ,workflow_requestbase d where a.id=b.mainid  and b.cgsqd = c. requestid and a.requestid = d.requestid and d.currentnodetype>=3  and  c.contactDtId="+ctdtid;
		//log.writeLog("sfys sql_dt:"+sql_dt);
		rs_dt.executeSql(sql_dt);
		if(rs_dt.next()){
			count = rs_dt.getInt("count");
		}
		if(count == 0){
			result = "1";
		}
	}
}
	out.print(result);
%>