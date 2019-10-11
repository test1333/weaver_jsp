<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="goodbaby.pz.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	GetGNSTableName gg = new GetGNSTableName();
	String tablename = gg.getTableName("RKD");
	String cgddtable = gg.getTableName("CGDD");
	String ids = Util.null2String(request.getParameter("ids"));
	String type = Util.null2String(request.getParameter("type"));
	int count = 0;
	String sql = "";
	if("lx".equals(type)){
		sql = "select count(1) as count from (select zjlbm from "+tablename+" where id in("+ids+") group by zjlbm) a";
		rs.executeSql(sql);
		if(rs.next()){
			count = rs.getInt("count");
		}
		if(count >1){
			out.print("1");
			return;
		}
		count = 0;
		sql = "select count(1) as count from (select SHCK from "+tablename+" where id in("+ids+") group by SHCK) a";
		rs.executeSql(sql);
		if(rs.next()){
			count = rs.getInt("count");
		}
		if(count >1){
			out.print("3");
			return;
		}
	}
	count = 0;
	sql  = "select count(1) as count from (select c.biz  from "+tablename+" a, "+tablename+"_dt1 b,"+cgddtable+" c  where a.id=b.mainid and b.cgsqd=c.requestid and a.id in("+ids+")  group by c.biz) a";
	rs.executeSql(sql);
	if(rs.next()){
		count = rs.getInt("count");
	}
	if(count >1){
		out.print("2");
		return;
	}

	out.print("0");
		
	


%>