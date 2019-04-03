<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="goodbaby.pz.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<%
	GetGNSTableName gg = new GetGNSTableName();
	String cgddtablename = gg.getTableName("CGDD");
	String rkddtablename = gg.getTableName("RKD");
	String ids = Util.null2String(request.getParameter("ids"));
	int count =0;
	String sql = "select count(1) as count from (select  distinct contactReq  from "+cgddtablename+" where requestid in (select b.cgsqd from "+rkddtablename+" a join "+rkddtablename+"_dt1  b on b.mainid =a.id where a.id in("+ids+") )) a";
	res.executeSql(sql);
	if(res.next()){
		count = res.getInt("count");
	}
	if(count > 1){
		out.print("1");
	}else{
		out.print("0");
	}
	//out.print("--ids--"+ids);
	//String idarray [] =ids.split(",");
	//String htrid = "";//合同rid
	//String htrid1 = "";//
//	for(int i =0 ;i<idarray.length;i++){
	//	String sql = "select contactReq  from formtable_main_240 where requestid in (select b.cgsqd from formtable_main_243 a join formtable_main_243_dt1  b on b.mainid =a.id where a.id ='"+idarray[i]+"' )";
	//	res.executeSql(sql);
	//	if(res.next()){
	//		if(i==0){
	//			htrid = Util.null2String(res.getString("contactReq"));
	//		}else{
	//			htrid1 = Util.null2String(res.getString("contactReq"));
	//		}
	//	}
	//	if(!htrid.equals(htrid1) && !htrid.equals("") && !htrid1.equals("")){
	//		out.print("1");
	//		return;
	//	}
		
	//}
%>