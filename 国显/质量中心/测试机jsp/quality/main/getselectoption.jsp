<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.javen.Util.Util"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="com.javen.Util.RecordSet" scope="page"/>
<%
	String lx = Util.null2String(request.getParameter("lx"));
	StringBuffer sb = new StringBuffer();
	String sql = "";
	sb.append("<option value=''></option>");
	if("khmc".equals(lx)){
		sql = "select distinct cus_name from uf_kskx_customer order by cus_name asc";
		rs.executeQuery(sql);
		while(rs.next()){
			String cus_name = Util.null2String(rs.getString("cus_name"));
			if(!"".equals(cus_name)){
				sb.append("<option value='"+cus_name+"'>"+cus_name+"</option>");
			}
		}
	}
	out.print(sb.toString());
%>