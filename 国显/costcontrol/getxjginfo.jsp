<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%

BaseBean log = new BaseBean();
String cgddhs = Util.null2String(request.getParameter("cgddlcs"));
		if("".equals(cgddhs)){
			out.print("");
		}
		StringBuffer dataBuff = new StringBuffer();
		String tableName = "";
		String tableName2 = "";
		String cdbm = "";
		String cdbmmc = "";
		String km = "";
		String kmmc = "";
		String sql_dt = "";
		String  sql="select tablename from workflow_bill where id in (select formid from workflow_base where id = (select distinct workflowid from workflow_requestbase where requestid in("+cgddhs+")))";
		rs.executeSql(sql);
		if(rs.next()){
			tableName = Util.null2String(rs.getString("tablename"));
		}
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		sql="select distinct '1' as fycdzt,c.CDBM,c.QJ,c.yskm,c.CGSQDH,c.MXHID,(select nvl(sum(nvl(je,0)),0) from uf_pr_budget where cgsqdh=c.cgsqdh and mxhid=c.mxhid) as sumje  "+
		    " from "+tableName+" a,"+tableName+"_dt1 b , uf_pr_budget c  "+
			" where a.id=b.mainid "+
 			"   and  a.requestid=c.lcid "+
 			"   and  b.purrequest=c.cgsqdh "+
 			"   and  b.reqproject=c.mxhid "+
            "   and  (select nvl(sum(nvl(je,0)),0) from uf_pr_budget where cgsqdh=c.cgsqdh and mxhid=c.mxhid)>0 "+
            "   and  nvl(c.je,0)>0  and a.requestid in("+cgddhs+")";
		rs.executeSql(sql);
		while(rs.next()){		
			dataBuff.append(Util.null2String(rs.getString("FYCDZT")));//费用承担主体
			dataBuff.append("###");
			cdbm = Util.null2String(rs.getString("CDBM"));
			dataBuff.append(cdbm);//费用承担部门
			dataBuff.append("###");
			sql_dt = "select departmentname from hrmdepartment where id='"+cdbm+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				cdbmmc = Util.null2String(rs_dt.getString("departmentname"));
			}
			dataBuff.append(cdbmmc);//费用承担部门
			dataBuff.append("###");
			dataBuff.append(Util.null2String(rs.getString("QJ")));//费用所属期间
			dataBuff.append("###");
			km = Util.null2String(rs.getString("yskm"));
			dataBuff.append(km);//预算科目
			dataBuff.append("###");
			sql_dt = "select name from FnaBudgetfeeType where id='"+km+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				kmmc = Util.null2String(rs_dt.getString("name"));
			}
			dataBuff.append(kmmc);//预算科目
			dataBuff.append("###");
			dataBuff.append(Util.null2String(rs.getString("CGSQDH")));//采购申请单号
			dataBuff.append("###");
			dataBuff.append(Util.null2String(rs.getString("MXHID")));//项目号
			dataBuff.append("###");
			dataBuff.append(Util.null2String(rs.getString("sumje")));//冻结金额
			dataBuff.append("@@@");
		}
		
	
    out.print(dataBuff.toString());
%>

