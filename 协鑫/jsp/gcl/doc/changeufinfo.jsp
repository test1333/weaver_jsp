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
	String depid = Util.null2String(request.getParameter("depid"));
	String rid = Util.null2String(request.getParameter("rid"));
	String type = Util.null2String(request.getParameter("type"));
	String zjbz = Util.null2String(request.getParameter("zjbz"));
	String fbz = Util.null2String(request.getParameter("fbz"));	
	if(type.equals("0")){//更改部门
		String depids [] = depid.split(",");
		for(int i=0;i<depids.length;i++){
			String sql = "update uf_hrdept set bs = '1'  where id in ("+ids+") and rid = '"+rid+"' and  departmentid ='"+depids[i]+"'";
			rs.executeSql(sql);
			sql = "update uf_hrdept set bs = '0'  where id not in ("+ids+") and rid = '"+rid+"' and  departmentid ='"+depids[i]+"'";
			rs.executeSql(sql);
		}
	}else if(type.equals("1")){//自动组
		String zjbzs [] = zjbz.split(",");
		for(int i=0;i<zjbzs.length;i++){
			String sql = "update uf_hrzdyz set bs = '1'  where id in ("+ids+") and rid = '"+rid+"' and  zjbz ='"+zjbzs[i]+"'";
			rs.executeSql(sql);
			sql = "update uf_hrzdyz set bs = '0'  where id not in ("+ids+") and rid = '"+rid+"' and  zjbz ='"+zjbzs[i]+"'";
			rs.executeSql(sql);
		}
	}else if(type.equals("2")){//分部组
		String fbzs [] = fbz.split(",");
		for(int i=0;i<fbzs.length;i++){
			String sql = "update uf_hrfbz set bs = '1'  where id in ("+ids+") and rid = '"+rid+"' and  subcompanyid1 ='"+fbzs[i]+"'";
			rs.executeSql(sql);
			sql = "update uf_hrfbz set bs = '0'  where id not in ("+ids+") and rid = '"+rid+"' and  subcompanyid1 ='"+fbzs[i]+"'";
			rs.executeSql(sql);
		}
	}
	
	
%>

