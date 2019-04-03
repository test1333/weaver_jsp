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
    String qf = request.getParameter("qf");
	String xgid = request.getParameter("xgid");
	String xgseq = request.getParameter("xgseq");
	 SysNoForSelf sns = new SysNoForSelf();
	 String result="";
	 if("0".equals(qf)){
	 result = sns.getNum("EDT", "uf_edit_contact", 5);
	 }
	  if("1".equals(qf)){
	   String sfbj = "";
	   String sql="select sfbj from uf_edit_contact where xgseq='"+xgseq+"' and xgid='"+xgid+"'";
	   rs.executeSql(sql);
	   if(rs.next()){
          sfbj = Util.null2String(rs.getString("sfbj"));
	   }
	   result = sfbj;
	 }
		 
	out.print(result); 
%>