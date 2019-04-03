<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String differid_detail = request.getParameter("ids");
String checkid = request.getParameter("checkid");
String idx = differid_detail+"-1";

		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=0";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = "delete from uf_InHandleRd where mainid in ("+idx+")";
		rs.executeSql(sql_delrd);

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

