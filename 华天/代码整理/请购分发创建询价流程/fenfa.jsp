<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
   // BaseBean log = new BaseBean();
    String ids = request.getParameter("id");
	String cgjl = request.getParameter("cgjl");
	String cgy = request.getParameter("cgy");
	ids=ids+"0";
    String sql ="update uf_data_qinggou set status='1',cgjl='"+cgjl+"',cgy='"+cgy+"' where id in("+ids+")";
	//log.writeLog("不处理"+sql);
	RecordSet.executeSql(sql);
	out.print(ids);
%>