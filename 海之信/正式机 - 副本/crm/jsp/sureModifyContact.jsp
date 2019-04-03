<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="seahonor.util.SysNoForSelf" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
    String ssjt = request.getParameter("ssjt");
	 String lx = request.getParameter("lx");
	 String qf = request.getParameter("qf");
	 StringBuffer sb = new StringBuffer();
	 SysNoForSelf sns = new SysNoForSelf();
	 if("".equals(ssjt)||"".equals(lx)){
		 out.print(sb.toString()); 
	 }
	 String lxr="";
	 String name = "";
	 String sql="";
	 if("1".equals(qf)){
		 sql="select id,name from uf_contacts where superid is null and GroupName='"+ssjt+"' and (customName is null or customName = '' or lxrcm = '0' ) "+
		 " and dbo.gs_status(dealStatus,'"+lx+"')='1' order by dealStatus asc";
     }
	 if("0".equals(qf)){
		 sql="select id,name from uf_contacts where superid is null and  customName='"+ssjt+"' and dbo.gs_status(dealStatus,'"+lx+"')='1' order by dealStatus asc ";
	 }
	rs.executeSql(sql);
	while(rs.next()){
         lxr = Util.null2String(rs.getString("id"));
		 name = Util.null2String(rs.getString("name"));
		 String sysNo = sns.getNum("EDT", "uf_edit_contact", 5);
		sb.append(lxr);
		sb.append("###");
		sb.append(name);
		sb.append("###");
		sb.append(sysNo);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>