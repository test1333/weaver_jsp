<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String idkey = request.getParameter("idkey");//idֵ
String comment = request.getParameter("name");//��ע
String num = request.getParameter("num");//��������

String sql = "update uf_checkrecord_dt1 set monitornum="+num+", commenton = '"+comment+"' where id = "+idkey+"";
    rs.executeSql(sql);

%>
<script type="text/javascript">
	var parentWin;
	try{
		parentWin = parent.getParentWindow(window);
		parentWin.closeDlgARfsh();
	}catch(e){
		window.close();
	}
</script>
