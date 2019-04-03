<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="gw" class="gvo.work.GetWebValue" scope="page"/>
<%
String fphm_s=Util.null2String(request.getParameter("fphm"));
String sql = "";
int sum= 0;

 sql = " select count(*) as sum_s from formtable_main_9_dt1 where fphm='"+fphm_s+"'";
		rs.executeSql(sql);
		if(rs.next()){
			sum= rs.getInt("sum_s");
			
		}

out.println(sum);
%>

