<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String khsh = Util.null2String(request.getParameter("khsh"));//客户税号
	String billid = Util.null2String(request.getParameter("billid"));//客户税号
	int v_num = 0;
	if(!"".equals(billid)){
		if (!"".equals(khsh)){
			String sql = " select count(*) as z_num from formtable_main_2470 where khsh='"+khsh+"' and id <>"+billid+" ";
			rs.executeSql(sql);
			log.writeLog("log.sql---------" + sql);
			if(rs.next()){
				v_num = rs.getInt("z_num");
			}
		}
	}else{
		if (!"".equals(khsh)) {
			String sql = " select count(*) as z_num from formtable_main_2470 where khsh='"+khsh+"' ";
			rs.executeSql(sql);
			log.writeLog("log.sql---------" + sql);
			if(rs.next()) {
				v_num = rs.getInt("z_num");
			}
		}
	}
    out.println(v_num);
%>